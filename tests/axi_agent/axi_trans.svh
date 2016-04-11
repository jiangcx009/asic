`ifndef AXI_TRNAS_SVH_
`define AXI_TRNAS_SVH_

class axi_trans extends uvm_sequence_item;
parameter AXI_ADDR_PORT_WIDTH           = 32;
parameter AXI_ALEN_PORT_WIDTH           = 4;
parameter AXI_ASIZE_PORT_WIDTH           = 3;
parameter AXI_ABURST_PORT_WIDTH          = 2;
parameter AXI_ALOCK_PORT_WIDTH           = 2;
parameter AXI_ACACHE_PORT_WIDTH          = 4;
parameter AXI_APROT_PORT_WIDTH           = 3;
parameter AXI_AID_PORT_WIDTH            = 32  ;
parameter AXI_SLAVE_AID_PORT_WIDTH      = 32;
parameter AXI_RDATA_PORT_WIDTH         = 128;
parameter AXI_RRESP_PORT_WIDTH           = 2;
parameter AXI_RID_PORT_WIDTH            = 32;
parameter AXI_MASTER_RID_PORT_WIDTH     = 32;
parameter AXI_SLAVE_RID_PORT_WIDTH      = 32;
parameter AXI_WDATA_PORT_WIDTH        	= 128;
parameter AXI_WSTRB_PORT_WIDTH         = AXI_WDATA_PORT_WIDTH/8;
parameter AXI_WID_PORT_WIDTH            = 32 ;
parameter AXI_MASTER_WID_PORT_WIDTH     = 32 ;
parameter AXI_SLAVE_WID_PORT_WIDTH      = 32;
parameter AXI_BRESP_PORT_WIDTH           = 2;
parameter AXI_BID_PORT_WIDTH            = 32;
parameter AXI_MASTER_BID_PORT_WIDTH     = 32;
parameter AXI_SLAVE_BID_PORT_WIDTH      = 32;
parameter AXI_AVALID_PORT_WIDTH          = 1;
parameter AXI_AREADY_PORT_WIDTH          = 1;
parameter AXI_RVALID_PORT_WIDTH          = 1;
parameter AXI_RLAST_PORT_WIDTH           = 1;
parameter AXI_RREADY_PORT_WIDTH          = 1;
parameter AXI_WVALID_PORT_WIDTH          = 1;
parameter AXI_WLAST_PORT_WIDTH           = 1;
parameter AXI_WREADY_PORT_WIDTH          = 1;
parameter AXI_BVALID_PORT_WIDTH          = 1;
parameter AXI_BREADY_PORT_WIDTH          = 1;
parameter AXI_ACLK_PORT_WIDTH            = 1;
parameter AXI_ARESETN_PORT_WIDTH         = 1;
parameter AXI_CACTIVE_PORT_WIDTH         = 1;
parameter AXI_CSYSREQ_PORT_WIDTH         = 1;
parameter AXI_CSYSACK_PORT_WIDTH         = 1;
parameter AXI_AWSIDEBAND_PORT_WIDTH      = 64;
parameter AXI_ARSIDEBAND_PORT_WIDTH      = 64;
parameter AXI_WSIDEBAND_PORT_WIDTH       = 64;
parameter AXI_RSIDEBAND_PORT_WIDTH       = 64;
parameter AXI_BSIDEBAND_PORT_WIDTH       = 64;

    rand bit [AXI_ADDR_PORT_WIDTH - 1: 0]      axi_awaddr;    
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_awid;
    rand bit [AXI_ALEN_PORT_WIDTH - 1: 0]      axi_awlen;
    rand bit [AXI_ASIZE_PORT_WIDTH - 1: 0]     axi_awsize;
    rand bit [AXI_ABURST_PORT_WIDTH - 1: 0]    axi_awburst;
    rand bit                                    axi_awready;
    rand bit                                    axi_awvalid;

    rand bit [AXI_ADDR_PORT_WIDTH - 1: 0]      axi_araddr;    
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_arid;
    rand bit [AXI_ALEN_PORT_WIDTH - 1: 0]      axi_arlen;
    rand bit [AXI_ASIZE_PORT_WIDTH - 1: 0]     axi_arsize;
    rand bit [AXI_ABURST_PORT_WIDTH - 1: 0]    axi_arburst;
    rand bit                                    axi_arready;
    rand bit                                    axi_arvalid;
    
    rand bit [AXI_WDATA_PORT_WIDTH - 1: 0]     axi_wdata;
    rand bit [AXI_WSTRB_PORT_WIDTH - 1: 0]     axi_wstrb;
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_wid;
    rand bit                                    axi_wvalid;
    rand bit                                    axi_wready;

    rand bit [AXI_WDATA_PORT_WIDTH - 1: 0]     axi_rdata;
    rand bit [AXI_AID_PORT_WIDTH - 1: 0]       axi_rid;
    rand bit                                    axi_rvalid;
    rand bit                                    axi_rready;

    rand bit                                    axi_delay;
    reg [7 : 0]                                 axi_bd_write_dat[*];

    constraint base_cfg {
        axi_delay inside {[1:5]};
    }

    `uvm_object_utils(axi_trans)

    function new (string name = "axi_trans");
        super.new(name);
    endfunction

endclass : axi_trans
`endif           
