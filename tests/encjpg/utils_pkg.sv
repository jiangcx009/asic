`ifndef UTILS_PKG_SVH_
`define UTILS_PKG_SVH_

`include "basic.vh"

package utils_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

import ahb_pkg::*;
import axi_pkg::*;


`include "encjpg_trans.svh"
`include "ral_encjpg_reg.svh"
`include "scb.svh"
`include "ref_model.svh"
`include "vsequencer_encjpg.svh"
`include "sequence_encjpg.svh"
`include "env_encjpg.svh"
`include "encjpg.svh"
endpackage

`endif
