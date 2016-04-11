`ifndef AXI_AGENT_SVH
`define AXI_AGENT_SVH

class axi_agent extends uvm_agent;
    axi_monitor         axi_mon;
    axi_sequencer       axi_sqr;
    axi_slave_drv       axi_slv_drv;

    uvm_analysis_port #(axi_trans)      ap;

    `uvm_component_utils(axi_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
endclass

function void axi_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if ( is_active == UVM_ACTIVE ) begin
        axi_sqr = axi_sequencer::type_id::create("axi_sqr", this);
        axi_slv_drv = axi_slave_drv::type_id::create("axi_slv_drv", this);
    end

    axi_mon = axi_monitor::type_id::create("axi_mon", this);
endfunction

function void axi_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if ( is_active == UVM_ACTIVE ) begin
        axi_slv_drv.seq_item_port.connect(axi_sqr.seq_item_export);
        axi_mon.dbg_flag = 1;
    end
    else 
        axi_mon.dbg_flag = 0;

    ap = axi_mon.axi_slave_port;
endfunction
`endif
