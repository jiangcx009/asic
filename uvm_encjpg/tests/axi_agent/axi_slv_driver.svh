`ifndef AXI_SLAVE_DRIVER_SVH_
`define AXI_SLAVE_DRIVER_SVH_

`define wait_4_assert(S)  \
        @(axi_slave_if.cb) \
    while (axi_slave_if.cb.``S`` ===0 )  \
        @(axi_slave_if.cb)

class axi_slave_drv #(
parameter   AXI_ADDR_WIDTH          = 32 ,
parameter   AXI_DATA_WIDTH          = 128,
parameter   AXI_RCMD_QUEUE_DEPTH    = 8  ,
parameter   AXI_WCMD_QUEUE_DEPTH    = 8  ,
                                         
parameter   AXI_ID_WIDTH            = 32 ,
parameter   AXI_BRST_WIDTH          = 2  ,
                                         
parameter   AXI_SIZE_WIDTH      	= 3	 ,
parameter   AXI_LEN_WIDTH       	= 4	 ,
parameter   AXI_PROT_WIDTH      	= 3	 ,
parameter   AXI_CACH_WIDTH      	= 4	 ,
parameter   AXI_LOCK_WIDTH      	= 2	 ,
parameter   AXI_CMD_WIDTH           =   AXI_ADDR_WIDTH +
										AXI_LEN_WIDTH  +
										AXI_SIZE_WIDTH + 
										AXI_BRST_WIDTH +
										AXI_LOCK_WIDTH +
										AXI_CACH_WIDTH +
										AXI_PROT_WIDTH +
										AXI_ID_WIDTH ,
											
parameter   AXI_ADDR_LSB 			=  AXI_DATA_WIDTH  <=8     ? 0 :
									   AXI_DATA_WIDTH  <=16    ? 1 :       
									   AXI_DATA_WIDTH  <=32    ? 2 :       
									   AXI_DATA_WIDTH  <=64    ? 3 :       
									   AXI_DATA_WIDTH  <=128   ? 4 :       
									   AXI_DATA_WIDTH  <=256   ? 5 : 6
) extends uvm_driver #(axi_trans);
								
    axi_trans           axi_req;
    bit [AXI_CMD_WIDTH - 1 : 0 ] rd_cmd_queue  [ $ ] ; // take upto 8 command
    bit [AXI_CMD_WIDTH - 1 : 0 ] wr_cmd_queue  [ $ ] ; // take upto 8 command
    bit [AXI_ID_WIDTH  - 1 : 0 ] wr_resp_queue [ $ ] ; // take upto 8 command
    reg [7 : 0]         slv_mem[*];
    virtual axi_if_t    axi_slave_if;

    parameter MAX_WR_BURST_INTERVAL = 50;
    parameter MAX_WR_ITEM_INTERVAL = 20;
    parameter MIN_RD_LATENCY        = 20;
    parameter MAX_RD_LATENCY        = 30;
    parameter MIN_RD_BURST_INTERVAL = 0;
    parameter MAX_RD_BURST_INTERVAL = 3;
    parameter MAX_RD_ITEM_INTERVAL = 2;
    
    `uvm_component_utils(axi_slave_drv)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task reset_phase(uvm_phase phase);
    extern         task drive_axi_bus(axi_trans req);
    extern         task collect_axi_data(axi_trans req);

    extern         task axi_read() ;
    extern         task axi_read_cmd();
    extern         task axi_read_data();

    extern         task axi_write();
    extern         task axi_write_cmd();
    extern         task axi_write_data();
    extern         task axi_write_resp();
endclass : axi_slave_drv

function void axi_slave_drv::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if ( !uvm_config_db#(virtual axi_if_t)::get(this, "", "axi_if_t", axi_slave_if))
        `uvm_fatal("axi_slave_drv", "Error in Getting interface");
endfunction


task axi_slave_drv::reset_phase(uvm_phase phase);
    super.reset_phase(phase);
	
	phase.raise_objection(this, "pre reset");
	`uvm_info(get_full_name(), "Axi Reset Rised", UVM_HIGH)

    axi_slave_if.SLVPORT.awready    <= 1'h0;
    axi_slave_if.SLVPORT.arready    <= 1'h0;
    axi_slave_if.SLVPORT.wready     <= 1'h0;
    axi_slave_if.SLVPORT.rvalid     <= 1'h0;
    axi_slave_if.SLVPORT.rdata      <= 'h0;
    axi_slave_if.SLVPORT.rid        <= 'h0;
    axi_slave_if.SLVPORT.rresp      <= 'h0;
    axi_slave_if.SLVPORT.rlast      <= 1'h0;
    axi_slave_if.SLVPORT.bid        <= 'h0;
    axi_slave_if.SLVPORT.bvalid     <= 1'h0;
    axi_slave_if.SLVPORT.bresp      <= 'h0;

	phase.drop_objection(this, "post reset");
endtask : reset_phase

task axi_slave_drv::main_phase(uvm_phase phase);
    super.main_phase(phase);

    seq_item_port.get_next_item(req);
    collect_axi_data(req);
    seq_item_port.item_done();
    drive_axi_bus(req);
endtask : main_phase

task axi_slave_drv::collect_axi_data(axi_trans req);
    slv_mem = req.axi_bd_write_dat;
endtask

task axi_slave_drv::drive_axi_bus(axi_trans req);
    fork
        axi_read;
        axi_write;
    join
endtask : drive_axi_bus

task axi_slave_drv::axi_read ;
    fork
        axi_read_cmd;
        axi_read_data;
    join
endtask

task axi_slave_drv::axi_write ;
    fork
        axi_write_cmd;
        axi_write_data;
        axi_write_resp;
    join
endtask

task axi_slave_drv::axi_read_cmd;
    reg arready;
    fork
    // - generated arready
    while (1) begin
        @(axi_slave_if.neg_cb) begin
            axi_slave_if.SLVPORT.arready <= (rd_cmd_queue.size() < AXI_RCMD_QUEUE_DEPTH );
            arready = (rd_cmd_queue.size() < AXI_RCMD_QUEUE_DEPTH );
        end
    end
    // - command push
    while (1) begin
        @(axi_slave_if.cb)
        
       //the following if condition is modified by Zhang
        if (axi_slave_if.SLVPORT.arvalid===1'b1 && arready)  begin
            rd_cmd_queue.push_back ({axi_slave_if.SLVPORT.araddr[AXI_ADDR_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.arlen[AXI_LEN_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.arsize[AXI_SIZE_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.arburst[AXI_BRST_WIDTH-1:0] , 
                                    axi_slave_if.SLVPORT.arlock[AXI_LOCK_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.arcache[AXI_CACH_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.arprot[AXI_PROT_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.arid[AXI_ID_WIDTH-1:0]});


        end
    end
    join
endtask

task axi_slave_drv::axi_write_cmd;
    reg awready;
    fork
    // - generated awready
    while (1) begin
        @(axi_slave_if.neg_cb) begin
        axi_slave_if.SLVPORT.awready <= (wr_cmd_queue.size() < AXI_WCMD_QUEUE_DEPTH ) ;
            awready = (wr_cmd_queue.size() < AXI_WCMD_QUEUE_DEPTH );
        end
    end
    // - command push
    while (1) begin
        @(axi_slave_if.cb)
        if (awready && axi_slave_if.SLVPORT.awvalid===1'b1)  begin
            wr_cmd_queue.push_back ({axi_slave_if.SLVPORT.awaddr[AXI_ADDR_WIDTH-1:0],
                                    axi_slave_if.SLVPORT.awlen[AXI_LEN_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.awsize[AXI_SIZE_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.awburst[AXI_BRST_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.awlock[AXI_LOCK_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.awcache[AXI_CACH_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.awprot[AXI_PROT_WIDTH-1:0], 
                                    axi_slave_if.SLVPORT.awid[AXI_ID_WIDTH-1:0]});
        end
    end
    join
endtask


//// -axi_slave_drv::axi_read_data;
task axi_slave_drv::axi_read_data;
  int i,j;
  reg [AXI_DATA_WIDTH-1:0]      memDat;
  bit [AXI_ADDR_WIDTH-1:0]      byteAdr;
 
  bit [AXI_ADDR_WIDTH-1:0]      axi_rd_adr;
  bit [AXI_LEN_WIDTH-1:0]       axi_rd_len;
  bit [AXI_SIZE_WIDTH-1:0]      axi_rd_size;
  bit [AXI_BRST_WIDTH-1:0]      axi_rd_burst;
  bit [AXI_LOCK_WIDTH-1:0]      axi_rd_lock;
  bit [AXI_CACH_WIDTH-1:0]      axi_rd_cach;
  bit [AXI_PROT_WIDTH-1:0]      axi_rd_prot;
  bit [AXI_ID_WIDTH-1:0]        axi_rd_id;
  
  int unsigned read_latency;
  int unsigned burst_interval;
  int unsigned item_interval;

  while (1) begin
         while ( rd_cmd_queue.size() ==0) begin
             @(axi_slave_if.cb) ;
		    `ifdef DELAY
			    read_latency = $urandom_range(MAX_RD_LATENCY, MIN_RD_LATENCY);
			    repeat(read_latency) @(axi_slave_if.cb);
		    `endif
         end //#while

	    //read transaction interval
		`ifdef DELAY
			burst_interval = $urandom_range(MAX_RD_BURST_INTERVAL, MIN_RD_BURST_INTERVAL);
            `ifdef DISPLAY
                $display("@%0d: %m random rd burst_interval = %d",$time,burst_interval);
            `endif            
			repeat(burst_interval) @(axi_slave_if.cb);
		`endif
         {axi_rd_adr, axi_rd_len, axi_rd_size, axi_rd_burst, axi_rd_lock, axi_rd_cach, axi_rd_prot, axi_rd_id}   =   rd_cmd_queue.pop_front() ;
		 `ifdef DISPLAY
			 $display("@%0d: %m  AXI CMD POP  axi_rd_adr is :: %8h", $time, axi_rd_adr);
			 $display("@%0d: %m               axi_rd_len is :: %8h", $time, axi_rd_len);
			 $display("@%0d: %m               axi_rd_size is :: %8h", $time, axi_rd_size);
			 $display("@%0d: %m               axi_rd_burst is :: %8h", $time, axi_rd_burst);
			 $display("@%0d: %m               byteAdr is :: %8h", $time, axi_rd_adr);
		`endif
         @(axi_slave_if.cb)
         for (i=0; i<=axi_rd_len; i+=1) begin
            byteAdr    =   (axi_rd_adr>>AXI_ADDR_LSB)<<AXI_ADDR_LSB;
             for (j=0;j<AXI_DATA_WIDTH/8; j=j+1) begin
				`ifdef DISPLAY
					$display("@%0d: %m   byteAdr is :: %8h, slv_mem[%8h] is ", $time, byteAdr, byteAdr, slv_mem[byteAdr]);
				`endif
                 memDat[8*j+:8]    = slv_mem[byteAdr++];
             end
	     //read item interval
		 `ifdef DELAY
			 axi_slave_if.SLVPORT.rvalid <= 1'b0;
			 item_interval = $urandom_range(MAX_RD_ITEM_INTERVAL);
             `ifdef DISPLAY
                 $display("%0d: %m random rd item_interval = %d",$time,item_interval);
             `endif    
			repeat(item_interval) @(axi_slave_if.cb);
		 `endif
			 axi_slave_if.SLVPORT.rvalid <= 1'b1;
             begin
                 axi_slave_if.SLVPORT.rid      <=  axi_rd_id; 
                 axi_slave_if.SLVPORT.rdata    <=  memDat;
                 axi_slave_if.SLVPORT.rlast    <= (i === axi_rd_len) ? 1'b1 : 1'b0;
				 `ifdef DISPLAY
					$display("@%0d: %m  READ AXI DATA (%h, %h)", $time, memDat[63:32],memDat[31:0]);
				 `endif
                 `wait_4_assert(rready);
             end //clocking
             axi_rd_adr += (axi_rd_burst==2'h0) ? 0 :  (1<<AXI_ADDR_LSB);
         end //#for
         axi_slave_if.SLVPORT.rvalid <= 1'b0;
         axi_slave_if.SLVPORT.rlast  <= 1'b0;
    end //#while (1)
endtask


task axi_slave_drv::axi_write_data;
  integer i,j;

  bit [AXI_ADDR_WIDTH-1:0]      byteAdr;
  bit [AXI_ADDR_WIDTH-1:0]      axi_wr_adr;
  bit [AXI_LEN_WIDTH-1:0]       axi_wr_len;
  bit [AXI_SIZE_WIDTH-1:0]      axi_wr_size;
  bit [AXI_BRST_WIDTH-1:0]      axi_wr_burst;
  bit [AXI_LOCK_WIDTH-1:0]      axi_wr_lock;
  bit [AXI_CACH_WIDTH-1:0]      axi_wr_cach;
  bit [AXI_PROT_WIDTH-1:0]      axi_wr_prot;
  bit [AXI_ID_WIDTH-1:0]        axi_wr_id;
  // -

  int unsigned burst_interval;
  int unsigned item_interval;


    while (1) begin
        @(axi_slave_if.cb)
        while ( wr_cmd_queue.size() ==0) begin
            @(axi_slave_if.cb);
        end //#while wait for write command

	//write transaction interval
	`ifdef DELAY
		burst_interval = $urandom_range(MAX_WR_BURST_INTERVAL);
		`ifdef DISPLAY
			$display("@%0d: %m random wr burst_interval = %d",$time,burst_interval);
        `endif    
		#burst_interval
	`endif
        {axi_wr_adr, axi_wr_len, axi_wr_size, axi_wr_burst, axi_wr_lock, axi_wr_cach, axi_wr_prot, axi_wr_id}   =
        wr_cmd_queue.pop_front() ;
		`ifdef DISPLAY
			 $display("@%0d: %m  AXI CMD POP  axi_wr_adr is :: %8h", $time, axi_wr_adr);
			 $display("@%0d: %m               axi_wr_len is :: %8h", $time, axi_wr_len);
			 $display("@%0d: %m               axi_wr_size is :: %8h", $time, axi_wr_size);
			$display("@%0d: %m               byteAdr is :: %8h", $time, axi_wr_adr);
		`endif
        //@(axi_slave_if.cb)
        //axi_slave_if.SLVPORT.wready <=1'b1;
        for (i=0; i<=axi_wr_len; i+=1) begin
            byteAdr =   (axi_wr_adr >> AXI_ADDR_LSB) << AXI_ADDR_LSB;
		`ifdef DELAY
			item_interval = $urandom_range(MAX_WR_ITEM_INTERVAL);
            `ifdef DISPLAY
                $display("@%0d: %m random item_interval = %d",$time,item_interval);
            `endif
			#item_interval
            @(axi_slave_if.cb)
		`endif
            axi_slave_if.SLVPORT.wready <= 1'b1;
            `wait_4_assert(wvalid);
            //cosim_axi_write64 (axi_wr_adr, WDATA[31:0], WDATA[63:32]);
            for (j=0; j<(AXI_DATA_WIDTH/8); j=j+1)
                if (axi_slave_if.SLVPORT.wstrb[j])   begin 
                    slv_mem [byteAdr+j] = axi_slave_if.SLVPORT.wdata[j*8+:8];
					`ifdef DISPLAY
						$display("@%0d: %m  WRITE AXI DATA BEAT::%2d BYTE %1d is  %2h", $time,i,j,axi_slave_if.SLVPORT.wdata[j*8+:8]);
					`endif
                end // if
            axi_wr_adr += (axi_wr_burst==2'h0) ? 0 : (1<<axi_wr_size);
	//	@(axi_slave_if.cb);
	       axi_slave_if.SLVPORT.wready <=1'b0;
        end // for i
        axi_slave_if.SLVPORT.wready <= 1'b0;
        wr_resp_queue.push_back (axi_wr_id) ;
    end //#while(1)
endtask

task axi_slave_drv::axi_write_resp ;
    while (1) begin
        @(axi_slave_if.cb)
        while ( wr_resp_queue.size() == 0)
            @(axi_slave_if.cb);
        axi_slave_if.SLVPORT.bid      <=   wr_resp_queue.pop_front();
        @(axi_slave_if.cb)
        axi_slave_if.SLVPORT.bresp    <=   2'b0;
        axi_slave_if.SLVPORT.bvalid   <=   1'b1;
        `wait_4_assert(bready);
        axi_slave_if.SLVPORT.bvalid   <= 1'b0;
    end
endtask
`endif
