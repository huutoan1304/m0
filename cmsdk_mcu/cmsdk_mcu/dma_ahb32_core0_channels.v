//---------------------------------------------------------
//-- Source file: dma_core_channels.v
//---------------------------------------------------------



module dma_ahb32_core0_channels(clk,reset,scan_en,pclk,clken,pclken,psel,penable,paddr,pwrite,pwdata,prdata,pslverr,periph_tx_req,periph_tx_clr,periph_rx_req,periph_rx_clr,rd_clr_valid,wr_clr_valid,rd_clr,rd_clr_load,wr_clr,rd_cmd_split,rd_cmd_line,rd_cmd_num,wr_cmd_split,wr_cmd_pending,wr_cmd_num,rd_clr_stall,wr_clr_stall,load_wr,load_wr_num,load_wr_cycle,load_wdata,rd_ch_num,load_req_in_prog,wr_ch_num,wr_last_cmd,rd_slverr,rd_decerr,wr_slverr,wr_decerr,rd_ch_num_resp,wr_ch_num_resp,wr_clr_last,ch_int_all_proc,ch_start,ch_idle,ch_active,ch_rd_active,ch_wr_active,rd_line_cmd,wr_line_cmd,rd_go_next_line,wr_go_next_line,timeout_aw,timeout_w,timeout_ar,timeout_num_aw,timeout_num_w,timeout_num_ar,wdt_timeout,wdt_ch_num,ch_fifo_wr_num,rd_transfer_num,rd_burst_start,rd_transfer,rd_transfer_size,rd_clr_line,rd_clr_line_num,fifo_rd,fifo_rsize,fifo_rd_valid,fifo_rdata,fifo_wr_ready,ch_rd_ready,rd_burst_addr,rd_burst_size,rd_tokens,rd_cmd_port,rd_periph_delay,ch_fifo_rd_num,wr_transfer_num,wr_burst_start,wr_transfer,wr_transfer_size,wr_next_size,wr_clr_line,wr_clr_line_num,fifo_wr,fifo_wdata,fifo_wsize,ch_wr_ready,wr_burst_addr,wr_burst_size,wr_tokens,wr_cmd_port,wr_periph_delay,joint_mode,joint_remote,rd_page_cross,wr_page_cross,joint_in_prog,joint_not_in_prog,joint_mux_in_prog,ch_joint_req);

   input             clk;
   input             reset;
   input             scan_en;
   
   input             pclk;
   input             clken;
   input             pclken;
   input             psel;
   input             penable;
   input [10:0]      paddr;
   input             pwrite;
   input [31:0]      pwdata;
   output [31:0]     prdata;
   output            pslverr;
   
   input [31:1]      periph_tx_req;
   output [31:1]     periph_tx_clr;
   input [31:1]      periph_rx_req;
   output [31:1]     periph_rx_clr;
   output            rd_clr_valid;
   output            wr_clr_valid;
   input             rd_clr;
   input             rd_clr_load;
   input             wr_clr;
   input             rd_cmd_split;
   input             rd_cmd_line;
   input [2:0]       rd_cmd_num;
   input             wr_cmd_split;
   input             wr_cmd_pending;
   input [2:0]       wr_cmd_num;
   output            rd_clr_stall;
   output            wr_clr_stall;
   
   input             load_wr;
   input [2:0]       load_wr_num;
   input [1:0]       load_wr_cycle;
   input [32-1:0]    load_wdata;

   input [2:0]       rd_ch_num;
   output            load_req_in_prog;
   
   input [2:0]       wr_ch_num;
   output            wr_last_cmd;
   
   input             rd_slverr;
   input             rd_decerr;
   input             wr_slverr;
   input             wr_decerr;
   input [2:0]             rd_ch_num_resp;
   input [2:0]             wr_ch_num_resp;
   input             wr_clr_last;
   output [8*1-1:0]  ch_int_all_proc;
   input [7:0]                ch_start;
   output [7:0]          ch_idle;
   output [7:0]          ch_active;
   output [7:0]          ch_rd_active;
   output [7:0]          ch_wr_active;
   output              rd_line_cmd;
   output              wr_line_cmd;
   output              rd_go_next_line;
   output              wr_go_next_line;
   
   input              timeout_aw;
   input              timeout_w;
   input              timeout_ar;
   input [2:0]              timeout_num_aw;
   input [2:0]              timeout_num_w;
   input [2:0]              timeout_num_ar;
   input              wdt_timeout;
   input [2:0]              wdt_ch_num;
   
   input [2:0]              ch_fifo_wr_num;
   input [2:0]              rd_transfer_num;
   input              rd_burst_start;
   input              rd_transfer;
   input [3-1:0]     rd_transfer_size;
   input              rd_clr_line;
   input [2:0]              rd_clr_line_num;
   input              fifo_rd;
   input [3-1:0]     fifo_rsize;
   output              fifo_rd_valid;
   output [32-1:0]    fifo_rdata;
   output              fifo_wr_ready;
   output [7:0]          ch_rd_ready;
   output [32-1:0]    rd_burst_addr;
   output [7-1:0]   rd_burst_size;
   output [`TOKEN_BITS-1:0]  rd_tokens;
   output              rd_cmd_port;
   
   output [`DELAY_BITS-1:0]  rd_periph_delay; 

   input [2:0]              ch_fifo_rd_num;
   input [2:0]              wr_transfer_num;
   input              wr_burst_start; 
   input              wr_transfer;
   input [3-1:0]     wr_transfer_size;
   input [3-1:0]     wr_next_size;
   input              wr_clr_line;
   input [2:0]              wr_clr_line_num;
   input              fifo_wr;
   input [32-1:0]     fifo_wdata;
   input [3-1:0]     fifo_wsize;
   output [7:0]          ch_wr_ready;
   output [32-1:0]    wr_burst_addr;
   output [7-1:0]   wr_burst_size;
   output [`TOKEN_BITS-1:0]  wr_tokens;
   output              wr_cmd_port;
   output [`DELAY_BITS-1:0]  wr_periph_delay;
   
   input              joint_mode;
   input              joint_remote;
   input              rd_page_cross;
   input              wr_page_cross;
   output              joint_in_prog;
   output              joint_not_in_prog;
   output              joint_mux_in_prog;
   output [7:0]          ch_joint_req;

   
   
   parameter              CH0 = 0;
   parameter              CH1 = 1;
   parameter              CH2 = 2;
   parameter              CH3 = 3;
   parameter              CH4 = 4;
   parameter              CH5 = 5;
   parameter              CH6 = 6;
   parameter              CH7 = 7;
   

   //apb buses
   wire [7:0]              ch_psel;
   wire [7:0]              ch_pslverr;
   wire [32*8-1:0]          ch_prdata;
   
   wire [7:0]              ch_joint_end;
   wire [7:0]              ch_joint_in_prog;
   wire [7:0]              ch_joint_not_in_prog;
   wire [7:0]              ch_joint_mux_in_prog;
   
   wire [7:0]              ch_rd_page_cross;
   wire [7:0]              ch_wr_page_cross;
   
   //axim signals
   wire [7:0]              ch_load_wr;
   wire [7:0]              ch_rd_clr_line;
   wire [7:0]              ch_rd_slverr;
   wire [7:0]              ch_rd_decerr;
   wire [7:0]              ch_rd_clr;
   wire [7:0]              ch_rd_clr_load;
   wire [7:0]              ch_rd_transfer;
   wire [7:0]              ch_rd_clr_stall;
   wire [7:0]              ch_rd_cmd_split;
   wire [7:0]              ch_rd_cmd_line;
   
   wire [7:0]              ch_wr_clr_line;
   wire [7:0]              ch_wr_slverr;
   wire [7:0]              ch_wr_decerr;
   wire [7:0]              ch_wr_clr_last;
   wire [7:0]              ch_wr_clr;
   wire [7:0]              ch_load_req_in_prog;
   wire [7:0]              ch_wr_last_cmd;
   wire [7:0]              ch_rd_line_cmd;
   wire [7:0]              ch_wr_line_cmd;
   wire [7:0]              ch_rd_go_next_line;
   wire [7:0]              ch_wr_go_next_line;
   wire [7:0]              ch_wr_transfer;
   wire [7:0]              ch_wr_clr_stall;
   wire [7:0]              ch_wr_cmd_split;
   wire [7:0]              ch_timeout_aw;
   wire [7:0]              ch_timeout_w;
   wire [7:0]              ch_timeout_ar;
   wire [7:0]              ch_wdt_timeout;
      
   //rd ctrl signals
   wire [7:0]              ch_rd_burst_start;
   wire [8*32-1:0]    ch_rd_burst_addr;
   wire [8*7-1:0]   ch_rd_burst_size;
   wire [8*`TOKEN_BITS-1:0]  ch_rd_tokens;
   wire [7:0]              ch_rd_port_num;
   wire [8*`DELAY_BITS-1:0]  ch_rd_periph_delay;
   wire [7:0]              ch_rd_clr_valid;
   
   //wr ctrl signals
   wire [7:0]              ch_wr_burst_start;
   wire [8*32-1:0]    ch_wr_burst_addr;
   wire [8*7-1:0]   ch_wr_burst_size;
   wire [8*`TOKEN_BITS-1:0]  ch_wr_tokens;
   wire [7:0]              ch_wr_port_num;
   wire [8*`DELAY_BITS-1:0]  ch_wr_periph_delay;
   wire [7:0]              ch_wr_clr_valid;
   
   //CLR buses
   wire [8*31-1:0]          ch_periph_rx_clr;
   wire [8*31-1:0]          ch_periph_tx_clr;

   //FIFO signals
   wire [7:0]              ch_fifo_wr;
   wire [7:0]              ch_fifo_rd;
   wire [7:0]              ch_fifo_rd_valid;
   wire [8*32-1:0]    ch_fifo_rdata;
   wire [7:0]              ch_fifo_wr_ready;

   wire [7:0]              ch_wr_cmd_pending;


   dma_ahb32_core0_channels_apb_mux  dma_ahb32_channels_apb_mux (
                               .clk(pclk),
                               .reset(reset),
                               .pclken(pclken),
                               .psel(psel),
                               .penable(penable),
                               .paddr(paddr[10:8]),
                               .prdata(prdata),
                               .pslverr(pslverr),
                               .ch_psel(ch_psel),
                               .ch_prdata(ch_prdata),
                               .ch_pslverr(ch_pslverr)
                               );


   dma_ahb32_core0_channels_mux
   dma_ahb32_channels_mux (
            .ch_joint_in_prog(ch_joint_in_prog),
            .ch_joint_not_in_prog(ch_joint_not_in_prog),
            .ch_joint_mux_in_prog(ch_joint_mux_in_prog),
            .joint_in_prog(joint_in_prog),
            .joint_not_in_prog(joint_not_in_prog),
            .joint_mux_in_prog(joint_mux_in_prog),

            .ch_rd_page_cross(ch_rd_page_cross),
            .ch_wr_page_cross(ch_wr_page_cross),
            .rd_page_cross(rd_page_cross),
            .wr_page_cross(wr_page_cross),

            .ch_wr_cmd_pending(ch_wr_cmd_pending),
            .wr_cmd_pending(wr_cmd_pending),
            
            //data
            .fifo_rdata(fifo_rdata),
            .ch_fifo_rdata(ch_fifo_rdata),
            .fifo_rd_valid(fifo_rd_valid),
            .ch_fifo_rd_valid(ch_fifo_rd_valid),
            
            //periph
            .periph_rx_clr(periph_rx_clr),
            .ch_periph_rx_clr(ch_periph_rx_clr),
            .periph_tx_clr(periph_tx_clr),
            .ch_periph_tx_clr(ch_periph_tx_clr),
            
            //axim timeout
            .timeout_aw(timeout_aw),
            .timeout_w(timeout_w),
            .timeout_ar(timeout_ar),
            .timeout_num_aw(timeout_num_aw),
            .timeout_num_w(timeout_num_w),
            .timeout_num_ar(timeout_num_ar),
            .wdt_timeout(wdt_timeout),
            .wdt_ch_num(wdt_ch_num),
                     
            .ch_timeout_aw(ch_timeout_aw),
                        .ch_timeout_w(ch_timeout_w),
                        .ch_timeout_ar(ch_timeout_ar),
                        .ch_wdt_timeout(ch_wdt_timeout),
            
            //rd cmd
            .rd_ch_num(rd_ch_num),
            .rd_cmd_num(rd_cmd_num),
      
            .load_req_in_prog(load_req_in_prog),
            .rd_line_cmd(rd_line_cmd),
            .rd_go_next_line(rd_go_next_line),
            .rd_burst_start(rd_burst_start),
            .rd_burst_addr(rd_burst_addr),
            .rd_burst_size(rd_burst_size),
            .rd_tokens(rd_tokens),
            .rd_cmd_port(rd_cmd_port),
            .rd_periph_delay(rd_periph_delay),
            .rd_clr_valid(rd_clr_valid),
            .rd_cmd_split(rd_cmd_split),
            .rd_cmd_line(rd_cmd_line),
            .rd_clr_stall(rd_clr_stall),
      
            .ch_load_req_in_prog(ch_load_req_in_prog),
            .ch_rd_line_cmd(ch_rd_line_cmd),
            .ch_rd_go_next_line(ch_rd_go_next_line),
            .ch_rd_burst_start(ch_rd_burst_start),
            .ch_rd_burst_addr(ch_rd_burst_addr),
            .ch_rd_burst_size(ch_rd_burst_size),
            .ch_rd_tokens(ch_rd_tokens),
            .ch_rd_port_num(ch_rd_port_num),
            .ch_rd_periph_delay(ch_rd_periph_delay),
            .ch_rd_clr_valid(ch_rd_clr_valid),
            .ch_rd_cmd_split(ch_rd_cmd_split),
            .ch_rd_cmd_line(ch_rd_cmd_line),
            .ch_rd_clr_stall(ch_rd_clr_stall),
      
            //rd data - load cmd
            .load_wr_num(load_wr_num),
      
            .load_wr(load_wr),
      
            .ch_load_wr(ch_load_wr),
      
            //rd data
            .ch_fifo_wr_num(ch_fifo_wr_num),
            .rd_transfer_num(rd_transfer_num),
            .rd_clr_line_num(rd_clr_line_num),
      
            .rd_transfer(rd_transfer),
            .rd_clr_line(rd_clr_line),
            .fifo_wr(fifo_wr),
      
            .ch_rd_clr_line(ch_rd_clr_line),
            .ch_rd_transfer(ch_rd_transfer),
            .ch_fifo_wr(ch_fifo_wr),
      
            //rd resp
            .rd_ch_num_resp(rd_ch_num_resp),
      
            .rd_slverr(rd_slverr),
            .rd_decerr(rd_decerr),
            .rd_clr(rd_clr),
            .rd_clr_load(rd_clr_load),
      
            .ch_rd_slverr(ch_rd_slverr),
            .ch_rd_decerr(ch_rd_decerr),
            .ch_rd_clr(ch_rd_clr),
            .ch_rd_clr_load(ch_rd_clr_load),
      
            //wr cmd
            .wr_ch_num(wr_ch_num),
            .wr_cmd_num(wr_cmd_num),
      
            .wr_last_cmd(wr_last_cmd),
            .wr_line_cmd(wr_line_cmd),
            .wr_go_next_line(wr_go_next_line),
            .wr_burst_start(wr_burst_start),
            .wr_burst_addr(wr_burst_addr),
            .wr_burst_size(wr_burst_size),
            .wr_tokens(wr_tokens),
            .wr_cmd_port(wr_cmd_port),
            .wr_periph_delay(wr_periph_delay),
            .wr_clr_valid(wr_clr_valid),
            .wr_cmd_split(wr_cmd_split),
            .wr_clr_stall(wr_clr_stall),
      
            .ch_wr_last_cmd(ch_wr_last_cmd),
            .ch_wr_line_cmd(ch_wr_line_cmd),
            .ch_wr_go_next_line(ch_wr_go_next_line),
            .ch_wr_burst_start(ch_wr_burst_start),
            .ch_wr_burst_addr(ch_wr_burst_addr),
            .ch_wr_burst_size(ch_wr_burst_size),
            .ch_wr_tokens(ch_wr_tokens),
            .ch_wr_port_num(ch_wr_port_num),
            .ch_wr_periph_delay(ch_wr_periph_delay),
            .ch_wr_clr_valid(ch_wr_clr_valid),
            .ch_wr_cmd_split(ch_wr_cmd_split),
            .ch_wr_clr_stall(ch_wr_clr_stall),
      
            //wr data
            .ch_fifo_rd_num(ch_fifo_rd_num),
            .wr_transfer_num(wr_transfer_num),
            .wr_clr_line_num(wr_clr_line_num),
      
            .wr_transfer(wr_transfer),
            .wr_clr_line(wr_clr_line),
            .fifo_rd(fifo_rd),
            .fifo_wr_ready(fifo_wr_ready),
      
            .ch_wr_transfer(ch_wr_transfer),
            .ch_wr_clr_line(ch_wr_clr_line),
            .ch_fifo_rd(ch_fifo_rd),
            .ch_fifo_wr_ready(ch_fifo_wr_ready),
      
            //wr resp
            .wr_ch_num_resp(wr_ch_num_resp),
      
            .wr_slverr(wr_slverr),
            .wr_decerr(wr_decerr),
            .wr_clr(wr_clr),
            .wr_clr_last(wr_clr_last),
      
            .ch_wr_slverr(ch_wr_slverr),
            .ch_wr_decerr(ch_wr_decerr),
            .ch_wr_clr_last(ch_wr_clr_last),
            .ch_wr_clr(ch_wr_clr)
            );


   
dma_ahb32_core0_ch dma_ahb32_core0_ch0 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[0]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[0]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*0:32*0]),
            .pslverr(ch_pslverr[0]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*0+31-1:31*0]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*0+31-1:31*0]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[0]),
            .rd_cmd_line(ch_rd_cmd_line[0]),
            .rd_clr_line(ch_rd_clr_line[0]),
            .rd_clr(ch_rd_clr[0]),
            .rd_clr_load(ch_rd_clr_load[0]),
            .rd_slverr(ch_rd_slverr[0]),
            .rd_decerr(ch_rd_decerr[0]),
            .rd_line_cmd(ch_rd_line_cmd[0]),
            .rd_go_next_line(ch_rd_go_next_line[0]),
            .rd_transfer(ch_rd_transfer[0]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[0]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[0]),
            .wr_cmd_pending(ch_wr_cmd_pending[0]),
            .wr_clr_line(ch_wr_clr_line[0]),
            .wr_clr(ch_wr_clr[0]),
            .wr_clr_last(ch_wr_clr_last[0]),
            .wr_slverr(ch_wr_slverr[0]),
            .wr_decerr(ch_wr_decerr[0]),
            .wr_last_cmd(ch_wr_last_cmd[0]),
            .wr_line_cmd(ch_wr_line_cmd[0]),
            .wr_go_next_line(ch_wr_go_next_line[0]),
            .wr_transfer(ch_wr_transfer[0]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[0]),

            .timeout_aw(ch_timeout_aw[0]),
            .timeout_w(ch_timeout_w[0]),
            .timeout_ar(ch_timeout_ar[0]),
            .wdt_timeout(ch_wdt_timeout[0]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[0]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[0]),

            //CTRL
            .ch_active(ch_active[0]),
            .ch_rd_active(ch_rd_active[0]),
            .ch_wr_active(ch_wr_active[0]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[0]),
            .rd_ready(ch_rd_ready[0]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*0:32*0]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*0:7*0]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*0:`TOKEN_BITS*0]),
            .rd_port_num(ch_rd_port_num[0]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*0:`DELAY_BITS*0]),
            .rd_clr_valid(ch_rd_clr_valid[0]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[0]),
            .wr_ready(ch_wr_ready[0]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*0:32*0]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*0:7*0]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*0:`TOKEN_BITS*0]),
            .wr_port_num(ch_wr_port_num[0]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*0:`DELAY_BITS*0]),
            .wr_clr_valid(ch_wr_clr_valid[0]),

            //FIFO
            .fifo_wr(ch_fifo_wr[0]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[0]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[0]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*0:32*0]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[0]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[0]),
            .wr_page_cross(ch_wr_page_cross[0]),
            .joint_in_prog(ch_joint_in_prog[0]),
            .joint_not_in_prog(ch_joint_not_in_prog[0]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[0]),
            .joint_req(ch_joint_req[0]),

            .ch_start(ch_start[0]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*0):1*0])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty1 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[1]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[1]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*1:32*1]),
            .pslverr(ch_pslverr[1]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*1+31-1:31*1]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*1+31-1:31*1]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[1]),
            .rd_cmd_line(ch_rd_cmd_line[1]),
            .rd_clr_line(ch_rd_clr_line[1]),
            .rd_clr(ch_rd_clr[1]),
            .rd_clr_load(ch_rd_clr_load[1]),
            .rd_slverr(ch_rd_slverr[1]),
            .rd_decerr(ch_rd_decerr[1]),
            .rd_line_cmd(ch_rd_line_cmd[1]),
            .rd_go_next_line(ch_rd_go_next_line[1]),
            .rd_transfer(ch_rd_transfer[1]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[1]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[1]),
            .wr_cmd_pending(ch_wr_cmd_pending[1]),
            .wr_clr_line(ch_wr_clr_line[1]),
            .wr_clr(ch_wr_clr[1]),
            .wr_clr_last(ch_wr_clr_last[1]),
            .wr_slverr(ch_wr_slverr[1]),
            .wr_decerr(ch_wr_decerr[1]),
            .wr_last_cmd(ch_wr_last_cmd[1]),
            .wr_line_cmd(ch_wr_line_cmd[1]),
            .wr_go_next_line(ch_wr_go_next_line[1]),
            .wr_transfer(ch_wr_transfer[1]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[1]),

            .timeout_aw(ch_timeout_aw[1]),
            .timeout_w(ch_timeout_w[1]),
            .timeout_ar(ch_timeout_ar[1]),
            .wdt_timeout(ch_wdt_timeout[1]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[1]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[1]),

            //CTRL
            .ch_active(ch_active[1]),
            .ch_rd_active(ch_rd_active[1]),
            .ch_wr_active(ch_wr_active[1]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[1]),
            .rd_ready(ch_rd_ready[1]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*1:32*1]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*1:7*1]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*1:`TOKEN_BITS*1]),
            .rd_port_num(ch_rd_port_num[1]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*1:`DELAY_BITS*1]),
            .rd_clr_valid(ch_rd_clr_valid[1]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[1]),
            .wr_ready(ch_wr_ready[1]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*1:32*1]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*1:7*1]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*1:`TOKEN_BITS*1]),
            .wr_port_num(ch_wr_port_num[1]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*1:`DELAY_BITS*1]),
            .wr_clr_valid(ch_wr_clr_valid[1]),

            //FIFO
            .fifo_wr(ch_fifo_wr[1]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[1]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[1]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*1:32*1]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[1]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[1]),
            .wr_page_cross(ch_wr_page_cross[1]),
            .joint_in_prog(ch_joint_in_prog[1]),
            .joint_not_in_prog(ch_joint_not_in_prog[1]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[1]),
            .joint_req(ch_joint_req[1]),

            .ch_start(ch_start[1]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*1):1*1])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty2 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[2]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[2]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*2:32*2]),
            .pslverr(ch_pslverr[2]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*2+31-1:31*2]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*2+31-1:31*2]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[2]),
            .rd_cmd_line(ch_rd_cmd_line[2]),
            .rd_clr_line(ch_rd_clr_line[2]),
            .rd_clr(ch_rd_clr[2]),
            .rd_clr_load(ch_rd_clr_load[2]),
            .rd_slverr(ch_rd_slverr[2]),
            .rd_decerr(ch_rd_decerr[2]),
            .rd_line_cmd(ch_rd_line_cmd[2]),
            .rd_go_next_line(ch_rd_go_next_line[2]),
            .rd_transfer(ch_rd_transfer[2]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[2]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[2]),
            .wr_cmd_pending(ch_wr_cmd_pending[2]),
            .wr_clr_line(ch_wr_clr_line[2]),
            .wr_clr(ch_wr_clr[2]),
            .wr_clr_last(ch_wr_clr_last[2]),
            .wr_slverr(ch_wr_slverr[2]),
            .wr_decerr(ch_wr_decerr[2]),
            .wr_last_cmd(ch_wr_last_cmd[2]),
            .wr_line_cmd(ch_wr_line_cmd[2]),
            .wr_go_next_line(ch_wr_go_next_line[2]),
            .wr_transfer(ch_wr_transfer[2]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[2]),

            .timeout_aw(ch_timeout_aw[2]),
            .timeout_w(ch_timeout_w[2]),
            .timeout_ar(ch_timeout_ar[2]),
            .wdt_timeout(ch_wdt_timeout[2]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[2]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[2]),

            //CTRL
            .ch_active(ch_active[2]),
            .ch_rd_active(ch_rd_active[2]),
            .ch_wr_active(ch_wr_active[2]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[2]),
            .rd_ready(ch_rd_ready[2]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*2:32*2]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*2:7*2]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*2:`TOKEN_BITS*2]),
            .rd_port_num(ch_rd_port_num[2]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*2:`DELAY_BITS*2]),
            .rd_clr_valid(ch_rd_clr_valid[2]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[2]),
            .wr_ready(ch_wr_ready[2]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*2:32*2]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*2:7*2]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*2:`TOKEN_BITS*2]),
            .wr_port_num(ch_wr_port_num[2]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*2:`DELAY_BITS*2]),
            .wr_clr_valid(ch_wr_clr_valid[2]),

            //FIFO
            .fifo_wr(ch_fifo_wr[2]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[2]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[2]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*2:32*2]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[2]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[2]),
            .wr_page_cross(ch_wr_page_cross[2]),
            .joint_in_prog(ch_joint_in_prog[2]),
            .joint_not_in_prog(ch_joint_not_in_prog[2]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[2]),
            .joint_req(ch_joint_req[2]),

            .ch_start(ch_start[2]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*2):1*2])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty3 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[3]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[3]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*3:32*3]),
            .pslverr(ch_pslverr[3]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*3+31-1:31*3]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*3+31-1:31*3]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[3]),
            .rd_cmd_line(ch_rd_cmd_line[3]),
            .rd_clr_line(ch_rd_clr_line[3]),
            .rd_clr(ch_rd_clr[3]),
            .rd_clr_load(ch_rd_clr_load[3]),
            .rd_slverr(ch_rd_slverr[3]),
            .rd_decerr(ch_rd_decerr[3]),
            .rd_line_cmd(ch_rd_line_cmd[3]),
            .rd_go_next_line(ch_rd_go_next_line[3]),
            .rd_transfer(ch_rd_transfer[3]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[3]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[3]),
            .wr_cmd_pending(ch_wr_cmd_pending[3]),
            .wr_clr_line(ch_wr_clr_line[3]),
            .wr_clr(ch_wr_clr[3]),
            .wr_clr_last(ch_wr_clr_last[3]),
            .wr_slverr(ch_wr_slverr[3]),
            .wr_decerr(ch_wr_decerr[3]),
            .wr_last_cmd(ch_wr_last_cmd[3]),
            .wr_line_cmd(ch_wr_line_cmd[3]),
            .wr_go_next_line(ch_wr_go_next_line[3]),
            .wr_transfer(ch_wr_transfer[3]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[3]),

            .timeout_aw(ch_timeout_aw[3]),
            .timeout_w(ch_timeout_w[3]),
            .timeout_ar(ch_timeout_ar[3]),
            .wdt_timeout(ch_wdt_timeout[3]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[3]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[3]),

            //CTRL
            .ch_active(ch_active[3]),
            .ch_rd_active(ch_rd_active[3]),
            .ch_wr_active(ch_wr_active[3]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[3]),
            .rd_ready(ch_rd_ready[3]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*3:32*3]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*3:7*3]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*3:`TOKEN_BITS*3]),
            .rd_port_num(ch_rd_port_num[3]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*3:`DELAY_BITS*3]),
            .rd_clr_valid(ch_rd_clr_valid[3]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[3]),
            .wr_ready(ch_wr_ready[3]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*3:32*3]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*3:7*3]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*3:`TOKEN_BITS*3]),
            .wr_port_num(ch_wr_port_num[3]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*3:`DELAY_BITS*3]),
            .wr_clr_valid(ch_wr_clr_valid[3]),

            //FIFO
            .fifo_wr(ch_fifo_wr[3]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[3]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[3]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*3:32*3]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[3]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[3]),
            .wr_page_cross(ch_wr_page_cross[3]),
            .joint_in_prog(ch_joint_in_prog[3]),
            .joint_not_in_prog(ch_joint_not_in_prog[3]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[3]),
            .joint_req(ch_joint_req[3]),

            .ch_start(ch_start[3]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*3):1*3])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty4 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[4]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[4]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*4:32*4]),
            .pslverr(ch_pslverr[4]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*4+31-1:31*4]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*4+31-1:31*4]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[4]),
            .rd_cmd_line(ch_rd_cmd_line[4]),
            .rd_clr_line(ch_rd_clr_line[4]),
            .rd_clr(ch_rd_clr[4]),
            .rd_clr_load(ch_rd_clr_load[4]),
            .rd_slverr(ch_rd_slverr[4]),
            .rd_decerr(ch_rd_decerr[4]),
            .rd_line_cmd(ch_rd_line_cmd[4]),
            .rd_go_next_line(ch_rd_go_next_line[4]),
            .rd_transfer(ch_rd_transfer[4]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[4]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[4]),
            .wr_cmd_pending(ch_wr_cmd_pending[4]),
            .wr_clr_line(ch_wr_clr_line[4]),
            .wr_clr(ch_wr_clr[4]),
            .wr_clr_last(ch_wr_clr_last[4]),
            .wr_slverr(ch_wr_slverr[4]),
            .wr_decerr(ch_wr_decerr[4]),
            .wr_last_cmd(ch_wr_last_cmd[4]),
            .wr_line_cmd(ch_wr_line_cmd[4]),
            .wr_go_next_line(ch_wr_go_next_line[4]),
            .wr_transfer(ch_wr_transfer[4]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[4]),

            .timeout_aw(ch_timeout_aw[4]),
            .timeout_w(ch_timeout_w[4]),
            .timeout_ar(ch_timeout_ar[4]),
            .wdt_timeout(ch_wdt_timeout[4]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[4]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[4]),

            //CTRL
            .ch_active(ch_active[4]),
            .ch_rd_active(ch_rd_active[4]),
            .ch_wr_active(ch_wr_active[4]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[4]),
            .rd_ready(ch_rd_ready[4]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*4:32*4]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*4:7*4]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*4:`TOKEN_BITS*4]),
            .rd_port_num(ch_rd_port_num[4]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*4:`DELAY_BITS*4]),
            .rd_clr_valid(ch_rd_clr_valid[4]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[4]),
            .wr_ready(ch_wr_ready[4]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*4:32*4]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*4:7*4]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*4:`TOKEN_BITS*4]),
            .wr_port_num(ch_wr_port_num[4]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*4:`DELAY_BITS*4]),
            .wr_clr_valid(ch_wr_clr_valid[4]),

            //FIFO
            .fifo_wr(ch_fifo_wr[4]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[4]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[4]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*4:32*4]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[4]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[4]),
            .wr_page_cross(ch_wr_page_cross[4]),
            .joint_in_prog(ch_joint_in_prog[4]),
            .joint_not_in_prog(ch_joint_not_in_prog[4]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[4]),
            .joint_req(ch_joint_req[4]),

            .ch_start(ch_start[4]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*4):1*4])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty5 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[5]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[5]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*5:32*5]),
            .pslverr(ch_pslverr[5]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*5+31-1:31*5]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*5+31-1:31*5]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[5]),
            .rd_cmd_line(ch_rd_cmd_line[5]),
            .rd_clr_line(ch_rd_clr_line[5]),
            .rd_clr(ch_rd_clr[5]),
            .rd_clr_load(ch_rd_clr_load[5]),
            .rd_slverr(ch_rd_slverr[5]),
            .rd_decerr(ch_rd_decerr[5]),
            .rd_line_cmd(ch_rd_line_cmd[5]),
            .rd_go_next_line(ch_rd_go_next_line[5]),
            .rd_transfer(ch_rd_transfer[5]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[5]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[5]),
            .wr_cmd_pending(ch_wr_cmd_pending[5]),
            .wr_clr_line(ch_wr_clr_line[5]),
            .wr_clr(ch_wr_clr[5]),
            .wr_clr_last(ch_wr_clr_last[5]),
            .wr_slverr(ch_wr_slverr[5]),
            .wr_decerr(ch_wr_decerr[5]),
            .wr_last_cmd(ch_wr_last_cmd[5]),
            .wr_line_cmd(ch_wr_line_cmd[5]),
            .wr_go_next_line(ch_wr_go_next_line[5]),
            .wr_transfer(ch_wr_transfer[5]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[5]),

            .timeout_aw(ch_timeout_aw[5]),
            .timeout_w(ch_timeout_w[5]),
            .timeout_ar(ch_timeout_ar[5]),
            .wdt_timeout(ch_wdt_timeout[5]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[5]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[5]),

            //CTRL
            .ch_active(ch_active[5]),
            .ch_rd_active(ch_rd_active[5]),
            .ch_wr_active(ch_wr_active[5]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[5]),
            .rd_ready(ch_rd_ready[5]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*5:32*5]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*5:7*5]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*5:`TOKEN_BITS*5]),
            .rd_port_num(ch_rd_port_num[5]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*5:`DELAY_BITS*5]),
            .rd_clr_valid(ch_rd_clr_valid[5]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[5]),
            .wr_ready(ch_wr_ready[5]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*5:32*5]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*5:7*5]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*5:`TOKEN_BITS*5]),
            .wr_port_num(ch_wr_port_num[5]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*5:`DELAY_BITS*5]),
            .wr_clr_valid(ch_wr_clr_valid[5]),

            //FIFO
            .fifo_wr(ch_fifo_wr[5]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[5]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[5]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*5:32*5]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[5]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[5]),
            .wr_page_cross(ch_wr_page_cross[5]),
            .joint_in_prog(ch_joint_in_prog[5]),
            .joint_not_in_prog(ch_joint_not_in_prog[5]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[5]),
            .joint_req(ch_joint_req[5]),

            .ch_start(ch_start[5]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*5):1*5])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty6 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[6]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[6]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*6:32*6]),
            .pslverr(ch_pslverr[6]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*6+31-1:31*6]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*6+31-1:31*6]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[6]),
            .rd_cmd_line(ch_rd_cmd_line[6]),
            .rd_clr_line(ch_rd_clr_line[6]),
            .rd_clr(ch_rd_clr[6]),
            .rd_clr_load(ch_rd_clr_load[6]),
            .rd_slverr(ch_rd_slverr[6]),
            .rd_decerr(ch_rd_decerr[6]),
            .rd_line_cmd(ch_rd_line_cmd[6]),
            .rd_go_next_line(ch_rd_go_next_line[6]),
            .rd_transfer(ch_rd_transfer[6]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[6]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[6]),
            .wr_cmd_pending(ch_wr_cmd_pending[6]),
            .wr_clr_line(ch_wr_clr_line[6]),
            .wr_clr(ch_wr_clr[6]),
            .wr_clr_last(ch_wr_clr_last[6]),
            .wr_slverr(ch_wr_slverr[6]),
            .wr_decerr(ch_wr_decerr[6]),
            .wr_last_cmd(ch_wr_last_cmd[6]),
            .wr_line_cmd(ch_wr_line_cmd[6]),
            .wr_go_next_line(ch_wr_go_next_line[6]),
            .wr_transfer(ch_wr_transfer[6]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[6]),

            .timeout_aw(ch_timeout_aw[6]),
            .timeout_w(ch_timeout_w[6]),
            .timeout_ar(ch_timeout_ar[6]),
            .wdt_timeout(ch_wdt_timeout[6]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[6]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[6]),

            //CTRL
            .ch_active(ch_active[6]),
            .ch_rd_active(ch_rd_active[6]),
            .ch_wr_active(ch_wr_active[6]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[6]),
            .rd_ready(ch_rd_ready[6]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*6:32*6]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*6:7*6]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*6:`TOKEN_BITS*6]),
            .rd_port_num(ch_rd_port_num[6]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*6:`DELAY_BITS*6]),
            .rd_clr_valid(ch_rd_clr_valid[6]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[6]),
            .wr_ready(ch_wr_ready[6]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*6:32*6]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*6:7*6]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*6:`TOKEN_BITS*6]),
            .wr_port_num(ch_wr_port_num[6]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*6:`DELAY_BITS*6]),
            .wr_clr_valid(ch_wr_clr_valid[6]),

            //FIFO
            .fifo_wr(ch_fifo_wr[6]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[6]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[6]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*6:32*6]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[6]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[6]),
            .wr_page_cross(ch_wr_page_cross[6]),
            .joint_in_prog(ch_joint_in_prog[6]),
            .joint_not_in_prog(ch_joint_not_in_prog[6]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[6]),
            .joint_req(ch_joint_req[6]),

            .ch_start(ch_start[6]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*6):1*6])
            );
          
dma_ahb32_core0_ch_empty dma_ahb32_core0_ch_empty7 (
            .clk(clk),
            .reset(reset),
            .scan_en(scan_en),
            .idle(ch_idle[7]),

            //APB
            .pclk(pclk),
            .clken(clken),
            .pclken(pclken),
            .psel(ch_psel[7]),
            .penable(penable),
            .paddr(paddr[7:0]),
            .pwrite(pwrite),
            .pwdata(pwdata),
            .prdata(ch_prdata[31+32*7:32*7]),
            .pslverr(ch_pslverr[7]),

            //PERIPH
            .periph_tx_req(periph_tx_req),
            .periph_tx_clr(ch_periph_tx_clr[31*7+31-1:31*7]),
            .periph_rx_req(periph_rx_req),
            .periph_rx_clr(ch_periph_rx_clr[31*7+31-1:31*7]),

            //RD AXIM
            .rd_cmd_split(ch_rd_cmd_split[7]),
            .rd_cmd_line(ch_rd_cmd_line[7]),
            .rd_clr_line(ch_rd_clr_line[7]),
            .rd_clr(ch_rd_clr[7]),
            .rd_clr_load(ch_rd_clr_load[7]),
            .rd_slverr(ch_rd_slverr[7]),
            .rd_decerr(ch_rd_decerr[7]),
            .rd_line_cmd(ch_rd_line_cmd[7]),
            .rd_go_next_line(ch_rd_go_next_line[7]),
            .rd_transfer(ch_rd_transfer[7]),
            .rd_transfer_size(rd_transfer_size),
                .rd_clr_stall(ch_rd_clr_stall[7]),

            //WR AXIM
            .wr_cmd_split(ch_wr_cmd_split[7]),
            .wr_cmd_pending(ch_wr_cmd_pending[7]),
            .wr_clr_line(ch_wr_clr_line[7]),
            .wr_clr(ch_wr_clr[7]),
            .wr_clr_last(ch_wr_clr_last[7]),
            .wr_slverr(ch_wr_slverr[7]),
            .wr_decerr(ch_wr_decerr[7]),
            .wr_last_cmd(ch_wr_last_cmd[7]),
            .wr_line_cmd(ch_wr_line_cmd[7]),
            .wr_go_next_line(ch_wr_go_next_line[7]),
            .wr_transfer(ch_wr_transfer[7]),
            .wr_transfer_size(wr_transfer_size),
            .wr_next_size(wr_next_size),
                .wr_clr_stall(ch_wr_clr_stall[7]),

            .timeout_aw(ch_timeout_aw[7]),
            .timeout_w(ch_timeout_w[7]),
            .timeout_ar(ch_timeout_ar[7]),
            .wdt_timeout(ch_wdt_timeout[7]),
                               
            //LOAD CMD
            .load_wr(ch_load_wr[7]),
            .load_wr_cycle(load_wr_cycle),
            .load_wdata(load_wdata),
            .load_req_in_prog(ch_load_req_in_prog[7]),

            //CTRL
            .ch_active(ch_active[7]),
            .ch_rd_active(ch_rd_active[7]),
            .ch_wr_active(ch_wr_active[7]),

            //RD CTRL
            .rd_burst_start(ch_rd_burst_start[7]),
            .rd_ready(ch_rd_ready[7]),
            .rd_burst_addr(ch_rd_burst_addr[32-1+32*7:32*7]),
            .rd_burst_size(ch_rd_burst_size[7-1+7*7:7*7]),
            .rd_tokens(ch_rd_tokens[`TOKEN_BITS-1+`TOKEN_BITS*7:`TOKEN_BITS*7]),
            .rd_port_num(ch_rd_port_num[7]),
            .rd_periph_delay(ch_rd_periph_delay[`DELAY_BITS-1+`DELAY_BITS*7:`DELAY_BITS*7]),
            .rd_clr_valid(ch_rd_clr_valid[7]),
            
            //WR CTRL
            .wr_burst_start(ch_wr_burst_start[7]),
            .wr_ready(ch_wr_ready[7]),
            .wr_burst_addr(ch_wr_burst_addr[32-1+32*7:32*7]),
            .wr_burst_size(ch_wr_burst_size[7-1+7*7:7*7]),
            .wr_tokens(ch_wr_tokens[`TOKEN_BITS-1+`TOKEN_BITS*7:`TOKEN_BITS*7]),
            .wr_port_num(ch_wr_port_num[7]),
            .wr_periph_delay(ch_wr_periph_delay[`DELAY_BITS-1+`DELAY_BITS*7:`DELAY_BITS*7]),
            .wr_clr_valid(ch_wr_clr_valid[7]),

            //FIFO
            .fifo_wr(ch_fifo_wr[7]),                        
                    .fifo_wdata(fifo_wdata),                   
                    .fifo_wsize(fifo_wsize),                   
                    .fifo_rd(ch_fifo_rd[7]),                   
                    .fifo_rsize(fifo_rsize),                   
                    .fifo_rd_valid(ch_fifo_rd_valid[7]),                   
                    .fifo_rdata(ch_fifo_rdata[(32-1)+32*7:32*7]),       
                    .fifo_wr_ready(ch_fifo_wr_ready[7]),     

                .joint_mode(joint_mode),
                .joint_remote(joint_remote),
            .rd_page_cross(ch_rd_page_cross[7]),
            .wr_page_cross(ch_wr_page_cross[7]),
            .joint_in_prog(ch_joint_in_prog[7]),
            .joint_not_in_prog(ch_joint_not_in_prog[7]),
            .joint_mux_in_prog(ch_joint_mux_in_prog[7]),
            .joint_req(ch_joint_req[7]),

            .ch_start(ch_start[7]),

            //INT
            .int_all_proc(ch_int_all_proc[1-1+(1*7):1*7])
            );
          

   
endmodule
   


