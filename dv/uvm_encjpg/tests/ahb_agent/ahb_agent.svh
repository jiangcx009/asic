`ifndef AHB_AGENT_SVH
`define AHB_AGENT_SVH

class ahb_agent extends uvm_agent;
    ahb_monitor         ahb_mon;
    ahb_sequencer       ahb_sqr;
    ahb_master_drv      ahb_mst_drv;

    uvm_analysis_port #(ahb_trans)      ap;

    `uvm_component_utils(ahb_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
endclass

function void ahb_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if ( is_active == UVM_ACTIVE ) begin
        ahb_sqr = ahb_sequencer::type_id::create("ahb_sqr", this);
        ahb_mst_drv = ahb_master_drv::type_id::create("ahb_mst_drv", this);
    end

    ahb_mon = ahb_monitor::type_id::create("ahb_mon", this);
    $display("%0m :: build phase");
endfunction

function void ahb_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if ( is_active == UVM_ACTIVE ) begin
        $display("%0m :: is active~!");
        ahb_mst_drv.seq_item_port.connect(ahb_sqr.seq_item_export);
    end

    ap = ahb_mon.ahb_master_port;
    //`UVM_INFO("ahb_agent::connect_phase", "connect phase called", UVM_HIGH)
    $display("%0m :: connect phase");
endfunction
`endif
