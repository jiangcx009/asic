`ifndef RAL_ENCJPG_REG
`define RAL_ENCJPG_REG

//import uvm_pkg::*;

class ral_reg_CFG extends uvm_reg;
	rand uvm_reg_field inMode;
	rand uvm_reg_field lbufDep;
	rand uvm_reg_field srcSel;
	rand uvm_reg_field offsetX;
	rand uvm_reg_field offsetY;

	constraint inMode_c_mode {
	}
	constraint lbufDep_c_lbuf {
		lbufDep.value != 0;
	}
	constraint srcSel_c_sel {
	}

	function new(string name = "CFG");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.inMode = uvm_reg_field::type_id::create("inMode",,get_full_name());
      this.inMode.configure(this, 1, 0, "RW", 0, 1'b1, 1, 1, 0);
      this.lbufDep = uvm_reg_field::type_id::create("lbufDep",,get_full_name());
      this.lbufDep.configure(this, 2, 1, "RW", 0, 2'h2, 1, 1, 0);
      this.srcSel = uvm_reg_field::type_id::create("srcSel",,get_full_name());
      this.srcSel.configure(this, 5, 3, "RW", 0, 5'b0, 1, 1, 0);
      this.offsetX = uvm_reg_field::type_id::create("offsetX",,get_full_name());
      this.offsetX.configure(this, 8, 8, "RW", 0, 8'b0, 1, 0, 1);
      this.offsetY = uvm_reg_field::type_id::create("offsetY",,get_full_name());
      this.offsetY.configure(this, 8, 16, "RW", 0, 8'b0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_CFG)

endclass : ral_reg_CFG


class ral_reg_SIZE extends uvm_reg;
	rand uvm_reg_field width;
	rand uvm_reg_field height;

	constraint width_c_width {
		width.value & 1'b1 == 0;
	}
	constraint height_c_height {
	}

	function new(string name = "SIZE");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.width = uvm_reg_field::type_id::create("width",,get_full_name());
      this.width.configure(this, 12, 0, "RW", 0, 128, 1, 1, 1);
      this.height = uvm_reg_field::type_id::create("height",,get_full_name());
      this.height.configure(this, 12, 16, "RW", 0, 96, 1, 1, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_SIZE)

endclass : ral_reg_SIZE


class ral_reg_MBSIZE extends uvm_reg;
	rand uvm_reg_field mbWidth;
	rand uvm_reg_field mbHeight;
	rand uvm_reg_field mbTotal;

	function new(string name = "MBSIZE");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.mbWidth = uvm_reg_field::type_id::create("mbWidth",,get_full_name());
      this.mbWidth.configure(this, 8, 0, "RW", 0, 8, 1, 0, 1);
      this.mbHeight = uvm_reg_field::type_id::create("mbHeight",,get_full_name());
      this.mbHeight.configure(this, 8, 8, "RW", 0, 6, 1, 0, 1);
      this.mbTotal = uvm_reg_field::type_id::create("mbTotal",,get_full_name());
      this.mbTotal.configure(this, 16, 16, "RW", 0, 48, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_MBSIZE)

endclass : ral_reg_MBSIZE


class ral_reg_STRIDE extends uvm_reg;
	rand uvm_reg_field stride;

	function new(string name = "STRIDE");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.stride = uvm_reg_field::type_id::create("stride",,get_full_name());
      this.stride.configure(this, 8, 0, "RW", 0, 8, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_STRIDE)

endclass : ral_reg_STRIDE


class ral_reg_QMTX0 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX0");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX0)

endclass : ral_reg_QMTX0


class ral_reg_QMTX1 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX1");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX1)

endclass : ral_reg_QMTX1


class ral_reg_QMTX2 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX2");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX2)

endclass : ral_reg_QMTX2


class ral_reg_QMTX3 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX3");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX3)

endclass : ral_reg_QMTX3


class ral_reg_QMTX4 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX4");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX4)

endclass : ral_reg_QMTX4


class ral_reg_QMTX5 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX5");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX5)

endclass : ral_reg_QMTX5


class ral_reg_QMTX6 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX6");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX6)

endclass : ral_reg_QMTX6


class ral_reg_QMTX7 extends uvm_reg;
	rand uvm_reg_field qmtx;

	function new(string name = "QMTX7");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtx = uvm_reg_field::type_id::create("qmtx",,get_full_name());
      this.qmtx.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTX7)

endclass : ral_reg_QMTX7


class ral_reg_QMTXW extends uvm_reg;
	rand uvm_reg_field qmtxWe;
	rand uvm_reg_field qmtxWa;

	function new(string name = "QMTXW");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.qmtxWe = uvm_reg_field::type_id::create("qmtxWe",,get_full_name());
      this.qmtxWe.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 0);
      this.qmtxWa = uvm_reg_field::type_id::create("qmtxWa",,get_full_name());
      this.qmtxWa.configure(this, 3, 1, "RW", 0, 3'h0, 1, 0, 0);
   endfunction: build

	`uvm_object_utils(ral_reg_QMTXW)

endclass : ral_reg_QMTXW


class ral_reg_BUFY extends uvm_reg;
	rand uvm_reg_field addrY;

	constraint addrY_c_bufy {
		addrY.value & 16'hFFFF == 0;
	}

	function new(string name = "BUFY");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.addrY = uvm_reg_field::type_id::create("addrY",,get_full_name());
      this.addrY.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_BUFY)

endclass : ral_reg_BUFY


class ral_reg_BUFUV extends uvm_reg;
	rand uvm_reg_field addrUV;

	constraint addrUV_c_bufy {
		addrUV.value & 16'hFFFF == 0;
	}

	function new(string name = "BUFUV");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.addrUV = uvm_reg_field::type_id::create("addrUV",,get_full_name());
      this.addrUV.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_BUFUV)

endclass : ral_reg_BUFUV


class ral_reg_BUFO extends uvm_reg;
	rand uvm_reg_field addrO;

	constraint addrO_c_bufy {
		addrO.value & 16'hFFFF == 0;
	}

	function new(string name = "BUFO");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.addrO = uvm_reg_field::type_id::create("addrO",,get_full_name());
      this.addrO.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_BUFO)

endclass : ral_reg_BUFO


class ral_reg_START extends uvm_reg;
	rand uvm_reg_field en;

	function new(string name = "START");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.en = uvm_reg_field::type_id::create("en",,get_full_name());
      this.en.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_START)

endclass : ral_reg_START


class ral_reg_CTRL extends uvm_reg;
	rand uvm_reg_field commit;

	function new(string name = "CTRL");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.commit = uvm_reg_field::type_id::create("commit",,get_full_name());
      this.commit.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_CTRL)

endclass : ral_reg_CTRL


class ral_reg_INTEB extends uvm_reg;
	rand uvm_reg_field enoughByte;

	function new(string name = "INTEB");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.enoughByte = uvm_reg_field::type_id::create("enoughByte",,get_full_name());
      this.enoughByte.configure(this, 4, 0, "RW", 0, 4'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_INTEB)

endclass : ral_reg_INTEB


class ral_reg_INTEN extends uvm_reg;
	rand uvm_reg_field eb;
	rand uvm_reg_field eof;
	rand uvm_reg_field over;

	function new(string name = "INTEN");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.eb = uvm_reg_field::type_id::create("eb",,get_full_name());
      this.eb.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 0);
      this.eof = uvm_reg_field::type_id::create("eof",,get_full_name());
      this.eof.configure(this, 1, 1, "RW", 0, 1'h1, 1, 0, 0);
      this.over = uvm_reg_field::type_id::create("over",,get_full_name());
      this.over.configure(this, 1, 2, "RW", 0, 1'h0, 1, 0, 0);
   endfunction: build

	`uvm_object_utils(ral_reg_INTEN)

endclass : ral_reg_INTEN


class ral_reg_INT extends uvm_reg;
	rand uvm_reg_field eof;
	rand uvm_reg_field enough;
	rand uvm_reg_field over;

	function new(string name = "INT");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.eof = uvm_reg_field::type_id::create("eof",,get_full_name());
      this.eof.configure(this, 1, 0, "RW", 0, 1'h0, 1, 0, 0);
      this.enough = uvm_reg_field::type_id::create("enough",,get_full_name());
      this.enough.configure(this, 1, 1, "RW", 0, 1'h0, 1, 0, 0);
      this.over = uvm_reg_field::type_id::create("over",,get_full_name());
      this.over.configure(this, 1, 2, "RW", 0, 1'h0, 1, 0, 0);
   endfunction: build

	`uvm_object_utils(ral_reg_INT)

endclass : ral_reg_INT


class ral_reg_SLEN extends uvm_reg;
	rand uvm_reg_field slen;

	function new(string name = "SLEN");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.slen = uvm_reg_field::type_id::create("slen",,get_full_name());
      this.slen.configure(this, 32, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_SLEN)

endclass : ral_reg_SLEN


class ral_block_encjpg_reg extends uvm_reg_block;
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
	rand uvm_reg_field CFG_inMode;
	rand uvm_reg_field inMode;
	rand uvm_reg_field CFG_lbufDep;
	rand uvm_reg_field lbufDep;
	rand uvm_reg_field CFG_srcSel;
	rand uvm_reg_field srcSel;
	rand uvm_reg_field CFG_offsetX;
	rand uvm_reg_field offsetX;
	rand uvm_reg_field CFG_offsetY;
	rand uvm_reg_field offsetY;
	rand uvm_reg_field SIZE_width;
	rand uvm_reg_field width;
	rand uvm_reg_field SIZE_height;
	rand uvm_reg_field height;
	rand uvm_reg_field MBSIZE_mbWidth;
	rand uvm_reg_field mbWidth;
	rand uvm_reg_field MBSIZE_mbHeight;
	rand uvm_reg_field mbHeight;
	rand uvm_reg_field MBSIZE_mbTotal;
	rand uvm_reg_field mbTotal;
	rand uvm_reg_field STRIDE_stride;
	rand uvm_reg_field stride;
	rand uvm_reg_field QMTX0_qmtx;
	rand uvm_reg_field QMTX1_qmtx;
	rand uvm_reg_field QMTX2_qmtx;
	rand uvm_reg_field QMTX3_qmtx;
	rand uvm_reg_field QMTX4_qmtx;
	rand uvm_reg_field QMTX5_qmtx;
	rand uvm_reg_field QMTX6_qmtx;
	rand uvm_reg_field QMTX7_qmtx;
	rand uvm_reg_field QMTXW_qmtxWe;
	rand uvm_reg_field qmtxWe;
	rand uvm_reg_field QMTXW_qmtxWa;
	rand uvm_reg_field qmtxWa;
	rand uvm_reg_field BUFY_addrY;
	rand uvm_reg_field addrY;
	rand uvm_reg_field BUFUV_addrUV;
	rand uvm_reg_field addrUV;
	rand uvm_reg_field BUFO_addrO;
	rand uvm_reg_field addrO;
	rand uvm_reg_field START_en;
	rand uvm_reg_field en;
	rand uvm_reg_field CTRL_commit;
	rand uvm_reg_field commit;
	rand uvm_reg_field INTEB_enoughByte;
	rand uvm_reg_field enoughByte;
	rand uvm_reg_field INTEN_eb;
	rand uvm_reg_field eb;
	rand uvm_reg_field INTEN_eof;
	rand uvm_reg_field INTEN_over;
	rand uvm_reg_field INT_eof;
	rand uvm_reg_field INT_enough;
	rand uvm_reg_field enough;
	rand uvm_reg_field INT_over;
	rand uvm_reg_field SLEN_slen;
	rand uvm_reg_field slen;

	function new(string name = "encjpg_reg");
		super.new(name, build_coverage(UVM_NO_COVERAGE));
	endfunction: new

   virtual function void build();
      this.default_map = create_map("", 0, 92, UVM_LITTLE_ENDIAN, 0);
      this.CFG = ral_reg_CFG::type_id::create("CFG",,get_full_name());
      this.CFG.configure(this, null, "");
      this.CFG.build();
      this.default_map.add_reg(this.CFG, `UVM_REG_ADDR_WIDTH'h0, "RW", 0);
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
      this.SIZE = ral_reg_SIZE::type_id::create("SIZE",,get_full_name());
      this.SIZE.configure(this, null, "");
      this.SIZE.build();
      this.default_map.add_reg(this.SIZE, `UVM_REG_ADDR_WIDTH'h1, "RW", 0);
		this.SIZE_width = this.SIZE.width;
		this.width = this.SIZE.width;
		this.SIZE_height = this.SIZE.height;
		this.height = this.SIZE.height;
      this.MBSIZE = ral_reg_MBSIZE::type_id::create("MBSIZE",,get_full_name());
      this.MBSIZE.configure(this, null, "");
      this.MBSIZE.build();
      this.default_map.add_reg(this.MBSIZE, `UVM_REG_ADDR_WIDTH'h2, "RW", 0);
		this.MBSIZE_mbWidth = this.MBSIZE.mbWidth;
		this.mbWidth = this.MBSIZE.mbWidth;
		this.MBSIZE_mbHeight = this.MBSIZE.mbHeight;
		this.mbHeight = this.MBSIZE.mbHeight;
		this.MBSIZE_mbTotal = this.MBSIZE.mbTotal;
		this.mbTotal = this.MBSIZE.mbTotal;
      this.STRIDE = ral_reg_STRIDE::type_id::create("STRIDE",,get_full_name());
      this.STRIDE.configure(this, null, "");
      this.STRIDE.build();
      this.default_map.add_reg(this.STRIDE, `UVM_REG_ADDR_WIDTH'h3, "RW", 0);
		this.STRIDE_stride = this.STRIDE.stride;
		this.stride = this.STRIDE.stride;
      this.QMTX0 = ral_reg_QMTX0::type_id::create("QMTX0",,get_full_name());
      this.QMTX0.configure(this, null, "");
      this.QMTX0.build();
      this.default_map.add_reg(this.QMTX0, `UVM_REG_ADDR_WIDTH'h4, "RW", 0);
		this.QMTX0_qmtx = this.QMTX0.qmtx;
      this.QMTX1 = ral_reg_QMTX1::type_id::create("QMTX1",,get_full_name());
      this.QMTX1.configure(this, null, "");
      this.QMTX1.build();
      this.default_map.add_reg(this.QMTX1, `UVM_REG_ADDR_WIDTH'h5, "RW", 0);
		this.QMTX1_qmtx = this.QMTX1.qmtx;
      this.QMTX2 = ral_reg_QMTX2::type_id::create("QMTX2",,get_full_name());
      this.QMTX2.configure(this, null, "");
      this.QMTX2.build();
      this.default_map.add_reg(this.QMTX2, `UVM_REG_ADDR_WIDTH'h6, "RW", 0);
		this.QMTX2_qmtx = this.QMTX2.qmtx;
      this.QMTX3 = ral_reg_QMTX3::type_id::create("QMTX3",,get_full_name());
      this.QMTX3.configure(this, null, "");
      this.QMTX3.build();
      this.default_map.add_reg(this.QMTX3, `UVM_REG_ADDR_WIDTH'h7, "RW", 0);
		this.QMTX3_qmtx = this.QMTX3.qmtx;
      this.QMTX4 = ral_reg_QMTX4::type_id::create("QMTX4",,get_full_name());
      this.QMTX4.configure(this, null, "");
      this.QMTX4.build();
      this.default_map.add_reg(this.QMTX4, `UVM_REG_ADDR_WIDTH'h8, "RW", 0);
		this.QMTX4_qmtx = this.QMTX4.qmtx;
      this.QMTX5 = ral_reg_QMTX5::type_id::create("QMTX5",,get_full_name());
      this.QMTX5.configure(this, null, "");
      this.QMTX5.build();
      this.default_map.add_reg(this.QMTX5, `UVM_REG_ADDR_WIDTH'h9, "RW", 0);
		this.QMTX5_qmtx = this.QMTX5.qmtx;
      this.QMTX6 = ral_reg_QMTX6::type_id::create("QMTX6",,get_full_name());
      this.QMTX6.configure(this, null, "");
      this.QMTX6.build();
      this.default_map.add_reg(this.QMTX6, `UVM_REG_ADDR_WIDTH'hA, "RW", 0);
		this.QMTX6_qmtx = this.QMTX6.qmtx;
      this.QMTX7 = ral_reg_QMTX7::type_id::create("QMTX7",,get_full_name());
      this.QMTX7.configure(this, null, "");
      this.QMTX7.build();
      this.default_map.add_reg(this.QMTX7, `UVM_REG_ADDR_WIDTH'hB, "RW", 0);
		this.QMTX7_qmtx = this.QMTX7.qmtx;
      this.QMTXW = ral_reg_QMTXW::type_id::create("QMTXW",,get_full_name());
      this.QMTXW.configure(this, null, "");
      this.QMTXW.build();
      this.default_map.add_reg(this.QMTXW, `UVM_REG_ADDR_WIDTH'hC, "RW", 0);
		this.QMTXW_qmtxWe = this.QMTXW.qmtxWe;
		this.qmtxWe = this.QMTXW.qmtxWe;
		this.QMTXW_qmtxWa = this.QMTXW.qmtxWa;
		this.qmtxWa = this.QMTXW.qmtxWa;
      this.BUFY = ral_reg_BUFY::type_id::create("BUFY",,get_full_name());
      this.BUFY.configure(this, null, "");
      this.BUFY.build();
      this.default_map.add_reg(this.BUFY, `UVM_REG_ADDR_WIDTH'hD, "RW", 0);
		this.BUFY_addrY = this.BUFY.addrY;
		this.addrY = this.BUFY.addrY;
      this.BUFUV = ral_reg_BUFUV::type_id::create("BUFUV",,get_full_name());
      this.BUFUV.configure(this, null, "");
      this.BUFUV.build();
      this.default_map.add_reg(this.BUFUV, `UVM_REG_ADDR_WIDTH'hE, "RW", 0);
		this.BUFUV_addrUV = this.BUFUV.addrUV;
		this.addrUV = this.BUFUV.addrUV;
      this.BUFO = ral_reg_BUFO::type_id::create("BUFO",,get_full_name());
      this.BUFO.configure(this, null, "");
      this.BUFO.build();
      this.default_map.add_reg(this.BUFO, `UVM_REG_ADDR_WIDTH'hF, "RW", 0);
		this.BUFO_addrO = this.BUFO.addrO;
		this.addrO = this.BUFO.addrO;
      this.START = ral_reg_START::type_id::create("START",,get_full_name());
      this.START.configure(this, null, "");
      this.START.build();
      this.default_map.add_reg(this.START, `UVM_REG_ADDR_WIDTH'h10, "RW", 0);
		this.START_en = this.START.en;
		this.en = this.START.en;
      this.CTRL = ral_reg_CTRL::type_id::create("CTRL",,get_full_name());
      this.CTRL.configure(this, null, "");
      this.CTRL.build();
      this.default_map.add_reg(this.CTRL, `UVM_REG_ADDR_WIDTH'h11, "RW", 0);
		this.CTRL_commit = this.CTRL.commit;
		this.commit = this.CTRL.commit;
      this.INTEB = ral_reg_INTEB::type_id::create("INTEB",,get_full_name());
      this.INTEB.configure(this, null, "");
      this.INTEB.build();
      this.default_map.add_reg(this.INTEB, `UVM_REG_ADDR_WIDTH'h12, "RW", 0);
		this.INTEB_enoughByte = this.INTEB.enoughByte;
		this.enoughByte = this.INTEB.enoughByte;
      this.INTEN = ral_reg_INTEN::type_id::create("INTEN",,get_full_name());
      this.INTEN.configure(this, null, "");
      this.INTEN.build();
      this.default_map.add_reg(this.INTEN, `UVM_REG_ADDR_WIDTH'h13, "RW", 0);
		this.INTEN_eb = this.INTEN.eb;
		this.eb = this.INTEN.eb;
		this.INTEN_eof = this.INTEN.eof;
		this.INTEN_over = this.INTEN.over;
      this.INT = ral_reg_INT::type_id::create("INT",,get_full_name());
      this.INT.configure(this, null, "");
      this.INT.build();
      this.default_map.add_reg(this.INT, `UVM_REG_ADDR_WIDTH'h14, "RW", 0);
		this.INT_eof = this.INT.eof;
		this.INT_enough = this.INT.enough;
		this.enough = this.INT.enough;
		this.INT_over = this.INT.over;
      this.SLEN = ral_reg_SLEN::type_id::create("SLEN",,get_full_name());
      this.SLEN.configure(this, null, "");
      this.SLEN.build();
      this.default_map.add_reg(this.SLEN, `UVM_REG_ADDR_WIDTH'h15, "RW", 0);
		this.SLEN_slen = this.SLEN.slen;
		this.slen = this.SLEN.slen;

		//
		// Setting up backdoor access...
		//
   endfunction : build

	`uvm_object_utils(ral_block_encjpg_reg)

endclass : ral_block_encjpg_reg

`endif
