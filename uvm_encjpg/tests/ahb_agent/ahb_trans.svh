`ifndef AHB_TRANS_SVH_
`define AHB_TRANS_SVH_

class ahb_trans extends uvm_sequence_item;
    rand logic [`AHB_ADDR_WIDTH - 1: 0]    ahb_addr;
    rand logic [`AHB_DATA_WIDTH - 1: 0]    ahb_data;
	//rand ahb_transfer_type_e			   ahb_tran;
	//rand ahb_burst_e					   ahb_burst;
	//rand ahb_size_e					   ahb_size;
	//rand ahb_direction_e				   ahb_dirct;
    rand logic [`AHB_TYPE_WIDTH - 1: 0]    ahb_tran;
    rand logic [`AHB_BURST_WIDTH - 1: 0]   ahb_burst;
    rand logic [`AHB_SIZE_WIDTH - 1: 0]    ahb_size;
    rand logic                             ahb_dirct;
    rand bit   [2: 0]                      ahb_delay;

    constraint base_cfg {
      ahb_delay inside {[0:5]};
    }

    `uvm_object_utils_begin(ahb_trans)
		`uvm_field_int(ahb_addr, UVM_ALL_ON)
		`uvm_field_int(ahb_tran, UVM_ALL_ON)
		`uvm_field_int(ahb_burst, UVM_ALL_ON)
		`uvm_field_int(ahb_size, UVM_ALL_ON)
		`uvm_field_int(ahb_dirct, UVM_ALL_ON)
	`uvm_object_utils_end

    function new (string name = "ahb_trans");
        super.new(name);
    endfunction

endclass : ahb_trans

`endif
