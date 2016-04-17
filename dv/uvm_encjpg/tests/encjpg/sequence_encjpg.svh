`ifndef SEQUENCE_ENCJPG_SVH_
`define SEQUENCE_ENCJPG_SVH_

`include "ral_encjpg_reg.svh"
`include "jpgenc.vh"

class base_encjpg_seq extends uvm_sequence;
    ahb_trans               ahb_tr;
    ral_block_encjpg_reg    encjpg_rm;
    uvm_reg_data_t          dat;
    uvm_status_e            status;
    uvm_reg_block           blk[$];

    function new (string name = "base_encjpg_seq");
        super.new(name);
    endfunction

    task get_rm();
        uvm_reg_block::get_root_blocks(blk);
        if ( blk.size() == 0)
            `uvm_fatal("ahb_cfg_seq", "can't find root blocks")
        else if ( !$cast(encjpg_rm, blk[0]))
            `uvm_fatal("ahb_cfg_seq", "can't cast to reg_model")
    endtask

    `uvm_object_utils(base_encjpg_seq)
endclass

class ahb_cfg_seq extends base_encjpg_seq;
    local bit [31:0]    reg_data;

    local bit [31:0]  ahb_addr;
    local bit [31:0]  ahb_rDat;
    local bit [31:0]  ahb_wDat0;
    local bit [31:0]  ahb_wDat1;
    local bit [31:0]  ahb_wDat2;
    local bit [31:0]  ahb_wDat3;
    local bit [16-1:0] qMtx [0:63];
	local bit [16-1:0] jpeg_qsetpYCDC [0:63];
    local bit [16-1:0] qM0;
    local bit [16-1:0] qM1;
    local bit [16-1:0] qM2;
    local bit [16-1:0] qM3;
    local integer i;
    local integer qmtx_wadr = 0;
    integer sliceQP = 8;

    function new (string name = "ahb_cfg_seq");
        super.new(name);
    endfunction

    extern virtual task body();

    `uvm_object_utils(ahb_cfg_seq)
endclass

task ahb_cfg_seq::body();
    get_rm();
    `uvm_info("ahb_cfg_seq::body", "access encjpg biu by FRONT_DOOR", UVM_LOW)

    //uvm_config_db#(integer)::set(uvm_root::get(), "uvm_test_top.env.encjpg_ref", "sliceQP", sliceQP);

    encjpg_rm.CFG.inMode.set(1);
    encjpg_rm.CFG.lbufDep.set(1);
    encjpg_rm.CFG.srcSel.set(1);
    encjpg_rm.CFG.offsetX.set(0);
    encjpg_rm.CFG.offsetY.set(0);
    encjpg_rm.CFG.update(status);

    reg_data = 128 << 0 | 
               96  << 16;
    encjpg_rm.SIZE.write(status, reg_data, UVM_FRONTDOOR);

    encjpg_rm.MBSIZE.mbWidth.set(128>>4);
    encjpg_rm.MBSIZE.mbHeight.set(96>>4);
    encjpg_rm.MBSIZE.mbTotal.set(128*96/256);
    encjpg_rm.MBSIZE.update(status);

    encjpg_rm.STRIDE.write(status, 128>>4, UVM_FRONTDOOR);
    encjpg_rm.INTEB.write(status, 1024, UVM_FRONTDOOR);

    encjpg_rm.INTEN.eb.set(0);
    encjpg_rm.INTEN.eof.set(1);
    encjpg_rm.INTEN.over.set(1);
    encjpg_rm.INTEN.update(status);
    
    encjpg_rm.BUFY.write(status, 32'h0100_0000, UVM_FRONTDOOR);
    encjpg_rm.BUFUV.write(status, 32'h0600_0000, UVM_FRONTDOOR);
    encjpg_rm.BUFO.write(status, 32'h0900_0000, UVM_FRONTDOOR);
    encjpg_rm.CTRL.write(status, 1, UVM_FRONTDOOR);

	jpeg_qsetpYCDC = {16'd1 , 16'd2 , 16'd3 , 16'd4 , 16'd5 , 16'd6 , 16'd7 , 16'd8 , 
					  16'd10, 16'd9 , 16'd12, 16'd9 , 16'd14, 16'd10, 16'd16, 16'd10, 
					  16'd17, 16'd11, 16'd18, 16'd11, 16'd19, 16'd12, 16'd20, 16'd12, 
					  16'd21, 16'd13, 16'd22, 16'd13, 16'd23, 16'd14, 16'd24, 16'd14, 
					  16'd25, 16'd15, 16'd26, 16'd15, 16'd27, 16'd16, 16'd28, 16'd16, 
					  16'd29, 16'd17, 16'd30, 16'd17, 16'd31, 16'd18, 16'd32, 16'd18, 
					  16'd34, 16'd19, 16'd36, 16'd20, 16'd38, 16'd21, 16'd40, 16'd22, 
					  16'd42, 16'd23, 16'd44, 16'd24, 16'd46, 16'd25, 16'd48, 16'd26 
					 };
	
    qMtx = {16'd8 , 16'd17, 16'd18,16'd19,16'd21,16'd23,16'd25,	16'd27,
            16'd17, 16'd18, 16'd19,16'd21,16'd23,16'd25,16'd27,	16'd28,
            16'd20, 16'd21, 16'd22,16'd23,16'd24,16'd26,16'd28,	16'd30,
            16'd21, 16'd22, 16'd23,16'd24,16'd26,16'd28,16'd30,	16'd32,
            16'd22, 16'd23, 16'd24,16'd26,16'd28,16'd30,16'd32,	16'd35,
            16'd23, 16'd24, 16'd26,16'd28,16'd30,16'd32,16'd35,	16'd38,
            16'd25, 16'd26, 16'd28,16'd30,16'd32,16'd35,16'd38,	16'd41,
            16'd27, 16'd28, 16'd30,16'd32,16'd35,16'd38,16'd41,	16'd45
           };
		   

    ///qScl: intraY
    for(i = 0; i < 64/4; i+=4)begin
        qM0 = i ? (1<<16)/(qMtx[4*i+0]*sliceQP/8) : (1<<16)/(jpeg_qsetpYCDC[sliceQP -1]);
	    qM1 = (1<<16)/(qMtx[4*i+1]*sliceQP/8);
	    qM2 = (1<<16)/(qMtx[4*i+2]*sliceQP/8);
	    qM3 = (1<<16)/(qMtx[4*i+3]*sliceQP/8);
        ahb_wDat0 = {qM1, qM0};
        ahb_wDat1 = {qM3, qM2};
        encjpg_rm.QMTX0.write(status, ahb_wDat0, UVM_FRONTDOOR);
        encjpg_rm.QMTX1.write(status, ahb_wDat1, UVM_FRONTDOOR);

        qM0 = (1<<16)/(qMtx[4*i+4]*sliceQP/8);
	    qM1 = (1<<16)/(qMtx[4*i+5]*sliceQP/8);	
	    qM2 = (1<<16)/(qMtx[4*i+6]*sliceQP/8);
	    qM3 = (1<<16)/(qMtx[4*i+7]*sliceQP/8);	
        ahb_wDat0 = {qM1, qM0};
        ahb_wDat1 = {qM3, qM2};
        encjpg_rm.QMTX2.write(status, ahb_wDat0, UVM_FRONTDOOR);
        encjpg_rm.QMTX3.write(status, ahb_wDat1, UVM_FRONTDOOR);

        qM0 = (1<<16)/(qMtx[4*i+8]*sliceQP/8);
	    qM1 = (1<<16)/(qMtx[4*i+9]*sliceQP/8);	
	    qM2 = (1<<16)/(qMtx[4*i+10]*sliceQP/8);
	    qM3 = (1<<16)/(qMtx[4*i+11]*sliceQP/8);	
        ahb_wDat0 = {qM1, qM0};
        ahb_wDat1 = {qM3, qM2};
        encjpg_rm.QMTX4.write(status, ahb_wDat0, UVM_FRONTDOOR);
        encjpg_rm.QMTX5.write(status, ahb_wDat1, UVM_FRONTDOOR);

        qM0 = (1<<16)/(qMtx[4*i+12]*sliceQP/8);
	    qM1 = (1<<16)/(qMtx[4*i+13]*sliceQP/8);	
	    qM2 = (1<<16)/(qMtx[4*i+14]*sliceQP/8);
	    qM3 = (1<<16)/(qMtx[4*i+15]*sliceQP/8);	
        ahb_wDat0 = {qM1, qM0};
        ahb_wDat1 = {qM3, qM2};
        encjpg_rm.QMTX6.write(status, ahb_wDat0, UVM_FRONTDOOR);
        encjpg_rm.QMTX7.write(status, ahb_wDat1, UVM_FRONTDOOR);

        ahb_wDat0 = ( 1 << `LSb32JPGENC_QMTXW_qmtxWe ) | ( qmtx_wadr << `LSb32JPGENC_QMTXW_qmtxWa );
        encjpg_rm.QMTXW.write(status, ahb_wDat0, UVM_FRONTDOOR);
		qmtx_wadr++;
	end

endtask

class ahb_ctl_seq extends base_encjpg_seq; 
    `uvm_object_utils(ahb_ctl_seq)

    function new (string name = "ahb_ctl_seq");
        super.new(name);
    endfunction

    virtual task body();
        get_rm();
        encjpg_rm.START.write(status, 1, UVM_FRONTDOOR);
        $display("%0m :: start jpeg encoder");
    endtask
endclass

class ahb_irq_seq extends base_encjpg_seq;
    `uvm_object_utils(ahb_irq_seq)

    function new(string name = "ahb_irq_seq");
        super.new(name);
    endfunction

    virtual task body();
        get_rm();
        encjpg_rm.INT.read(status, dat, UVM_FRONTDOOR);
        $display("@%0d %0m :: dat:%x", $time, dat);
        while( dat !== 1 )begin
            encjpg_rm.INT.read(status, dat, UVM_FRONTDOOR);
#100ns;
        end
    endtask
endclass

class axi_write_seq extends uvm_sequence #(axi_trans);
    axi_trans       axi_tr;
    
    `uvm_object_utils(axi_write_seq)

    function new (string name = "axi_write_seq");
        super.new(name);
    endfunction

    extern virtual task body();
endclass

task axi_write_seq::body();
    int     i = 0;
    int     addrY = 32'h0100_0000;
    int     addrUV = 32'h0600_0000;
    `uvm_info("axi_write_seq::body", "access encjpg axi by FRONT_DOOR", UVM_LOW)

    axi_tr = new("axi_tr");
    assert(axi_tr.randomize());

    for ( i = 0; i < 128*96; i++ )begin
        assert(axi_tr.randomize());
        axi_tr.axi_bd_write_dat[addrY + i] = axi_tr.axi_wdata;
    end

    for ( i = 0; i < 128*96/2; i++ )begin
        assert(axi_tr.randomize());
        axi_tr.axi_bd_write_dat[addrUV + i] = axi_tr.axi_wdata;
    end

    $display("%0m :: axi sequence");
    start_item(axi_tr);
    finish_item(axi_tr);
    //`uvm_do(axi_tr)
endtask


class vseq extends uvm_sequence;
    ahb_cfg_seq     p_cfg_seq;
    ahb_ctl_seq     p_ctl_seq;
    ahb_irq_seq     p_irq_seq;
    axi_write_seq   p_write_seq;

    `uvm_object_utils(vseq)
    `uvm_declare_p_sequencer(vsqr)

    virtual task body();
        if ( starting_phase != null )
            starting_phase.raise_objection(this);

	    $display("%0m :: body");

        fork
            `uvm_do_on(p_cfg_seq, p_sequencer.p_ahb_sqr)
            `uvm_do_on(p_write_seq, p_sequencer.p_axi_sqr)
        join
        `uvm_do_on(p_ctl_seq, p_sequencer.p_ahb_sqr)
        //$display("%0m :: config encjpg biu finish!");
        `uvm_do_on(p_irq_seq, p_sequencer.p_ahb_sqr)
        $display("%0m :: get interrupt!");

        if ( starting_phase != null )
            #1000ns;
            starting_phase.drop_objection(this);
    endtask
endclass
`endif
