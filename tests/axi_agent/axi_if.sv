`ifndef AXI_IF_SVI_
`define AXI_IF_SVI_

//`timescale 1ns/1ps

interface axi_if_t # (
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
)
(input logic clk);

    logic                                       aresetn;
    logic                                       awvalid;
    logic [AXI_AID_PORT_WIDTH - 1: 0]           awid;
    logic [AXI_ADDR_PORT_WIDTH - 1: 0]          awaddr;
    logic [AXI_ALEN_PORT_WIDTH - 1: 0]          awlen;
    logic [AXI_ASIZE_PORT_WIDTH - 1: 0]         awsize;
    logic [AXI_ABURST_PORT_WIDTH - 1: 0]        awburst;
    logic [AXI_ALOCK_PORT_WIDTH - 1: 0]         awlock;
    logic [AXI_ACACHE_PORT_WIDTH - 1: 0]        awcache;
    logic [AXI_APROT_PORT_WIDTH - 1: 0]         awprot;
    logic                                       awready;
    logic                                       awuser;
    logic [AXI_AWSIDEBAND_PORT_WIDTH - 1: 0]    awsideband;

    logic                                       arvalid;
    logic [AXI_ADDR_PORT_WIDTH - 1: 0]          araddr;
    logic [AXI_ALEN_PORT_WIDTH - 1: 0]          arlen;
    logic [AXI_ASIZE_PORT_WIDTH - 1: 0]         arsize;
    logic [AXI_ABURST_PORT_WIDTH - 1: 0]        arburst;
    logic [AXI_ALOCK_PORT_WIDTH - 1: 0]         arlock;
    logic [AXI_ACACHE_PORT_WIDTH - 1: 0]        arcache;
    logic [AXI_APROT_PORT_WIDTH - 1: 0]         arprot;
    logic [AXI_AID_PORT_WIDTH - 1: 0]           arid;
    logic                                       arready;
    logic                                       aruser;
    logic [AXI_ARSIDEBAND_PORT_WIDTH - 1: 0]    arsideband;

    logic                                       rvalid;
    logic                                       rlast;
    logic [AXI_RDATA_PORT_WIDTH - 1: 0]         rdata;
    logic [AXI_RRESP_PORT_WIDTH - 1: 0]         rresp;
    logic [AXI_AID_PORT_WIDTH - 1: 0]           rid;
    logic                                       rready;
    logic [AXI_RSIDEBAND_PORT_WIDTH - 1: 0]     rsideband;

    logic                                       wvalid;
    logic                                       wlast;
    logic [AXI_WDATA_PORT_WIDTH - 1: 0]         wdata;
    logic [AXI_WSTRB_PORT_WIDTH - 1: 0]         wstrb;
    logic [AXI_AID_PORT_WIDTH - 1: 0]           wid;
    logic                                       wready;
    logic [AXI_WSIDEBAND_PORT_WIDTH - 1: 0]     wsideband;
    
    logic                                       bvalid;
    logic [AXI_BRESP_PORT_WIDTH - 1: 0]         bresp;
    logic [AXI_AID_PORT_WIDTH - 1: 0]           bid;
    logic                                       bready;
    logic [AXI_BSIDEBAND_PORT_WIDTH - 1: 0]     bsideband;

    clocking cb @(posedge clk);
        input   clk;
       input awvalid;
       input awaddr;
       input awlen;
       input awsize;
       input awburst;
       input awlock;
       input awcache;
       input awprot;
       input awid;
       output awready;
       input awsideband;
     
       input arvalid;
       input araddr;
       input arlen;
       input arsize;
       input arburst;
       input arlock;
       input arcache;
       input arprot;
       input arid;
       output arready;
       input arsideband;
     
       output rvalid;
       output rlast;
       output rdata;
       output rresp;
       output rid;
       input rready;
       output rsideband;
     
       input wvalid;
       input wlast;
       input wdata;
       input wstrb;
       input wid;
       output wready;
       output wsideband;
       
       output bvalid;
       output bresp;
       output bid;
       input bready;
       output bsideband;
     
    endclocking

    clocking neg_cb @(negedge clk);
        input   clk;
    endclocking

    modport MSTPORT (
        output awvalid,
        output awaddr,
        output awlen,
        output awsize,
        output awburst,
        output awlock,
        output awcache,
        output awprot,
        output awid,
        input awready,
        output awsideband,//?
           
        //read address channel signals
        output arvalid,
        output araddr,
        output arlen,
        output arsize,
        output arburst,
        output arlock,
        output arcache,
        output arprot,
        output arid,
        input arready,
        output arsideband,//?
           
        //read address channel signals
        input rvalid,
        input rlast,
        input rdata,
        input rresp,
        input rid,
        output rready,
        input rsideband,//?
           
        //write data channel signals
        output wvalid,
        output wlast,
        output wdata,
        output wstrb,
        output wid,
        input wready,
        input wsideband,//?
         
        //write response channel signals
        input bvalid,
        input bresp,
        input bid,
        output bready,
        input bsideband
    );

    modport SLVPORT(
       input awvalid,
       input awaddr,
       input awlen,
       input awsize,
       input awburst,
       input awlock,
       input awcache,
       input awprot,
       input awid,
       output awready,
       input awsideband,
     
       input arvalid,
       input araddr,
       input arlen,
       input arsize,
       input arburst,
       input arlock,
       input arcache,
       input arprot,
       input arid,
       output arready,
       input arsideband,
     
       output rvalid,
       output rlast,
       output rdata,
       output rresp,
       output rid,
       input rready,
       output rsideband,
     
       input wvalid,
       input wlast,
       input wdata,
       input wstrb,
       input wid,
       output wready,
       output wsideband,
       
       output bvalid,
       output bresp,
       output bid,
       input bready,
       output bsideband
    );

    modport MONPORT(
       input awvalid,
       input awaddr,
       input awlen,
       input awsize,
       input awburst,
       input awlock,
       input awcache,
       input awprot,
       input awid,
       input awready,
       input awsideband,
     
       input arvalid,
       input araddr,
       input arlen,
       input arsize,
       input arburst,
       input arlock,
       input arcache,
       input arprot,
       input arid,
       input arready,
       input arsideband,
     
       input rvalid,
       input rlast,
       input rdata,
       input rresp,
       input rid,
       input rready,
       input rsideband,
     
       input wvalid,
       input wlast,
       input wdata,
       input wstrb,
       input wid,
       input wready,
       input wsideband,
       
       input bvalid,
       input bresp,
       input bid,
       input bready,
       input bsideband
    );
endinterface 

`endif
