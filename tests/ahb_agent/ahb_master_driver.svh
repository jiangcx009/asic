`ifndef AHB_MASTER_DRIVER_SVH_
`define AHB_MASTER_DRIVER_SVH_

class ahb_master_drv extends uvm_driver #(ahb_trans);
    virtual ahb_if_t    ahb_master_if;
    
    //uvm_analysis_port #(ahb_trans)      ahb_master_port;   //connect to reference model, move to monitor

    `uvm_component_utils(ahb_master_drv)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task reset_phase(uvm_phase phase);
    extern         task drive_ahb_bus(ahb_trans req);
    extern         task wait_4_hready_resp( ref bit error);
endclass : ahb_master_drv

function void ahb_master_drv::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if ( !uvm_config_db#(virtual ahb_if_t)::get(this, "", "ahb_if_t", ahb_master_if))
        `uvm_fatal("ahb_master_drv", "Error in Getting interface");
endfunction

task ahb_master_drv::reset_phase(uvm_phase phase);
    super.reset_phase(phase);

    //phase.raise_objection(this);
    wait(ahb_master_if.MONPORT.ahb_slv_hreset_n)
#100;
    repeat(100) @(ahb_master_if.master_cb);
    `uvm_info(get_full_name(), "AHB Reset Rised", UVM_LOW)

    ahb_master_if.master_cb.ahb_slv_haddr     <= `AHB_ADDR_WIDTH  'b0;
    ahb_master_if.master_cb.ahb_slv_hsize     <= `AHB_SIZE_WIDTH  'b0;
    ahb_master_if.master_cb.ahb_slv_hburst    <= `AHB_BURST_WIDTH 'b0;
    ahb_master_if.master_cb.ahb_slv_hwrite    <= 1                'b0;
    ahb_master_if.master_cb.ahb_slv_htrans    <= `AHB_TYPE_WIDTH  'b0;
    ahb_master_if.master_cb.ahb_slv_hwdata    <= `AHB_DATA_WIDTH  'b0;
    @(ahb_master_if.master_cb);

    //phase.drop_objection(this);
endtask : reset_phase

task ahb_master_drv::drive_ahb_bus(ahb_trans req);
    integer     time_out = 0;
    bit         error = 0;

    @(ahb_master_if.master_cb);
    wait_4_hready_resp(error);

    //`uvm_info(get_full_name(), "set delay", UVM_LOW)
    ahb_master_if.master_cb.ahb_slv_haddr     <= req.ahb_addr;
    ahb_master_if.master_cb.ahb_slv_hwrite    <= req.ahb_dirct;
    //ahb_master_if.master_cb.ahb_slv_htrans    <= req.ahb_tran;
    //ahb_master_if.master_cb.ahb_slv_hsize     <= #1ps req.ahb_size;
    //ahb_master_if.master_cb.ahb_slv_hburst    <= #1ps req.ahb_burst;

	// support only
    ahb_master_if.master_cb.ahb_slv_hsize     <= 2;
    ahb_master_if.master_cb.ahb_slv_hburst    <= 1;
    ahb_master_if.master_cb.ahb_slv_htrans    <= 2;

    //data delay
	repeat(req.ahb_delay) @(ahb_master_if.master_cb);
    //while ( req.ahb_delay ) begin
    //    @(ahb_master_if.master_cb);
    //    req.ahb_delay--;
    //end

    @(ahb_master_if.master_cb);
    //wait(ahb_master_if.master_cb.slv_ahb_hready);
    
    ahb_master_if.master_cb.ahb_slv_htrans    <= IDLE;
    if ( ahb_master_if.MSTPORT.ahb_slv_hwrite === WRITE)
        ahb_master_if.master_cb.ahb_slv_hwdata <= req.ahb_data;
    else begin
        wait_4_hready_resp(error);
        req.ahb_data <= ahb_master_if.master_cb.slv_ahb_hrdata;
    end

    //$display("%0m :: addr:%x, write:%x, data:%x", ahb_master_if.MSTPORT.ahb_slv_haddr, ahb_master_if.MSTPORT.ahb_slv_hwrite, ahb_master_if.MSTPORT.slv_ahb_hrdata);
    //@(ahb_master_if.master_cb);
    wait_4_hready_resp(error);
    @(ahb_master_if.master_cb);

endtask : drive_ahb_bus

task ahb_master_drv::main_phase(uvm_phase phase);
    $display("%0m :: main phase");
    super.main_phase(phase);

    while(1) begin
        seq_item_port.get_next_item(req);
        drive_ahb_bus(req);
        //ahb_master_port.write(req);  // send transaction to reference model
        seq_item_port.item_done();
    end
endtask

task ahb_master_drv::wait_4_hready_resp( ref bit error );
    integer clk_counter = 10000 ;
    @ ( ahb_master_if.master_cb ) ;
    while ( ahb_master_if.master_cb.slv_ahb_hready !== 1'b1 || ahb_master_if.master_cb.slv_ahb_hresp !== 0) begin
        @ (ahb_master_if.master_cb) ;
        clk_counter --;
        if ( clk_counter == 0 ) begin
            $display ("%0d %0m Timed out waiting for hready and okay resp " , $time ) ;
            break ;
        end    
        if(ahb_master_if.master_cb.slv_ahb_hresp === 1) begin
            `uvm_info(get_full_name(), "ahb salve has no resp", UVM_LOW)
            error = 1'b1;
            break;
        end    
    end // while
endtask
`endif
