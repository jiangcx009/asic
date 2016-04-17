`ifndef _SCB_H__
`define _SCB_H__

class encjpg_scb extends uvm_scoreboard;
    uvm_blocking_get_port #(axi_trans)   except_port; //from reference
    uvm_blocking_get_port #(axi_trans)   actual_port; //from out-monitor

    `uvm_component_utils(encjpg_scb)

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        except_port = new("except_port", this);
        actual_port = new("actual_port", this);
    endfunction

    extern virtual task main_phase(uvm_phase phase);
        
endclass : encjpg_scb

task encjpg_scb::main_phase(uvm_phase phase);
    axi_trans   exp_tr, act_tr;
    axi_trans   excepted[$];
    axi_trans   actual[$];
    axi_trans   tmp_tr;
    integer     size_exp = 0;
    integer     size_act = 0;

    //phase.raise_objection(this);
    fork
        while(1)begin
            except_port.get(exp_tr);
            excepted.push_back(exp_tr);
            size_exp++;
            //$display("%0m :: get reference data:%x", exp_tr.axi_wdata);
        end

        while(1)begin
            actual_port.get(act_tr);
            actual.push_back(act_tr);
            size_act++;
            //$display("%0m :: get actually data");
            if ( excepted.size() != 0 )begin
                tmp_tr = excepted.pop_front();
                if ( tmp_tr.axi_wdata != act_tr.axi_wdata)begin
                    `uvm_info("encjpg_scb::", "Compare Failed", UVM_LOW)
                    $display("%0m :: mismatch==> act:%x, exp:%x", act_tr.axi_wdata, tmp_tr.axi_wdata);
                end
                else 
                    $display("%0m :: match==> act:%x, exp:%x", act_tr.axi_wdata, tmp_tr.axi_wdata);
            end
            else begin
                `uvm_error("encjpg_scb::", "Received from DUT, while Except Queue is empty")
            end
        end
    join

    //if ( size_exp != size_act )
    //    $display("%0m :: size mismatch!!");
    //else begin
    //    for(int i=0; i<size_exp; i++)begin
    //        exp_tr = excepted.pop_front();
    //        act_tr = actual.pop_front();
    //        if ( exp_tr.axi_wdata != act_tr.axi_wdata)begin
    //            `uvm_info("encjpg_scb::", "Compare Failed", UVM_LOW)
    //            $display("%0m :: mismatch==> act:%x, exp:%x", act_tr.axi_wdata, exp_tr.axi_wdata);
    //        end
    //        //else 
    //        //    $display("%0m :: match==> act:%x, exp:%x", act_tr.axi_wdata, tmp_tr.axi_wdata);
    //    end
    //    
    //end

    excepted.delete();
    actual.delete();
    //phase.drop_objection(this);
endtask

`endif
