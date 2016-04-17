`ifndef AHB_MONITOR_SVH_
`define AHB_MONITOR_SVH_

class ahb_monitor extends uvm_monitor;
    virtual ahb_if_t    ahb_master_if;
    uvm_analysis_port #(ahb_trans) ahb_master_port;

    `uvm_component_utils(ahb_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task          main_phase(uvm_phase phase);
    extern         task          collect_one_pkg(ref ahb_trans req);
endclass

function void ahb_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if ( !uvm_config_db #(virtual ahb_if_t)::get(this, "", "ahb_if_t", ahb_master_if))
        `uvm_fatal("ahb_monitor::build_phase", "Error in get interface");

    ahb_master_port = new("ahb_master_port", this);

    $display("%0m :: build phase");
    //`UVM_INFO("ahb_monitor::build_phase", "build phase called", UVM_HIGH)
endfunction

task ahb_monitor::main_phase(uvm_phase phase);
    ahb_trans       ahb_master_req;   

    $display("%0m :: main phase");
    super.main_phase(phase);
    ahb_master_req = new("ahb_master_req");

    while(1) begin
        collect_one_pkg(ahb_master_req);
        ahb_master_port.write(ahb_master_req); //write to reference model
    end
endtask

task ahb_monitor::collect_one_pkg(ref ahb_trans req);
    while(1) begin
        if ( ahb_master_if.MONPORT.slv_ahb_hready && ahb_master_if.MONPORT.ahb_slv_htrans != 0) 
            break;

        @(ahb_master_if.cb);
    end

    //`uvm_info("ahb_monitor::collect_one_pkg", "collect one pkg..", UVM_LOW)

    req.ahb_addr = ahb_master_if.MONPORT.ahb_slv_haddr;
    req.ahb_size = ahb_master_if.MONPORT.ahb_slv_hsize;
    req.ahb_tran = ahb_master_if.MONPORT.ahb_slv_htrans;
    req.ahb_burst = ahb_master_if.MONPORT.ahb_slv_hburst;
    req.ahb_dirct = ahb_master_if.MONPORT.ahb_slv_hwrite;

    @(ahb_master_if.cb);
    req.ahb_data = ahb_master_if.MONPORT.ahb_slv_hwrite ? ahb_master_if.MONPORT.ahb_slv_hwdata : ahb_master_if.MONPORT.slv_ahb_hrdata;

endtask

`endif
