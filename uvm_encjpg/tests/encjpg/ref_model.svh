`ifndef REF_MODEL_SVH_
`define REF_MODEL_SVH_

import "DPI-C" pure function int sv_c(input bit [7:0] org[], int w, int h, int qp, output int strmlen, output bit [7:0] jpg[]);

class encjpg_ref_mdl extends uvm_component;
    ral_block_encjpg_reg       p_rm;
    bit [7:0]                  org[];
    bit [7:0]                  jpg[];
    integer                    QP;
    static int                 j = 0;

    uvm_blocking_get_port #(ahb_trans)  ahb_port;
	uvm_analysis_port #(ahb_trans)      ahb_ap;
    uvm_blocking_get_port #(axi_trans)  axi_port;
	uvm_analysis_port #(axi_trans)      axi_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	extern function void build_phase(uvm_phase phase);
	extern virtual task main_phase(uvm_phase phase);
    extern         task get_config();
    extern function void unpack_data(axi_trans tr, ref bit [7:0] dat[]);
    extern function void pack_data(bit [7:0] dat[], ref axi_trans tr);

	`uvm_component_utils(encjpg_ref_mdl)
endclass

function void encjpg_ref_mdl::build_phase(uvm_phase phase);
    $display("%0m :: build phase");
	super.build_phase(phase);

	ahb_port = new("ahb_port", this);
	ahb_ap = new("ahb_ap", this);

	axi_port = new("axi_port", this);
	axi_ap = new("axi_ap", this);
endfunction

task encjpg_ref_mdl::main_phase(uvm_phase phase);
    ahb_trans       ahb_tr;
    axi_trans       axi_tr;
    int             strmlen;

    $display("%0m :: main phase");
	super.main_phase(phase);

    //uvm_config_db#(integer)::wait_modified(this, "uvm_test_top.env.encjpg_vsqr.*", "sliceQP");
    //uvm_config_db#(integer)::get(this, "uvm_test_top.env.encjpg_vsqr.*", "sliceQP", QP);
    QP = 8;
    //org = new[128*96*3/2];
    //yuv = new[128*96*3/2];
    $display("%0m :: QP:%d", QP);

	while(1) begin
		//ahb_port.get(ahb_tr);
		//ahb_ap.write(ahb_tr);

		axi_port.get(axi_tr);
        axi_ap.write(axi_tr);
        //unpack_data(axi_tr, org);
        //sv_c(org, 128, 96, QP, strmlen, jpg);
        //if ( j == 128*96*3/2)
        //    break;
	end
    j = 0;

    //org.delete[];
    //jpg.delete[];
    //j = 0;
endtask
  
task encjpg_ref_mdl::get_config();
    bit [31:0]      reg_val;
    //
    //p_rm.
endtask

function void encjpg_ref_mdl::unpack_data(axi_trans tr, ref bit [7:0] dat[]);
    int         i;
    
    //for(i = 0; i < AXI_WDATA_PORT_WIDTH/8; i++)begin
    //    dat[j++] = tr.axi_wdata[i*8+:8];
    //end
endfunction

function void encjpg_ref_mdl::pack_data(bit [7:0] dat[], ref axi_trans tr);
    int         i;
    
    //for(i = 0; i < AXI_WDATA_PORT_WIDTH; i++)
    //    tr.axi_wdata=1;
endfunction
`endif
