`ifndef AXI_TRNAS_SVH_
`define AXI_TRNAS_SVH_

class axi_trans #(
parameter AXI_ADDR_PORT_WIDTH            = 32 ,
parameter AXI_ALEN_PORT_WIDTH            =  4 ,
parameter AXI_ASIZE_PORT_WIDTH           =  3 ,
parameter AXI_ABURST_PORT_WIDTH          =  2 ,
parameter AXI_ALOCK_PORT_WIDTH           =  2 ,
parameter AXI_ACACHE_PORT_WIDTH          =  4 ,
parameter AXI_APROT_PORT_WIDTH           =  3 ,
parameter AXI_AID_PORT_WIDTH             = 32 ,
parameter AXI_SLAVE_AID_PORT_WIDTH       = 32 ,
parameter AXI_RDATA_PORT_WIDTH           = 128,
parameter AXI_RRESP_PORT_WIDTH           = 2  ,
parameter AXI_RID_PORT_WIDTH             = 32 ,
parameter AXI_MASTER_RID_PORT_WIDTH      = 32 ,
parameter AXI_SLAVE_RID_PORT_WIDTH       = 32 ,
parameter AXI_WDATA_PORT_WIDTH           = 128,
parameter AXI_WSTRB_PORT_WIDTH           = AXI_WDATA_PORT_WIDTH/8,
parameter AXI_WID_PORT_WIDTH             = 32 ,
parameter AXI_MASTER_WID_PORT_WIDTH      = 32 ,
parameter AXI_SLAVE_WID_PORT_WIDTH       = 32 ,
parameter AXI_BRESP_PORT_WIDTH           = 2  ,
parameter AXI_BID_PORT_WIDTH             = 32 ,
parameter AXI_MASTER_BID_PORT_WIDTH      = 32 ,
parameter AXI_SLAVE_BID_PORT_WIDTH       = 32 ,
parameter AXI_AVALID_PORT_WIDTH          = 1  ,
parameter AXI_AREADY_PORT_WIDTH          = 1  ,
parameter AXI_RVALID_PORT_WIDTH          = 1  ,
parameter AXI_RLAST_PORT_WIDTH           = 1  ,
parameter AXI_RREADY_PORT_WIDTH          = 1  ,
parameter AXI_WVALID_PORT_WIDTH          = 1  ,
parameter AXI_WLAST_PORT_WIDTH           = 1  ,
parameter AXI_WREADY_PORT_WIDTH          = 1  ,
parameter AXI_BVALID_PORT_WIDTH          = 1  ,
parameter AXI_BREADY_PORT_WIDTH          = 1  ,
parameter AXI_ACLK_PORT_WIDTH            = 1  ,
parameter AXI_ARESETN_PORT_WIDTH         = 1  ,
parameter AXI_CACTIVE_PORT_WIDTH         = 1  ,
parameter AXI_CSYSREQ_PORT_WIDTH         = 1  ,
parameter AXI_CSYSACK_PORT_WIDTH         = 1  ,
parameter AXI_AWSIDEBAND_PORT_WIDTH      = 64 ,
parameter AXI_ARSIDEBAND_PORT_WIDTH      = 64 ,
parameter AXI_WSIDEBAND_PORT_WIDTH       = 64 ,
parameter AXI_RSIDEBAND_PORT_WIDTH       = 64 ,
parameter AXI_BSIDEBAND_PORT_WIDTH       = 64
) extends uvm_sequence_item;


    rand bit [AXI_ADDR_PORT_WIDTH - 1: 0]      axi_awaddr;    
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_awid;
    rand bit [AXI_ALEN_PORT_WIDTH - 1: 0]      axi_awlen;
    rand bit [AXI_ASIZE_PORT_WIDTH - 1: 0]     axi_awsize;
    rand bit [AXI_ABURST_PORT_WIDTH - 1: 0]    axi_awburst;

    rand bit [AXI_ADDR_PORT_WIDTH - 1: 0]      axi_araddr;    
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_arid;
    rand bit [AXI_ALEN_PORT_WIDTH - 1: 0]      axi_arlen;
    rand bit [AXI_ASIZE_PORT_WIDTH - 1: 0]     axi_arsize;
    rand bit [AXI_ABURST_PORT_WIDTH - 1: 0]    axi_arburst;
    
    rand bit [AXI_WDATA_PORT_WIDTH - 1: 0]     axi_wdata;
    rand bit [AXI_WSTRB_PORT_WIDTH - 1: 0]     axi_wstrb;
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_wid;

    rand bit [AXI_WDATA_PORT_WIDTH - 1: 0]     axi_rdata;
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_rid;

    rand int unsigned                          axi_delay;
	rand int unsigned						   rd_cmd_delay;
	rand int unsigned 						   wr_cmd_delay;
	rand int unsigned						   rd_data_delay;
	rand bit unsigned						   wr_data_delay;
    reg [7 : 0]                                axi_bd_write_dat[*];	
	bit [AXI_WDATA_PORT_WIDTH - 1: 0]		   axi_data_mem[$];
	bit [AXI_ADDR_PORT_WIDTH - 1: 0]		   axi_addr_mem[$];

    constraint base_cfg {
        axi_delay 		inside {[0:5]};
		rd_cmd_delay 	inside {[0:5]};
		wr_cmd_delay 	inside {[0:5]};
		rd_data_delay 	inside {[0:5]};
		wr_data_delay 	inside {[0:5]};
    }

    `uvm_object_utils_begin(axi_trans)
		`uvm_field_int(axi_awaddr, UVM_ALL_ON)
		`uvm_field_int(axi_awid, UVM_ALL_ON)
		`uvm_field_int(axi_awlen, UVM_ALL_ON)
		`uvm_field_int(axi_awsize, UVM_ALL_ON)
		`uvm_field_int(axi_awburst, UVM_ALL_ON)
		`uvm_field_int(axi_araddr, UVM_ALL_ON)
		`uvm_field_int(axi_arid, UVM_ALL_ON)
		`uvm_field_int(axi_arsize, UVM_ALL_ON)
		`uvm_field_int(axi_arlen, UVM_ALL_ON)
		`uvm_field_int(axi_arburst, UVM_ALL_ON)
		`uvm_field_int(axi_rdata, UVM_ALL_ON)
		`uvm_field_int(axi_rid, UVM_ALL_ON)
	`uvm_object_utils_end

    function new (string name = "axi_trans");
        super.new(name);
    endfunction

endclass : axi_trans
`endif           
