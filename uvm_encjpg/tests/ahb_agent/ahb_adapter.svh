`include "uvm_macros.svh"
import uvm_pkg::*;

class ahb_adapter extends uvm_reg_adapter;
    `uvm_object_utils(ahb_adapter)
    function new(string name="ahb_adapter");
        super.new(name);
    endfunction

    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        ahb_trans ahb_tr;
        ahb_tr = ahb_trans::type_id::create("ahb_tr");
        ahb_tr.ahb_addr = rw.addr*4;
        ahb_tr.ahb_dirct = (rw.kind == UVM_READ) ? READ : WRITE;
        if(ahb_tr.ahb_dirct == WRITE)
            ahb_tr.ahb_data = rw.data;
        return (ahb_tr);
    endfunction

    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        ahb_trans ahb_tr;
        if(!$cast(ahb_tr, bus_item))begin
            `uvm_fatal("adapter",
                    "Provided bus_item is not of the correct type. Expecting ahb_trans")
            return;
        end

        rw.kind = (ahb_tr.ahb_dirct == READ) ? UVM_READ : UVM_WRITE;
        rw.addr = ahb_tr.ahb_addr/4;
        rw.byte_en = 'h0;
        rw.data = ahb_tr.ahb_data;
        rw.status = UVM_IS_OK;
    endfunction
endclass

