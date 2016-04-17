`ifndef ENV_ENCJPG_SVH_
`define ENV_ENCJPG_SVH_

class env_encjpg extends uvm_env;
    ahb_agent       ahb_agt;
    axi_agent       axi_i_agt;
    axi_agent       axi_o_agt;
    encjpg_ref_mdl  encjpg_ref;
    encjpg_scb      jpg_scb;

    ral_block_encjpg_reg    encjpg_rm;
    ahb_adapter             adapter;
    vsqr                    encjpg_vsqr;

    uvm_reg_predictor#(ahb_trans)   predictor;

	//three fifo to buffering data
	uvm_tlm_analysis_fifo #(ahb_trans)  ahb_agt_mdl_fifo;
	uvm_tlm_analysis_fifo #(axi_trans)  axi_agt_mdl_fifo;
	uvm_tlm_analysis_fifo #(axi_trans)  axi_agt_scb_fifo;
	uvm_tlm_analysis_fifo #(axi_trans)  mdl_scb_fifo;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
    extern virtual task reset_phase(uvm_phase phase);

    `uvm_component_utils(env_encjpg)
endclass

task env_encjpg::reset_phase(uvm_phase phase);
    const uvm_root uvm_top = uvm_root::get();
    super.reset_phase(phase);
    
    //wait(.rstj);
    `uvm_info("env_encjpg", "reset phase is executed", UVM_LOW)
endtask

function void env_encjpg::build_phase(uvm_phase phase);
    super.build_phase(phase);

    ahb_agt = ahb_agent::type_id::create("ahb_agt", this);
    axi_i_agt = axi_agent::type_id::create("axi_i_agt", this);
    axi_o_agt = axi_agent::type_id::create("axi_o_agt", this);
    encjpg_vsqr = vsqr::type_id::create("encjpg_vsqr", this);
    encjpg_ref = encjpg_ref_mdl::type_id::create("encjpg_ref", this);
    jpg_scb = encjpg_scb::type_id::create("jpg_scb", this);

    encjpg_rm = ral_block_encjpg_reg::type_id::create("encjpg_rm", this);
    encjpg_rm.configure(null, "tb_top.wdut");
    encjpg_rm.build();
    encjpg_rm.lock_model();

    if ( encjpg_rm.get_parent() == null )begin
        adapter = ahb_adapter::type_id::create("adapter",, get_full_name());
    end

    predictor = uvm_reg_predictor #(ahb_trans)::type_id::create("predictor", this);

    ahb_agt_mdl_fifo = new("ahb_agt_mdl_fifo", this);
    axi_agt_mdl_fifo = new("axi_agt_mdl_fifo", this);
    axi_agt_scb_fifo = new("axi_agt_scb_fifo", this);
    mdl_scb_fifo     = new ("mdl_scb_fifo",    this);

    ahb_agt.is_active = UVM_ACTIVE;
    axi_i_agt.is_active = UVM_ACTIVE;
    axi_o_agt.is_active = UVM_PASSIVE;

    $display("%0m :: build phase");
endfunction

function void env_encjpg::connect_phase(uvm_phase phase);
    $display("%0m :: connect phase");

    super.connect_phase(phase);
    encjpg_ref.p_rm = encjpg_rm;

    ahb_agt.ap.connect(ahb_agt_mdl_fifo.analysis_export); //Useful ?
    encjpg_ref.ahb_port.connect(ahb_agt_mdl_fifo.blocking_get_export); 

    //in-monitor->reference
    axi_i_agt.ap.connect(axi_agt_mdl_fifo.analysis_export); 
    encjpg_ref.axi_port.connect(axi_agt_mdl_fifo.blocking_get_export);

    //out-monitor->scb
    axi_o_agt.ap.connect(axi_agt_scb_fifo.analysis_export); 
    jpg_scb.actual_port.connect(axi_agt_scb_fifo.blocking_get_export);

    //reference->scb
    encjpg_ref.axi_ap.connect(mdl_scb_fifo.analysis_export);
    jpg_scb.except_port.connect(mdl_scb_fifo.blocking_get_export);

    encjpg_vsqr.p_ahb_sqr = ahb_agt.ahb_sqr;
    encjpg_vsqr.p_axi_sqr = axi_i_agt.axi_sqr;

    encjpg_rm.default_map.set_sequencer(encjpg_vsqr.p_ahb_sqr, adapter);
    encjpg_rm.default_map.set_auto_predict(1);
    predictor.map = encjpg_rm.default_map;
    predictor.adapter = adapter;

endfunction
`endif
