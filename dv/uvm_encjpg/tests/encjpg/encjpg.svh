`ifndef encjpg_SVH_
`define encjpg_SVH_

class base_test extends uvm_test;
    env_encjpg          env;
	
	`uvm_component_utils(base_test)
	function new(string name = "base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	extern virtual function void build_phase(uvm_phase phase);

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
	    $display("%0m :: connect phase");
    endfunction

endclass

function void base_test::build_phase(uvm_phase phase);
	$display("%0m :: build phase");
	super.build_phase(phase);

	//env = new("env", this);
	env = env_encjpg::type_id::create("env", this);
endfunction


class encjpg extends base_test;
	
	`uvm_component_utils(encjpg)

	function new(string name = "encjpg", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
	    super.build_phase(phase);

        uvm_config_db #(uvm_object_wrapper)::set(this, 
                "env.encjpg_vsqr.main_phase", "default_sequence", 
                vseq::type_id::get());
	    $display("%0m :: build phase, vseq id:%d", vseq::type_id::get());
    endfunction

endclass


`endif
