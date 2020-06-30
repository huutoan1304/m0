/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Author: Eyal Hochberg                                      ////
////          eyal@provartec.com                                 ////
////                                                             ////
////  Downloaded from: http://www.opencores.org                  ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2010 Provartec LTD                            ////
//// www.provartec.com                                           ////
//// info@provartec.com                                          ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
//// This source file is free software; you can redistribute it  ////
//// and/or modify it under the terms of the GNU Lesser General  ////
//// Public License as published by the Free Software Foundation.////
////                                                             ////
//// This source is distributed in the hope that it will be      ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied  ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR     ////
//// PURPOSE.  See the GNU Lesser General Public License for more////
//// details. http://www.gnu.org/licenses/lgpl.html              ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:31:22 2011
//--
//-- Source file: dma_reg_core.v
//---------------------------------------------------------



module dma_ahb32_reg_core0(clk,reset,wr_joint,wr_clkdiv,wr_start,wr_prio,pwdata,clkdiv,ch_start,joint_mode,rd_prio_top,rd_prio_high,rd_prio_top_num,rd_prio_high_num,wr_prio_top,wr_prio_high,wr_prio_top_num,wr_prio_high_num,user_def_stat0,user_def_stat1,ch_int_all_proc,proc0_int_stat);

   input                       clk;
   input                   reset;

   input                              wr_joint;
   input                              wr_clkdiv;
   input                              wr_start;
   input                              wr_prio;

   input [31:0]                       pwdata;
      
   output [3:0]               clkdiv;
   output [7:0]               ch_start;
   output                   joint_mode;
   output                   rd_prio_top;
   output                   rd_prio_high;
   output [2:0]               rd_prio_top_num;
   output [2:0]               rd_prio_high_num;
   output                   wr_prio_top;
   output                   wr_prio_high;
   output [2:0]               wr_prio_top_num;
   output [2:0]               wr_prio_high_num;

   output [31:0]                      user_def_stat0;
   output [31:0]                      user_def_stat1;
   
   input [8*1-1:0]             ch_int_all_proc;
   output [7:0]                       proc0_int_stat;
   
   

   
   wire                   user_def_clkdiv;
   wire                   user_def_bus_32;
   wire [3:0]                   user_def_ch_num;
   wire [3:0]                   user_def_fifo_size;
   wire [3:0]                   user_def_wcmd_depth;
   wire [3:0]                   user_def_rcmd_depth;
   wire                   user_def_block;
   wire                   user_def_wait;
   wire                   user_def_outs;
   wire                   user_def_prio;
   wire                   user_def_tokens;
   wire                   user_def_timeout;
   wire                   user_def_wdt;
   wire                   user_def_joint;
   wire                   user_def_simul;
   wire                   user_def_periph;
   wire                   user_def_lists;
   wire                   user_def_end;
   wire [5:0]                   user_def_addr_bits; //max 32
   wire [4:0]                   user_def_buff_bits; //max 16
  
   
     reg               joint_mode; 

   
   assign                   user_def_clkdiv     = 0;
   assign                   user_def_bus_32     = 1;
   assign                   user_def_ch_num     = 1;
   assign                   user_def_fifo_size  = 5;
   assign                   user_def_wcmd_depth = 1;
   assign                   user_def_rcmd_depth = 1;
   assign                   user_def_block      = 0;
   assign                   user_def_wait       = 0;
   assign                   user_def_outs       = 0;
   assign                   user_def_prio       = 0;
   assign                   user_def_tokens     = 1;
   assign                   user_def_timeout    = 1;
   assign                   user_def_wdt        = 1;
   assign                   user_def_joint      = 1;
   assign                   user_def_simul      = 1;
   assign                   user_def_periph     = 1;
   assign                   user_def_lists      = 1;
   assign                   user_def_end        = 1;
   assign                   user_def_addr_bits  = 32;
   assign                   user_def_buff_bits  = 10;

   
   assign                   user_def_stat0 =
                      {
                       3'b000,               //[31:29]
                       user_def_buff_bits,   //[28:24]
                       1'b0,                 //[23]
                        user_def_bus_32,      //[22]
                       user_def_addr_bits,   //[21:16]
                        user_def_rcmd_depth,  //[15:12]
                        user_def_wcmd_depth,  //[11:8]
                        user_def_fifo_size,   //[7:4]
                        user_def_ch_num       //[3:0]
                       };

   assign                   user_def_stat1 =
                      {
                       {21{1'b0}},           //[31:13]
                       user_def_clkdiv,      //[12]
                       user_def_end,         //[11]
                       user_def_lists,       //[10]
                       user_def_periph,      //[9]
                       user_def_simul,       //[8]
                       user_def_joint,       //[7]
                           user_def_block,       //[6]
                           user_def_wait,        //[5]
                           user_def_outs,        //[4]
                           user_def_prio,        //[3]
                           user_def_tokens,      //[2]
                           user_def_timeout,     //[1]
                           user_def_wdt          //[0]
                       };

   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      joint_mode <= #1 1'b0;
       end
     else if (wr_joint)
       begin
      joint_mode <= #1 pwdata[0];
       end

   
   assign rd_prio_top      = 'd0;
   assign rd_prio_high     = 'd0;
   assign rd_prio_top_num  = 'd0;
   assign rd_prio_high_num = 'd0;
   assign wr_prio_top      = 'd0;
   assign wr_prio_high     = 'd0;
   assign wr_prio_top_num  = 'd0;
   assign wr_prio_high_num = 'd0;


   assign clkdiv = 4'd0;

  
   assign              ch_start = {8{wr_start}} & pwdata[7:0];
     

   //interrupt
   prgen_scatter8_1 #(0) scatter_proc0(.ch_x(ch_int_all_proc), .x(proc0_int_stat));
   
endmodule

   


