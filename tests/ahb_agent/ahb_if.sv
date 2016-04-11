`ifndef AHB_IF_SV
`define AHB_IF_SV

`timescale 1ns/1ps

`include "ahb_type.svh"

interface ahb_if_t (input logic clk);
    logic                               	ahb_slv_hreset_n    ; // hreset input to the slave
    logic                              		ahb_slv_hbusreq     ; // hreset input to the slave
    
	logic [`AHB_ADDR_WIDTH - 1: 0 ]         ahb_slv_haddr       ; // 32 bit input addr 
    logic [`AHB_DATA_WIDTH - 1: 0 ]         ahb_slv_hwdata      ; // 32 bit input hwdata 
    logic [`AHB_SIZE_WIDTH - 1: 0]          ahb_slv_hsize       ; // 3  bit input size
    logic [`AHB_BURST_WIDTH - 1: 0]         ahb_slv_hburst      ; // 3  bit input burst length
	logic [`AHB_PROT_WIDTH - 1: 0]			ahb_slv_hport		; // 4  bit input protection
    logic [`AHB_TYPE_WIDTH - 1: 0]         	ahb_slv_htrans      ; // 2  bit burst type

	logic 									ahb_slv_hlock		; // 1  bit input lock
    logic                               	ahb_slv_hwrite      ; // 1  bit control signal for write/read 1: write 0:read

	
    logic [`AHB_DATA_WIDTH - 1:0 ]			slv_ahb_hrdata      ; // 32 bit output read data ;
    //logic                               	slv_ahb_hready      ; // hready output from the ahb_slave;
	logic                               	slv_ahb_hready      ;     // hready to the AHB Bus 
    logic [ 1:0  ]                      	slv_ahb_hresp       ; // hresp from the AHB Slave ;


    clocking cb @(posedge clk);
        input       clk;
    endclocking

clocking master_cb  @ (posedge clk )        ;
     default        input #1 output #1      ; // define the clock skew
     output         ahb_slv_haddr           ; // 32 bit input addr 
//     output         ahb_slv_hready          ; // hready to the AHB Bus 
     output         ahb_slv_hburst          ; // hreset input to the slave
     output         ahb_slv_hsize           ; // hreset input to the slave
     output         ahb_slv_hwdata          ; // 32 bit input hwdata 
     output         ahb_slv_hwrite          ; // 32 bit control signal for write/read 1: write 0:read
     output         ahb_slv_htrans          ; // 32 bit control signal for write/read 1: write 0:read
     input          slv_ahb_hrdata          ; // 32 bit output read data ;
     input          slv_ahb_hready          ; // hready output from the ahb_slave;
     input          slv_ahb_hresp           ; // hreset input to the slave
endclocking
//
//clocking slave_cb  @ (posedge clk );
////     input          ahb_slv_hready          ; // hready to the AHB Bus 
//     input          ahb_slv_hburst          ; // hreset input to the slave
//     input          ahb_slv_hsize           ; // hreset input to the slave
//     input          ahb_slv_haddr           ; // 32 bit input addr 
//     input          ahb_slv_hwdata          ; // 32 bit input hwdata 
//     input          ahb_slv_hwrite          ; // 32 bit control signal for write/read 1: write 0:read
//     input          ahb_slv_htrans          ; // 32 bit control signal for write/read 1: write 0:read
//     output         slv_ahb_hrdata          ; // 32 bit output read data ;
//     output         slv_ahb_hready          ; // hready output from the ahb_slave;
//     output         slv_ahb_hresp           ; // hreset input to the slave
//endclocking

    modport MSTPORT (
        clocking     cb,
        
        output       ahb_slv_haddr,
        output       ahb_slv_hsize,
        output       ahb_slv_hburst,
        output       ahb_slv_hwrite,
        output       ahb_slv_htrans,
        output       ahb_slv_hwdata,

        input        slv_ahb_hready,
        input        slv_ahb_hrdata,
        input        slv_ahb_hresp,
        input        ahb_slv_hreset_n
    );

    modport SLVPORT (
        clocking    cb,
        
        input       ahb_slv_haddr,
        input       ahb_slv_hsize,
        input       ahb_slv_hburst,
        input       ahb_slv_hwrite,
        input       ahb_slv_htrans,
        input       ahb_slv_hwdata,

        output      slv_ahb_hready,
        output      slv_ahb_hrdata,
        output      slv_ahb_hresp,
        output      ahb_slv_hreset_n
    );

    modport MONPORT (
        input       ahb_slv_haddr,
        input       ahb_slv_hsize,
        input       ahb_slv_hburst,
        input       ahb_slv_hwrite,
        input       ahb_slv_htrans,
        input       ahb_slv_hwdata,
		
        input       slv_ahb_hready,
        input       slv_ahb_hrdata,
        input       slv_ahb_hresp,
        input       ahb_slv_hreset_n
    );
endinterface

`endif
