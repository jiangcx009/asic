`ifndef RAL_ENCJPG_REG
`define RAL_ENCJPG_REG

`include "vmm_ral.sv"

class ral_reg_CFG extends vmm_ral_reg;
	rand vmm_ral_field inMode;
	rand vmm_ral_field lbufDep;
	rand vmm_ral_field srcSel;
	rand vmm_ral_field offsetX;
	rand vmm_ral_field offsetY;

	constraint inMode_c_mode {
	}
	constraint lbufDep_c_lbuf {
		lbufDep.value != 0;
	}
	constraint srcSel_c_sel {
	}

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 256, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.inMode = new(this, "inMode", 1, vmm_ral::RW, 1'b1, 1'hx, 0, 1, cvr);
		this.lbufDep = new(this, "lbufDep", 2, vmm_ral::RW, 2'h2, 2'hx, 1, 1, cvr);
		this.srcSel = new(this, "srcSel", 5, vmm_ral::RW, 5'b0, 5'hx, 3, 1, cvr);
		this.offsetX = new(this, "offsetX", 8, vmm_ral::RW, 8'b0, 8'hx, 8, 0, cvr);
		this.offsetY = new(this, "offsetY", 8, vmm_ral::RW, 8'b0, 8'hx, 16, 0, cvr);
		Xadd_constraintsX("inMode_c_mode");
		Xadd_constraintsX("lbufDep_c_lbuf");
		Xadd_constraintsX("srcSel_c_sel");
	endfunction: new
endclass : ral_reg_CFG


class ral_reg_SIZE extends vmm_ral_reg;
	rand vmm_ral_field width;
	rand vmm_ral_field height;

	constraint width_c_width {
		width.value & 1'b1 == 0;
	}
	constraint height_c_height {
	}

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.width = new(this, "width", 12, vmm_ral::RW, 128, 12'hx, 0, 1, cvr);
		this.height = new(this, "height", 12, vmm_ral::RW, 96, 12'hx, 16, 1, cvr);
		Xadd_constraintsX("width_c_width");
		Xadd_constraintsX("height_c_height");
	endfunction: new
endclass : ral_reg_SIZE


class ral_reg_MBSIZE extends vmm_ral_reg;
	rand vmm_ral_field mbWidth;
	rand vmm_ral_field mbHeight;
	rand vmm_ral_field mbTotal;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.mbWidth = new(this, "mbWidth", 8, vmm_ral::RW, 8, 8'hx, 0, 0, cvr);
		this.mbHeight = new(this, "mbHeight", 8, vmm_ral::RW, 6, 8'hx, 8, 0, cvr);
		this.mbTotal = new(this, "mbTotal", 16, vmm_ral::RW, 48, 16'hx, 16, 0, cvr);
	endfunction: new
endclass : ral_reg_MBSIZE


class ral_reg_STRIDE extends vmm_ral_reg;
	rand vmm_ral_field stride;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.stride = new(this, "stride", 8, vmm_ral::RW, 8, 8'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_STRIDE


class ral_reg_QMTX0 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX0


class ral_reg_QMTX1 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX1


class ral_reg_QMTX2 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX2


class ral_reg_QMTX3 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX3


class ral_reg_QMTX4 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX4


class ral_reg_QMTX5 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX5


class ral_reg_QMTX6 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX6


class ral_reg_QMTX7 extends vmm_ral_reg;
	rand vmm_ral_field qmtx;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtx = new(this, "qmtx", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTX7


class ral_reg_QMTXW extends vmm_ral_reg;
	rand vmm_ral_field qmtxWe;
	rand vmm_ral_field qmtxWa;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.qmtxWe = new(this, "qmtxWe", 1, vmm_ral::RW, 'h0, 1'hx, 0, 0, cvr);
		this.qmtxWa = new(this, "qmtxWa", 3, vmm_ral::RW, 'h0, 3'hx, 1, 0, cvr);
	endfunction: new
endclass : ral_reg_QMTXW


class ral_reg_BUFY extends vmm_ral_reg;
	rand vmm_ral_field addrY;

	constraint addrY_c_bufy {
		addrY.value & 16'hFFFF == 0;
	}

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.addrY = new(this, "addrY", 32, vmm_ral::RW, 'h0, 32'hx, 0, 1, cvr);
		Xadd_constraintsX("addrY_c_bufy");
	endfunction: new
endclass : ral_reg_BUFY


class ral_reg_BUFUV extends vmm_ral_reg;
	rand vmm_ral_field addrUV;

	constraint addrUV_c_bufy {
		addrUV.value & 16'hFFFF == 0;
	}

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.addrUV = new(this, "addrUV", 32, vmm_ral::RW, 'h0, 32'hx, 0, 1, cvr);
		Xadd_constraintsX("addrUV_c_bufy");
	endfunction: new
endclass : ral_reg_BUFUV


class ral_reg_BUFO extends vmm_ral_reg;
	rand vmm_ral_field addrO;

	constraint addrO_c_bufy {
		addrO.value & 16'hFFFF == 0;
	}

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.addrO = new(this, "addrO", 32, vmm_ral::RW, 'h0, 32'hx, 0, 1, cvr);
		Xadd_constraintsX("addrO_c_bufy");
	endfunction: new
endclass : ral_reg_BUFO


class ral_reg_START extends vmm_ral_reg;
	rand vmm_ral_field en;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.en = new(this, "en", 1, vmm_ral::RW, 'h0, 1'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_START


class ral_reg_CTRL extends vmm_ral_reg;
	rand vmm_ral_field commit;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.commit = new(this, "commit", 1, vmm_ral::RW, 'h0, 1'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_CTRL


class ral_reg_INTEB extends vmm_ral_reg;
	rand vmm_ral_field enoughByte;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.enoughByte = new(this, "enoughByte", 4, vmm_ral::RW, 'h0, 4'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_INTEB


class ral_reg_INTEN extends vmm_ral_reg;
	rand vmm_ral_field eb;
	rand vmm_ral_field eof;
	rand vmm_ral_field over;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.eb = new(this, "eb", 1, vmm_ral::RW, 'h0, 1'hx, 0, 0, cvr);
		this.eof = new(this, "eof", 1, vmm_ral::RW, 'h1, 1'hx, 1, 0, cvr);
		this.over = new(this, "over", 1, vmm_ral::RW, 'h0, 1'hx, 2, 0, cvr);
	endfunction: new
endclass : ral_reg_INTEN


class ral_reg_INT extends vmm_ral_reg;
	rand vmm_ral_field eof;
	rand vmm_ral_field enough;
	rand vmm_ral_field over;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.eof = new(this, "eof", 1, vmm_ral::RW, 'h0, 1'hx, 0, 0, cvr);
		this.enough = new(this, "enough", 1, vmm_ral::RW, 'h0, 1'hx, 1, 0, cvr);
		this.over = new(this, "over", 1, vmm_ral::RW, 'h0, 1'hx, 2, 0, cvr);
	endfunction: new
endclass : ral_reg_INT


class ral_reg_SLEN extends vmm_ral_reg;
	rand vmm_ral_field slen;

	function new(vmm_ral_block parent, string name, bit[`VMM_RAL_ADDR_WIDTH-1:0] offset, string domain, int cvr, 
				bit[1:0] rights = 2'b11, bit unmapped = 0);
		super.new(parent, name, 32, offset, domain, cvr, rights, unmapped, vmm_ral::NO_COVERAGE);
		this.slen = new(this, "slen", 32, vmm_ral::RW, 'h0, 32'hx, 0, 0, cvr);
	endfunction: new
endclass : ral_reg_SLEN


class ral_block_encjpg_reg extends vmm_ral_block;
	rand ral_reg_CFG CFG;
	rand ral_reg_SIZE SIZE;
	rand ral_reg_MBSIZE MBSIZE;
	rand ral_reg_STRIDE STRIDE;
	rand ral_reg_QMTX0 QMTX0;
	rand ral_reg_QMTX1 QMTX1;
	rand ral_reg_QMTX2 QMTX2;
	rand ral_reg_QMTX3 QMTX3;
	rand ral_reg_QMTX4 QMTX4;
	rand ral_reg_QMTX5 QMTX5;
	rand ral_reg_QMTX6 QMTX6;
	rand ral_reg_QMTX7 QMTX7;
	rand ral_reg_QMTXW QMTXW;
	rand ral_reg_BUFY BUFY;
	rand ral_reg_BUFUV BUFUV;
	rand ral_reg_BUFO BUFO;
	rand ral_reg_START START;
	rand ral_reg_CTRL CTRL;
	rand ral_reg_INTEB INTEB;
	rand ral_reg_INTEN INTEN;
	rand ral_reg_INT INT;
	rand ral_reg_SLEN SLEN;
	rand vmm_ral_field CFG_inMode;
	rand vmm_ral_field inMode;
	rand vmm_ral_field CFG_lbufDep;
	rand vmm_ral_field lbufDep;
	rand vmm_ral_field CFG_srcSel;
	rand vmm_ral_field srcSel;
	rand vmm_ral_field CFG_offsetX;
	rand vmm_ral_field offsetX;
	rand vmm_ral_field CFG_offsetY;
	rand vmm_ral_field offsetY;
	rand vmm_ral_field SIZE_width;
	rand vmm_ral_field width;
	rand vmm_ral_field SIZE_height;
	rand vmm_ral_field height;
	rand vmm_ral_field MBSIZE_mbWidth;
	rand vmm_ral_field mbWidth;
	rand vmm_ral_field MBSIZE_mbHeight;
	rand vmm_ral_field mbHeight;
	rand vmm_ral_field MBSIZE_mbTotal;
	rand vmm_ral_field mbTotal;
	rand vmm_ral_field STRIDE_stride;
	rand vmm_ral_field stride;
	rand vmm_ral_field QMTX0_qmtx;
	rand vmm_ral_field QMTX1_qmtx;
	rand vmm_ral_field QMTX2_qmtx;
	rand vmm_ral_field QMTX3_qmtx;
	rand vmm_ral_field QMTX4_qmtx;
	rand vmm_ral_field QMTX5_qmtx;
	rand vmm_ral_field QMTX6_qmtx;
	rand vmm_ral_field QMTX7_qmtx;
	rand vmm_ral_field QMTXW_qmtxWe;
	rand vmm_ral_field qmtxWe;
	rand vmm_ral_field QMTXW_qmtxWa;
	rand vmm_ral_field qmtxWa;
	rand vmm_ral_field BUFY_addrY;
	rand vmm_ral_field addrY;
	rand vmm_ral_field BUFUV_addrUV;
	rand vmm_ral_field addrUV;
	rand vmm_ral_field BUFO_addrO;
	rand vmm_ral_field addrO;
	rand vmm_ral_field START_en;
	rand vmm_ral_field en;
	rand vmm_ral_field CTRL_commit;
	rand vmm_ral_field commit;
	rand vmm_ral_field INTEB_enoughByte;
	rand vmm_ral_field enoughByte;
	rand vmm_ral_field INTEN_eb;
	rand vmm_ral_field eb;
	rand vmm_ral_field INTEN_eof;
	rand vmm_ral_field INTEN_over;
	rand vmm_ral_field INT_eof;
	rand vmm_ral_field INT_enough;
	rand vmm_ral_field enough;
	rand vmm_ral_field INT_over;
	rand vmm_ral_field SLEN_slen;
	rand vmm_ral_field slen;

	function new(int cover_on = vmm_ral::NO_COVERAGE, string name = "encjpg_reg", vmm_ral_sys parent = null, integer base_addr = 0);
		super.new(parent, name, "encjpg_reg", 92, vmm_ral::LITTLE_ENDIAN, base_addr, "", cover_on, vmm_ral::NO_COVERAGE);
		this.CFG = new(this, "CFG", `VMM_RAL_ADDR_WIDTH'h0, "", cover_on, 2'b11, 0);
		this.CFG_inMode = this.CFG.inMode;
		this.inMode = this.CFG.inMode;
		this.CFG_lbufDep = this.CFG.lbufDep;
		this.lbufDep = this.CFG.lbufDep;
		this.CFG_srcSel = this.CFG.srcSel;
		this.srcSel = this.CFG.srcSel;
		this.CFG_offsetX = this.CFG.offsetX;
		this.offsetX = this.CFG.offsetX;
		this.CFG_offsetY = this.CFG.offsetY;
		this.offsetY = this.CFG.offsetY;
		this.SIZE = new(this, "SIZE", `VMM_RAL_ADDR_WIDTH'h1, "", cover_on, 2'b11, 0);
		this.SIZE_width = this.SIZE.width;
		this.width = this.SIZE.width;
		this.SIZE_height = this.SIZE.height;
		this.height = this.SIZE.height;
		this.MBSIZE = new(this, "MBSIZE", `VMM_RAL_ADDR_WIDTH'h2, "", cover_on, 2'b11, 0);
		this.MBSIZE_mbWidth = this.MBSIZE.mbWidth;
		this.mbWidth = this.MBSIZE.mbWidth;
		this.MBSIZE_mbHeight = this.MBSIZE.mbHeight;
		this.mbHeight = this.MBSIZE.mbHeight;
		this.MBSIZE_mbTotal = this.MBSIZE.mbTotal;
		this.mbTotal = this.MBSIZE.mbTotal;
		this.STRIDE = new(this, "STRIDE", `VMM_RAL_ADDR_WIDTH'h3, "", cover_on, 2'b11, 0);
		this.STRIDE_stride = this.STRIDE.stride;
		this.stride = this.STRIDE.stride;
		this.QMTX0 = new(this, "QMTX0", `VMM_RAL_ADDR_WIDTH'h4, "", cover_on, 2'b11, 0);
		this.QMTX0_qmtx = this.QMTX0.qmtx;
		this.QMTX1 = new(this, "QMTX1", `VMM_RAL_ADDR_WIDTH'h5, "", cover_on, 2'b11, 0);
		this.QMTX1_qmtx = this.QMTX1.qmtx;
		this.QMTX2 = new(this, "QMTX2", `VMM_RAL_ADDR_WIDTH'h6, "", cover_on, 2'b11, 0);
		this.QMTX2_qmtx = this.QMTX2.qmtx;
		this.QMTX3 = new(this, "QMTX3", `VMM_RAL_ADDR_WIDTH'h7, "", cover_on, 2'b11, 0);
		this.QMTX3_qmtx = this.QMTX3.qmtx;
		this.QMTX4 = new(this, "QMTX4", `VMM_RAL_ADDR_WIDTH'h8, "", cover_on, 2'b11, 0);
		this.QMTX4_qmtx = this.QMTX4.qmtx;
		this.QMTX5 = new(this, "QMTX5", `VMM_RAL_ADDR_WIDTH'h9, "", cover_on, 2'b11, 0);
		this.QMTX5_qmtx = this.QMTX5.qmtx;
		this.QMTX6 = new(this, "QMTX6", `VMM_RAL_ADDR_WIDTH'hA, "", cover_on, 2'b11, 0);
		this.QMTX6_qmtx = this.QMTX6.qmtx;
		this.QMTX7 = new(this, "QMTX7", `VMM_RAL_ADDR_WIDTH'hB, "", cover_on, 2'b11, 0);
		this.QMTX7_qmtx = this.QMTX7.qmtx;
		this.QMTXW = new(this, "QMTXW", `VMM_RAL_ADDR_WIDTH'hC, "", cover_on, 2'b11, 0);
		this.QMTXW_qmtxWe = this.QMTXW.qmtxWe;
		this.qmtxWe = this.QMTXW.qmtxWe;
		this.QMTXW_qmtxWa = this.QMTXW.qmtxWa;
		this.qmtxWa = this.QMTXW.qmtxWa;
		this.BUFY = new(this, "BUFY", `VMM_RAL_ADDR_WIDTH'hD, "", cover_on, 2'b11, 0);
		this.BUFY_addrY = this.BUFY.addrY;
		this.addrY = this.BUFY.addrY;
		this.BUFUV = new(this, "BUFUV", `VMM_RAL_ADDR_WIDTH'hE, "", cover_on, 2'b11, 0);
		this.BUFUV_addrUV = this.BUFUV.addrUV;
		this.addrUV = this.BUFUV.addrUV;
		this.BUFO = new(this, "BUFO", `VMM_RAL_ADDR_WIDTH'hF, "", cover_on, 2'b11, 0);
		this.BUFO_addrO = this.BUFO.addrO;
		this.addrO = this.BUFO.addrO;
		this.START = new(this, "START", `VMM_RAL_ADDR_WIDTH'h10, "", cover_on, 2'b11, 0);
		this.START_en = this.START.en;
		this.en = this.START.en;
		this.CTRL = new(this, "CTRL", `VMM_RAL_ADDR_WIDTH'h11, "", cover_on, 2'b11, 0);
		this.CTRL_commit = this.CTRL.commit;
		this.commit = this.CTRL.commit;
		this.INTEB = new(this, "INTEB", `VMM_RAL_ADDR_WIDTH'h12, "", cover_on, 2'b11, 0);
		this.INTEB_enoughByte = this.INTEB.enoughByte;
		this.enoughByte = this.INTEB.enoughByte;
		this.INTEN = new(this, "INTEN", `VMM_RAL_ADDR_WIDTH'h13, "", cover_on, 2'b11, 0);
		this.INTEN_eb = this.INTEN.eb;
		this.eb = this.INTEN.eb;
		this.INTEN_eof = this.INTEN.eof;
		this.INTEN_over = this.INTEN.over;
		this.INT = new(this, "INT", `VMM_RAL_ADDR_WIDTH'h14, "", cover_on, 2'b11, 0);
		this.INT_eof = this.INT.eof;
		this.INT_enough = this.INT.enough;
		this.enough = this.INT.enough;
		this.INT_over = this.INT.over;
		this.SLEN = new(this, "SLEN", `VMM_RAL_ADDR_WIDTH'h15, "", cover_on, 2'b11, 0);
		this.SLEN_slen = this.SLEN.slen;
		this.slen = this.SLEN.slen;
		this.Xlock_modelX();
	endfunction : new
endclass : ral_block_encjpg_reg


`endif
