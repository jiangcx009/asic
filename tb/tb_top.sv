//
//  Module Name : tb_top
//
//  Descriptions: test bench top, generate clocks/reset
//                logic are wrapped in wdut.
//
`include "basic.vh"

`define gen_clk(clk,PERIOD)  always #(PERIOD/2.0) clk = ~clk;

//`include "axi_if.sv"
//`include "ahb_if.sv"


module tb_top;

import uvm_pkg::*;
`include "uvm_macros.svh"

import ahb_pkg::*;
import axi_pkg::*;
import utils_pkg::*;

parameter   CODEC_CLK_PERIOD    =   1000/180;
parameter   AXI_CLK_PERIOD      =   1000/180;
parameter   AHB_CLK_PERIOD      =   1000/40;

reg clk;
reg axiclk;
reg ahbClk;
reg ahbRstj;
reg rstj;
reg axiRstj;



initial begin
    $display("@%0d %m Constructing Test Bench: stage 0", $stime);
    ahbRstj    = 1'b0;
    axiRstj    = 1'b0;
    rstj       = 1'b0;
    clk        = 1'b0;
    axiclk     = 1'b0;
    ahbClk     = 1'b0;
    
#100;
    $display("@%0d %m Constructing Test Bench: stage 1", $stime);
    rstj    =   1'b1;
    ahbRstj =   1'b1;
    axiRstj =   1'b1;
end


`gen_clk(clk,       CODEC_CLK_PERIOD)
`gen_clk(axiclk,    AXI_CLK_PERIOD)
`gen_clk(ahbClk,    AHB_CLK_PERIOD)


ahb_if_t  ahb0     (ahbClk);
axi_if_t #(.AXI_RDATA_PORT_WIDTH(128),
           .AXI_WDATA_PORT_WIDTH(128)
          ) axi_pub  (axiclk);

initial begin
    uvm_config_db#(virtual ahb_if_t)::set(null, "uvm_test_top.env.ahb_agt.ahb_mon", "ahb_if_t", ahb0); 
    uvm_config_db#(virtual ahb_if_t)::set(null, "uvm_test_top.env.ahb_agt.ahb_mst_drv", "ahb_if_t", ahb0); 

    uvm_config_db#(virtual axi_if_t)::set(null, "uvm_test_top.env.axi_i_agt.axi_mon", "axi_if_t", axi_pub); 
    uvm_config_db#(virtual axi_if_t)::set(null, "uvm_test_top.env.axi_o_agt.axi_mon", "axi_if_t", axi_pub); 
    uvm_config_db#(virtual axi_if_t)::set(null, "uvm_test_top.env.axi_i_agt.axi_slv_drv", "axi_if_t", axi_pub); 

    run_test();
end

wire    intr;


wdut wdut0 (
    .ahb0       (ahb0),
    .axi_pub    (axi_pub),
        ///
        .intr      (intr),
    //
        .ahbClk    (ahbClk),
        .ahbRstj   (ahbRstj),    
        .axiRstj   (axiRstj),    
        .clk       (clk),
        .axiclk    (axiclk),
        .rstj      (rstj)
);


`ifdef DUMP_FSDB
initial
  begin
    $fsdbAutoSwitchDumpfile(1000, "main.fsdb", 20);
    $fsdbDumpvars;
  end
`endif

endmodule
