`ifndef _ENCJPG_TRNAS__
`define _ENCJPG_TRNAS__

class encjpg_trans extends uvm_sequence_item;
    integer         width;
    integer         height;
    integer         qp;
    axi_trans       axi_tr;
    ahb_trans       ahb_tr;
    bit [7:0]       yuv[];
    bit [7:0]       jpg[];

    `uvm_object_utils(encjpg_trans)

    function new (string name = "encjpg_trans");
        super.new(name);
    endfunction
endclass
`endif
