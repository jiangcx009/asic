`ifndef VSEQUENCER_ENCJPG_SVH_
`define VSEQUENCER_ENCJPG_SVH_

class vsqr extends uvm_sequencer;
    ahb_sequencer         p_ahb_sqr;
    axi_sequencer         p_axi_sqr;
    encjpg_ref_mdl        p_rm;

    `uvm_component_utils(vsqr)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

    endfunction
endclass

`endif
