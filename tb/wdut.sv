//
//  Module Name : wdut
//
//  Descriptions: test bench top module for IVEC codec 
//       
//
//

`include "timescale.vh"
`include "basic.vh"

module  wdut (
    ///
    ahb_if_t.SLVPORT   ahb0,       // ahbClk
    axi_if_t.MSTPORT   axi_pub,    // clk
        ///
    input           enb,
        output                  intr,           // leveled interrupt to external
    ///
        input                   ahbClk,     // ahb clock
        input                   ahbRstj,    // ahb ~reset
        input                   clk,        // sys clock
        input                   axiclk,     // sys clock
        input                   axiRstj,    // ahb ~reset
        input                   rstj        // reset
        ///
        );
    assign ahb0.slv_ahb_hresp = 2'b0;

    assign axi_pub.arburst = 2'b1;
    assign axi_pub.awburst = 2'b1;
    assign axi_pub.arsize  = 3'h4;
    assign axi_pub.awsize  = 3'h4;

    assign ahb0.ahb_slv_hreset_n = ahbRstj;
        jpgenc dut
///////////////////////////////////////////////////////////
        (
        //*     AHB-express slave <ahb>
        .ahbHSEL   (1'b1),
        .ahbHTRANS (ahb0.ahb_slv_htrans),
        .ahbHWRITE (ahb0.ahb_slv_hwrite),
        .ahbHSIZE  (ahb0.ahb_slv_hsize),
        .ahbHADDR  (ahb0.ahb_slv_haddr),
        .ahbHRDATA (ahb0.slv_ahb_hrdata),
        .ahbHWDATA (ahb0.ahb_slv_hwdata),
        .ahbHREADY (ahb0.slv_ahb_hready),


        .ahbClk    (ahbClk),
        .ahbRstj   (ahbRstj),

        //*     AXI<jpgenc> read-master command channel
        .jpgencARREADY (axi_pub.arready),
        .jpgencARVALID (axi_pub.arvalid),
        .jpgencARADDR  (axi_pub.araddr),
        .jpgencARLEN   (axi_pub.arlen),
        .jpgencARPROT  (axi_pub.arprot),
		.jpgencARID    (axi_pub.arid),

        //*     AXI<jpgenc> read-master data channel
        .jpgencRREADY  (axi_pub.rready),
        .jpgencRVALID  (axi_pub.rvalid),
        .jpgencRDATA   (axi_pub.rdata[127:0]),
        .jpgencRLAST   (axi_pub.rlast),
		.jpgencRID     (axi_pub.rid),

        //*     AXI<jpgenc> write-master command channel
        .jpgencAWREADY (axi_pub.awready),
        .jpgencAWVALID (axi_pub.awvalid),
        .jpgencAWADDR  (axi_pub.awaddr),
        .jpgencAWLEN   (axi_pub.awlen),
        .jpgencAWPROT  (axi_pub.awprot),
        .jpgencAWCACHE (axi_pub.awcache),
		.jpgencAWID    (axi_pub.awid),

        //*     AXI<jpgenc> write-master data channel
        .jpgencWREADY  (axi_pub.wready),
        .jpgencWVALID  (axi_pub.wvalid),
        .jpgencWDATA   (axi_pub.wdata[127:0]),
        .jpgencWSTRB   (axi_pub.wstrb[15:0]),
        .jpgencWLAST   (axi_pub.wlast),
		.jpgencWID     (axi_pub.wid),

        //*     AXI<jpgenc> write-master command-response channel
        .jpgencBREADY  (axi_pub.bready),
        .jpgencBVALID  (axi_pub.bvalid),
		.jpgencBID     (axi_pub.bid),

		.picStartIn    (0),
		.rowEndIn      (0),

        .intr          (intr),

        .clk           (clk),
        .rstj          (rstj)
        );

endmodule
