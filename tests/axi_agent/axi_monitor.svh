`ifndef AXI_MONITOR_SVH_
`define AXI_MONITOR_SVH_

class axi_monitor extends uvm_monitor;
    virtual axi_if_t    axi_slave_if;
    uvm_analysis_port #(axi_trans) axi_slave_port;
    uvm_blocking_get_port #(axi_trans) mon2scb_port;

    int                 dbg_flag;  // 1:i_monitor 0:o_monitor

    `uvm_component_utils(axi_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task          main_phase(uvm_phase phase);
    extern         task          collect_read_cmd(axi_trans req);
    extern         task          collect_read_data(axi_trans req);
    extern         task          collect_write_cmd(axi_trans req);
    extern         task          collect_write_data(axi_trans req);
    //extern         task          collect_write_resp(axi_trans req);
endclass

function void axi_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if ( !uvm_config_db #(virtual axi_if_t)::get(this, "", "axi_if_t", axi_slave_if))
        `uvm_fatal("axi_monitor::build_phase", "Error in get interface");

    axi_slave_port = new("axi_slave_port", this);
    //mon2scb_port = new("mon2scb_port", this);
endfunction

task axi_monitor::main_phase(uvm_phase phase);
    axi_trans       axi_slave_req;   
    super.main_phase(phase);
    axi_slave_req = new("axi_slave_req");

    while(1) begin
        fork
            //collect_read_cmd(axi_slave_req);
            //collect_read_data(axi_slave_req);
            //collect_write_cmd(axi_slave_req);
            collect_write_data(axi_slave_req);
            //collect_write_resp(axi_slave_req);
        join_any
        axi_slave_port.write(axi_slave_req); //write to reference model/scb
        //`uvm_info("axi_monitor", "send monitor data to reference", UVM_LOW)
        if ( dbg_flag == 0 )
            $display("%0m :: collect data:%x", axi_slave_req.axi_wdata);
    end
endtask

task axi_monitor::collect_read_cmd(axi_trans req);
    while( !axi_slave_if.MONPORT.arready || !axi_slave_if.MONPORT.arvalid )
        @(axi_slave_if.cb);

    req.axi_araddr  = axi_slave_if.MONPORT.araddr;
    req.axi_arid    = axi_slave_if.MONPORT.arid;
    req.axi_arlen   = axi_slave_if.MONPORT.arlen;
    req.axi_arsize  = axi_slave_if.MONPORT.arsize;
    req.axi_arburst = axi_slave_if.MONPORT.arburst;
    @(axi_slave_if.cb);

endtask

task axi_monitor::collect_read_data(axi_trans req);
    while( !axi_slave_if.MONPORT.rready || !axi_slave_if.MONPORT.rvalid )
        @(axi_slave_if.cb);

    req.axi_rdata   = axi_slave_if.MONPORT.rdata;
    req.axi_rid     = axi_slave_if.MONPORT.rid;
    @(axi_slave_if.cb);
endtask

task axi_monitor::collect_write_cmd(axi_trans req);
    while( !axi_slave_if.MONPORT.awready || !axi_slave_if.MONPORT.awvalid )
        @(axi_slave_if.cb);

    req.axi_awaddr  = axi_slave_if.MONPORT.awaddr;
    req.axi_awid    = axi_slave_if.MONPORT.awid;
    req.axi_awlen   = axi_slave_if.MONPORT.awlen;
    req.axi_awsize  = axi_slave_if.MONPORT.awsize;
    req.axi_awburst = axi_slave_if.MONPORT.awburst;
    @(axi_slave_if.cb);
endtask

task axi_monitor::collect_write_data(axi_trans req);
    while( !axi_slave_if.MONPORT.wready || !axi_slave_if.MONPORT.wvalid )
        @(axi_slave_if.cb);
    //$display("%0m :: get axi write data");

    req.axi_wdata   = axi_slave_if.MONPORT.wdata;
    req.axi_wstrb   = axi_slave_if.MONPORT.wstrb;
    req.axi_wid     = axi_slave_if.MONPORT.wid;

    @(axi_slave_if.cb);
endtask
`endif
