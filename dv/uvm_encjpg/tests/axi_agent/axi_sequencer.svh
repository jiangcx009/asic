`ifndef AXI_SEQUENCER_SVH_
`define AXI_SEQUENCER_SVH_

class axi_sequencer extends uvm_sequencer #(axi_trans);
    `uvm_component_utils(axi_sequencer)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass

`endif
