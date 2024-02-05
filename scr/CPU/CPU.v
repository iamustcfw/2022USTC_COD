`timescale 1ns / 1ps

/* 
 *   Author: YOU
 *   Last update: 2023.04.20
 */


module CPU(
    input clk, 
    input rst,

    // MEM And MMIO Data BUS
    output [31:0] im_addr,      // Instruction address (The same as current PC)
    input [31:0] im_dout,       // Instruction data (Current instruction)
    output [31:0] mem_addr,     // Memory read/write address
    output mem_we,              // Memory writing enable		            
    output [31:0] mem_din,      // Data ready to write to memory
    input [31:0] mem_dout,	    // Data read from memory

    // Debug BUS with PDU
    output [31:0] current_pc, 	        // Current_pc, pc_out
    output [31:0] next_pc,              // Next_pc, pc_in    
    input [31:0] cpu_check_addr,	    // Check current datapath state (code)
    output [31:0] cpu_check_data,    // Current datapath state data

    output ebreak_pdu,
    output [31:0] mem_inst
);
    
    
    // Write your CPU here!
    // You might need to write these modules:
    //      ALU锟斤拷RF锟斤拷Control锟斤拷Add(Or just add-mode ALU)锟斤拷And(Or just and-mode ALU)锟斤拷PCReg锟斤拷Imm锟斤拷Branch锟斤拷Mux锟�1锟�71锟�1锟�779锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777777777...

    wire[31:0]pc_cur_if, pc_add4_if;
    alu pcadd4(.a(pc_cur_if), .b(32'b100), .func(4'b0000), .y(pc_add4_if));

    wire[31:0]pc_next, real_pc_next;
    wire stall_if;
    PC pc(.pc_next(real_pc_next), .clk(clk), .stall(stall_if), .rst(rst), .pc_cur(pc_cur_if));
    wire hit_if, hit_id, hit_ex;

    wire[31:0]inst_raw, inst_if;
    wire flush_if;
    MUX2 inst_flush(.src0(inst_raw), .src1(32'h00000033), .sel(flush_if), .res(inst_if));

        wire [31:0]pc_cur_id, inst_id, pc_add4_id, rf_rd0_raw_id, rf_rd1_raw_id, rf_rd_dbg_id, rf_wd_wb;//
    wire [4:0]rf_ra0_id, rf_ra1_id, rf_wa_id, rf_wa_wb;
    wire rf_we_wb;



    wire[31:0] imm_id;
    Immediate immediate(.inst(inst_id), .imm(imm_id));

    wire rf_re0_id, rf_re1_id, rf_we_id, alu_src1_sel_id, alu_src2_sel_id, jal_id, jalr_id, mem_we_id, ebreak;
    wire [1:0]rf_wd_sel_id;
    wire [2:0] br_type_id; 
    wire [3:0]alu_func_id;
    CTRL ctrl(.inst(inst_id), .rf_re0(rf_re0_id), .rf_re1(rf_re1_id), .rf_wd_sel(rf_wd_sel_id), .rf_we(rf_we_id),
              .alu_src1_sel(alu_src1_sel_id), .alu_src2_sel(alu_src2_sel_id), .alu_ctrl(alu_func_id), .jal(jal_id),
              .jalr(jalr_id), .br_type(br_type_id), .mem_we(mem_we_id), .ebreak(ebreak));  
              
    RF rf(.ra0(rf_ra0_id), .ra1(rf_ra1_id), .wa(rf_wa_wb), .wd(rf_wd_wb), .ra_dbg(cpu_check_addr[4:0]), 
          .we(rf_we_wb), .clk(clk), .rd0(rf_rd0_raw_id), .rd1(rf_rd1_raw_id), .rd_dbg(rf_rd_dbg_id));              
              

    wire flush_id, stall_id;
    SEG_REG seg_reg_if_id(     .pc_cur_in(pc_cur_if),
                    .inst_in(inst_if),
                    .rf_ra0_in(inst_if[19:15]),
                    .rf_ra1_in(inst_if[24:20]),
                    .rf_re0_in(1'h0),
                    .rf_re1_in(1'h0),
                    .rf_rd0_raw_in(32'h0),
                    .rf_rd1_raw_in(32'h0),
                    .rf_rd0_in(32'h0),
                    .rf_rd1_in(32'h0),
                    .rf_wa_in(inst_if[11:7]),
                    .rf_wd_sel_in(2'h0),
                    .rf_we_in(1'h0),
                    .imm_type_in(3'h0),//
                    .imm_in(32'h0),
                    .alu_src1_sel_in(1'h0),
                    .alu_src2_sel_in(1'h0),
                    .alu_src1_in(32'h0),
                    .alu_src2_in(32'h0),
                    .alu_func_in(4'h0),
                    .alu_ans_in(32'h0),
                    .pc_add4_in(pc_add4_if),
                    .pc_br_in(32'h0),
                    .pc_jal_in(32'h0),
                    .pc_jalr_in(32'h0),
                    .jal_in(1'h0),
                    .jalr_in(1'h0),
                    .br_type_in(3'h0),
                    .br_in(1'h0),
                    .pc_sel_in(2'h0),
                    .pc_next_in(32'h0),
                    .dm_addr_in(32'h0),
                    .dm_din_in(32'h0),
                    .dm_dout_in(32'h0),
                    .dm_we_in(1'h0),

                    .clk(clk),
                    .flush(flush_id),
                    .stall(stall_id),
                    
                    .pc_cur_out(pc_cur_id),
                    .inst_out(inst_id), 
                    .rf_ra0_out(rf_ra0_id),
                    .rf_ra1_out(rf_ra1_id),
                    .rf_re0_out(),
                    .rf_re1_out(),
                    .rf_rd0_raw_out(),
                    .rf_rd1_raw_out(),
                    .rf_rd0_out(),
                    .rf_rd1_out(),
                    .rf_wa_out(rf_wa_id),
                    .rf_wd_sel_out(),
                    .rf_we_out(),
                    .imm_type_out(),
                    .imm_out(),
                    .alu_src1_sel_out(),
                    .alu_src2_sel_out(),
                    .alu_src1_out(),
                    .alu_src2_out(),
                    .alu_func_out(),
                    .alu_ans_out(),
                    .pc_add4_out(pc_add4_id),
                    .pc_br_out(),
                    .pc_jal_out(),
                    .pc_jalr_out(),
                    .jal_out(),
                    .jalr_out(),
                    .br_type_out(),
                    .br_out(),
                    .pc_sel_out(),
                    .pc_next_out(),
                    .dm_addr_out(),
                    .dm_din_out(),      
                    .dm_dout_out(),
                    .dm_we_out(),

                    .hit_in(hit_if),
                    .hit_out(hit_id));
                    
    wire flush_ex, stall_ex, rf_we_ex, alu_src1_sel_ex, alu_src2_sel_ex, jal_ex, jalr_ex, dm_we_ex, rf_re0_ex, rf_re1_ex;   
    wire [31:0]pc_cur_ex, inst_ex, imm_ex, pc_add4_ex, rf_rd0_raw_ex, rf_rd1_raw_ex, alu_ans_ex, pc_jalr_ex;//, dm_din_ex
    wire [4:0]rf_ra0_ex, rf_ra1_ex, rf_wa_ex;  
    wire [1:0]rf_wd_sel_ex  ;  
    wire [2:0] br_type_ex;
    wire [3:0]alu_func_ex;                            


    SEG_REG seg_reg_id_ex(     .pc_cur_in(pc_cur_id),
                    .inst_in(inst_id),
                    .rf_ra0_in(rf_ra0_id),
                    .rf_ra1_in(rf_ra1_id),
                    .rf_re0_in(rf_re0_id),
                    .rf_re1_in(rf_re1_id),
                    .rf_rd0_raw_in(rf_rd0_raw_id),
                    .rf_rd1_raw_in(rf_rd1_raw_id),
                    .rf_rd0_in(32'h0),
                    .rf_rd1_in(32'h0),
                    .rf_wa_in(rf_wa_id),
                    .rf_wd_sel_in(rf_wd_sel_id),
                    .rf_we_in(rf_we_id),
                    .imm_type_in(3'b0),//
                    .imm_in(imm_id),
                    .alu_src1_sel_in(alu_src1_sel_id),
                    .alu_src2_sel_in(alu_src2_sel_id),
                    .alu_src1_in(32'h0),
                    .alu_src2_in(32'h0),
                    .alu_func_in(alu_func_id),
                    .alu_ans_in(32'h0),
                    .pc_add4_in(pc_add4_id),
                    .pc_br_in(32'h0),
                    .pc_jal_in(32'h0),
                    .pc_jalr_in(32'h0),
                    .jal_in(jal_id),
                    .jalr_in(jalr_id),
                    .br_type_in(br_type_id),
                    .br_in(1'h0),
                    .pc_sel_in(2'h0),
                    .pc_next_in(32'h0),
                    .dm_addr_in(32'h0),
                    .dm_din_in(rf_rd1_raw_id),           //????
                    .dm_dout_in(32'h0),
                    .dm_we_in(mem_we_id),

                    .clk(clk),
                    .flush(flush_ex),
                    .stall(stall_ex),
                    
                    .pc_cur_out(pc_cur_ex),
                    .inst_out(inst_ex), 
                    .rf_ra0_out(rf_ra0_ex),
                    .rf_ra1_out(rf_ra1_ex),
                    .rf_re0_out(rf_re0_ex),
                    .rf_re1_out(rf_re1_ex),
                    .rf_rd0_raw_out(rf_rd0_raw_ex),
                    .rf_rd1_raw_out(rf_rd1_raw_ex),
                    .rf_rd0_out(),
                    .rf_rd1_out(),
                    .rf_wa_out(rf_wa_ex),
                    .rf_wd_sel_out(rf_wd_sel_ex),
                    .rf_we_out(rf_we_ex),
                    .imm_type_out(),
                    .imm_out(imm_ex),
                    .alu_src1_sel_out(alu_src1_sel_ex),
                    .alu_src2_sel_out(alu_src2_sel_ex),
                    .alu_src1_out(),
                    .alu_src2_out(),
                    .alu_func_out(alu_func_ex),
                    .alu_ans_out(),
                    .pc_add4_out(pc_add4_ex),
                    .pc_br_out(),
                    .pc_jal_out(),
                    .pc_jalr_out(),
                    .jal_out(jal_ex),
                    .jalr_out(jalr_ex),
                    .br_type_out(br_type_ex),
                    .br_out(),
                    .pc_sel_out(),
                    .pc_next_out(),
                    .dm_addr_out(),
                    .dm_din_out(),      
                    .dm_dout_out(),
                    .dm_we_out(dm_we_ex),

                    .hit_in(hit_id),
                    .hit_out(hit_ex));


       

    alu AND(.a(alu_ans_ex), .b(32'hfffffffe), .func(4'b0101), .y(pc_jalr_ex));

    wire [31:0]rf_rd0_ex, rf_rd1_ex, alu_src1_ex, alu_src2_ex;
    MUX2 alu_sel1(.src0(rf_rd0_ex), .src1(pc_cur_ex), .sel(alu_src1_sel_ex), .res(alu_src1_ex));

    MUX2 alu_sel2(.src0(rf_rd1_ex), .src1(imm_ex), .sel(alu_src2_sel_ex), .res(alu_src2_ex));

    alu alu(.a(alu_src1_ex), .b(alu_src2_ex), .func(alu_func_ex), .y(alu_ans_ex));

    wire br_ex;


    wire [1:0]pc_sel_ex;
    Encoder encoder(.jal(jal_ex), .jalr(jalr_ex), .br(br_ex), .pc_sel(pc_sel_ex));

    wire [31:0]rf_rd0_fd, rf_rd1_fd;
    wire rf_rd0_fe, rf_rd1_fe;
    MUX2 rf_rd0_fwd(.src0(rf_rd0_raw_ex), .src1(rf_rd0_fd), .sel(rf_rd0_fe), .res(rf_rd0_ex));
    MUX2 rf_rd1_fwd(.src0(rf_rd1_raw_ex), .src1(rf_rd1_fd), .sel(rf_rd1_fe), .res(rf_rd1_ex));

    wire flush_mem, rf_re0_mem, rf_re1_mem, rf_we_mem, alu_src1_sel_mem, alu_src2_sel_mem, jal_mem, jalr_mem, br_mem, dm_we_mem;
    wire [31:0]pc_cur_mem, inst_mem, rf_rd0_raw_mem, rf_rd1_raw_mem, rf_rd0_mem, rf_rd1_mem, imm_mem, alu_src1_mem, alu_src2_mem, alu_ans_mem;
    wire [31:0]pc_add4_mem, pc_br_mem, pc_jal_mem, pc_jalr_mem, pc_next_mem, dm_addr_mem, dm_din_mem;
    wire [4:0]rf_ra0_mem, rf_ra1_mem, rf_wa_mem;
    wire [1:0]rf_wd_sel_mem, pc_sel_mem;
    wire [3:0] alu_func_mem;
    wire [2:0]br_type_mem;


        SEG_REG seg_reg_ex_mem(     .pc_cur_in(pc_cur_ex),
                    .inst_in(inst_ex),
                    .rf_ra0_in(rf_ra0_ex),
                    .rf_ra1_in(rf_ra1_ex),
                    .rf_re0_in(rf_re0_ex),
                    .rf_re1_in(rf_re1_ex),
                    .rf_rd0_raw_in(rf_rd0_raw_ex),
                    .rf_rd1_raw_in(rf_rd1_raw_ex),
                    .rf_rd0_in(rf_rd0_ex),
                    .rf_rd1_in(rf_rd1_ex),
                    .rf_wa_in(rf_wa_ex),
                    .rf_wd_sel_in(rf_wd_sel_ex),
                    .rf_we_in(rf_we_ex),
                    .imm_type_in(3'b0),//
                    .imm_in(imm_ex),
                    .alu_src1_sel_in(alu_src1_sel_ex),
                    .alu_src2_sel_in(alu_src2_sel_ex),
                    .alu_src1_in(alu_src1_ex),
                    .alu_src2_in(alu_src2_ex),
                    .alu_func_in(alu_func_ex),
                    .alu_ans_in(alu_ans_ex),
                    .pc_add4_in(pc_add4_ex),
                    .pc_br_in(alu_ans_ex),
                    .pc_jal_in(alu_ans_ex),
                    .pc_jalr_in(pc_jalr_ex),
                    .jal_in(jal_ex),
                    .jalr_in(jalr_ex),
                    .br_type_in(br_type_ex),
                    .br_in(br_ex),
                    .pc_sel_in(pc_sel_ex),
                    .pc_next_in(pc_next),
                    .dm_addr_in(alu_ans_ex),
                    .dm_din_in(rf_rd1_ex),      //??
                    .dm_dout_in(32'h0),
                    .dm_we_in(dm_we_ex),

                    .clk(clk),
                    .flush(flush_mem),
                    .stall(1'h0),
                    
                    .pc_cur_out(pc_cur_mem),
                    .inst_out(inst_mem), 
                    .rf_ra0_out(rf_ra0_mem),
                    .rf_ra1_out(rf_ra1_mem),
                    .rf_re0_out(rf_re0_mem),
                    .rf_re1_out(rf_re1_mem),
                    .rf_rd0_raw_out(rf_rd0_raw_mem),
                    .rf_rd1_raw_out(rf_rd1_raw_mem),
                    .rf_rd0_out(rf_rd0_mem),
                    .rf_rd1_out(rf_rd1_mem),
                    .rf_wa_out(rf_wa_mem),
                    .rf_wd_sel_out(rf_wd_sel_mem),
                    .rf_we_out(rf_we_mem),
                    .imm_type_out(),
                    .imm_out(imm_mem),
                    .alu_src1_sel_out(alu_src1_sel_mem),
                    .alu_src2_sel_out(alu_src2_sel_mem),
                    .alu_src1_out(alu_src1_mem),
                    .alu_src2_out(alu_src2_mem),
                    .alu_func_out(alu_func_mem),
                    .alu_ans_out(alu_ans_mem),
                    .pc_add4_out(pc_add4_mem),
                    .pc_br_out(pc_br_mem),
                    .pc_jal_out(pc_jal_mem),
                    .pc_jalr_out(pc_jalr_mem),
                    .jal_out(jal_mem),
                    .jalr_out(jalr_mem),
                    .br_type_out(br_type_mem),
                    .br_out(br_mem),
                    .pc_sel_out(pc_sel_mem),
                    .pc_next_out(pc_next_mem),
                    .dm_addr_out(dm_addr_mem),
                    .dm_din_out(dm_din_mem),      
                    .dm_dout_out(),
                    .dm_we_out(dm_we_mem),

                    .hit_in(1'b0),
                    .hit_out());

    wire flush_wb, rf_re0_wb, rf_re1_wb, alu_src1_sel_wb, alu_src2_sel_wb, jal_wb, jalr_wb, br_wb, dm_we_wb;
    wire [31:0]pc_cur_wb, inst_wb, rf_rd0_raw_wb, rf_rd1_raw_wb, rf_rd0_wb, rf_rd1_wb, imm_wb, alu_src1_wb, alu_src2_wb, alu_ans_wb;
    wire [31:0]pc_add4_wb, pc_br_wb, pc_jal_wb, pc_jalr_wb, pc_next_wb, dm_addr_wb, dm_din_wb, dm_dout_wb;
    wire [4:0]rf_ra0_wb, rf_ra1_wb;
    wire [1:0]rf_wd_sel_wb,  pc_sel_wb;
    wire [3:0] alu_func_wb;   
    wire [31:0] dm_dout;
    wire [2:0]br_type_wb;
    assign dm_dout = mem_dout;

            SEG_REG seg_reg_mem_wb(     .pc_cur_in(pc_cur_mem),
                    .inst_in(inst_mem),
                    .rf_ra0_in(rf_ra0_mem),
                    .rf_ra1_in(rf_ra1_mem),
                    .rf_re0_in(rf_re0_mem),
                    .rf_re1_in(rf_re1_mem),
                    .rf_rd0_raw_in(rf_rd0_raw_mem),
                    .rf_rd1_raw_in(rf_rd1_raw_mem),
                    .rf_rd0_in(rf_rd0_mem),
                    .rf_rd1_in(rf_rd1_mem),
                    .rf_wa_in(rf_wa_mem),
                    .rf_wd_sel_in(rf_wd_sel_mem),
                    .rf_we_in(rf_we_mem),
                    .imm_type_in(3'b0),
                    .imm_in(imm_mem),
                    .alu_src1_sel_in(alu_src1_sel_mem),
                    .alu_src2_sel_in(alu_src2_sel_mem),
                    .alu_src1_in(alu_src1_mem),
                    .alu_src2_in(alu_src2_mem),
                    .alu_func_in(alu_func_mem),
                    .alu_ans_in(alu_ans_mem),
                    .pc_add4_in(pc_add4_mem),
                    .pc_br_in(pc_br_mem),
                    .pc_jal_in(pc_jal_mem),
                    .pc_jalr_in(pc_jalr_mem),
                    .jal_in(jal_mem),
                    .jalr_in(jalr_mem),
                    .br_type_in(br_type_mem),
                    .br_in(br_mem),
                    .pc_sel_in(pc_sel_mem),
                    .pc_next_in(pc_next_mem),
                    .dm_addr_in(dm_addr_mem),
                    .dm_din_in(dm_din_mem),      //??
                    .dm_dout_in(dm_dout),
                    .dm_we_in(dm_we_mem),

                    .clk(clk),
                    .flush(1'h0),
                    .stall(1'h0),
                    
                    .pc_cur_out(pc_cur_wb),
                    .inst_out(inst_wb), 
                    .rf_ra0_out(rf_ra0_wb),
                    .rf_ra1_out(rf_ra1_wb),
                    .rf_re0_out(rf_re0_wb),
                    .rf_re1_out(rf_re1_wb),
                    .rf_rd0_raw_out(rf_rd0_raw_wb),
                    .rf_rd1_raw_out(rf_rd1_raw_wb),
                    .rf_rd0_out(rf_rd0_wb),
                    .rf_rd1_out(rf_rd1_wb),
                    .rf_wa_out(rf_wa_wb),
                    .rf_wd_sel_out(rf_wd_sel_wb),
                    .rf_we_out(rf_we_wb),
                    .imm_type_out(),
                    .imm_out(imm_wb),
                    .alu_src1_sel_out(alu_src1_sel_wb),
                    .alu_src2_sel_out(alu_src2_sel_wb),
                    .alu_src1_out(alu_src1_wb),
                    .alu_src2_out(alu_src2_wb),
                    .alu_func_out(alu_func_wb),
                    .alu_ans_out(alu_ans_wb),
                    .pc_add4_out(pc_add4_wb),
                    .pc_br_out(pc_br_wb),
                    .pc_jal_out(pc_jal_wb),
                    .pc_jalr_out(pc_jalr_wb),
                    .jal_out(jal_wb),
                    .jalr_out(jalr_wb),
                    .br_type_out(br_type_wb),
                    .br_out(br_wb),
                    .pc_sel_out(pc_sel_wb),
                    .pc_next_out(pc_next_wb),
                    .dm_addr_out(dm_addr_wb),
                    .dm_din_out(dm_din_wb),      
                    .dm_dout_out(dm_dout_wb),
                    .dm_we_out(dm_we_wb),

                    .hit_in(1'b0),
                    .hit_out());

    assign mem_inst = inst_mem;      

    MUX4 reg_write_sel(.src0(alu_ans_wb), .src1(pc_add4_wb), .src2(dm_dout_wb), .src3(imm_wb), .sel(rf_wd_sel_wb), .res(rf_wd_wb)); 
    wire inIfBranch;
    //wire stall_id_pre, stall_if_pre;
    Hazard hazard(.rf_ra0_ex(rf_ra0_ex), .rf_ra1_ex(rf_ra1_ex), .rf_re0_ex(rf_re0_ex), .rf_re1_ex(rf_re1_ex), .rf_wa_mem(rf_wa_mem), .rf_we_mem(rf_we_mem), 
                  .rf_wd_sel_mem(rf_wd_sel_mem), .alu_ans_mem(alu_ans_mem), .pc_add4_mem(pc_add4_mem), .imm_mem(imm_mem), .rf_wa_wb(rf_wa_wb), 
                  .rf_we_wb(rf_we_wb), .rf_wd_wb(rf_wd_wb), .pc_sel_ex(pc_sel_ex), .rf_rd0_fe(rf_rd0_fe), .rf_rd1_fe(rf_rd1_fe), .rf_rd0_fd(rf_rd0_fd), 
                  .rf_rd1_fd(rf_rd1_fd), .stall_if(stall_if), .stall_id(stall_id), .stall_ex(stall_ex), .flush_if(flush_if), .flush_id(flush_id), 
                  .flush_ex(flush_ex), .flush_mem(flush_mem), .ebreak(ebreak), .hit_ex(hit_ex), .inIfBranch(inIfBranch));

    //ebreak
    //assign stall_id = (ebreak == 1) ? 1 : stall_id_pre;     
    //assign stall_if = (ebreak == 1) ? 1 : stall_if_pre;           

    MUX4 npc_sel(.src0(pc_add4_if), .src1(pc_jalr_ex), .src2(alu_ans_ex), .src3(alu_ans_ex), .sel(pc_sel_ex), .res(pc_next));

    assign inst_raw = im_dout;
 

    assign im_addr = pc_cur_if;
    assign mem_addr = alu_ans_mem;
    assign mem_din = dm_din_mem;     
    assign mem_we = dm_we_mem;
    assign current_pc = pc_cur_if;
    assign next_pc = pc_next;          

    wire [31:0]check_data_if, check_data_id, check_data_mem, check_data_ex, check_data_wb;

    Check_Data_SEL check_data_sel_if(
        .pc_cur(pc_cur_if),
        .instruction(inst_if),
        .rf_ra0(inst_if[19:15]),
        .rf_ra1(inst_if[24:20]),
        .rf_re0(1'h0),
        .rf_re1(1'h0),
        .rf_rd0_raw(32'h0),
        .rf_rd1_raw(32'h0),
        .rf_rd0(32'h0),
        .rf_rd1(32'h0),
        .rf_wa(inst_if[11:7]),
        .rf_wd_sel(2'h0),
        .rf_wd(32'h0),
        .rf_we(1'h0),
        .immediate(32'h0),
        .alu_sr1(32'h0),
        .alu_sr2(32'h0),
        .alu_func(4'h0),
        .alu_ans(32'h0),
        .pc_add4(pc_add4_if),
        .pc_br(32'h0),
        .pc_jal(32'h0),
        .pc_jalr(32'h0),
        .pc_sel(2'h0),
        .pc_next(32'h0),
        .dm_addr(32'h0),
        .dm_din(32'h0),
        .dm_dout(32'h0),
        .dm_we(1'h0),   

        .check_addr(cpu_check_addr[4:0]),
        .check_data(check_data_if)
    ); 

    Check_Data_SEL check_data_sel_id(
        .pc_cur(pc_cur_id),
        .instruction(inst_id),
        .rf_ra0(rf_ra0_id),
        .rf_ra1(rf_ra1_id),
        .rf_re0(rf_re0_id),
        .rf_re1(rf_re1_id),
        .rf_rd0_raw(rf_rd0_raw_id),
        .rf_rd1_raw(rf_rd1_raw_id),
        .rf_rd0(32'h0),
        .rf_rd1(32'h0),
        .rf_wa(rf_wa_id),
        .rf_wd_sel(rf_wd_sel_id),
        .rf_wd(32'h0),
        .rf_we(rf_we_id),
        .immediate(imm_id),
        .alu_sr1(32'h0),
        .alu_sr2(32'h0),
        .alu_func(alu_func_id),
        .alu_ans(32'h0),
        .pc_add4(pc_add4_id),
        .pc_br(32'h0),
        .pc_jal(32'h0),
        .pc_jalr(32'h0),
        .pc_sel(2'h0),
        .pc_next(32'h0),
        .dm_addr(32'h0),
        .dm_din(rf_rd1_raw_id),
        .dm_dout(32'h0),
        .dm_we(mem_we_id),   

        .check_addr(cpu_check_addr[4:0]),
        .check_data(check_data_id)
    ); 

    
    Check_Data_SEL check_data_sel_ex(
        .pc_cur(pc_cur_ex),
        .instruction(inst_ex),
        .rf_ra0(rf_ra0_ex),
        .rf_ra1(rf_ra1_ex),
        .rf_re0(rf_re0_ex),
        .rf_re1(rf_re1_ex),
        .rf_rd0_raw(rf_rd0_raw_ex),
        .rf_rd1_raw(rf_rd1_raw_ex),
        .rf_rd0(rf_rd0_ex),
        .rf_rd1(rf_rd1_ex),
        .rf_wa(rf_wa_ex),
        .rf_wd_sel(rf_wd_sel_ex),
        .rf_wd(32'h0),
        .rf_we(rf_we_ex),
        .immediate(imm_ex),
        .alu_sr1(alu_src1_ex),
        .alu_sr2(alu_src2_ex),
        .alu_func(alu_func_ex),
        .alu_ans(alu_ans_ex),
        .pc_add4(pc_add4_ex),
        .pc_br(alu_ans_ex),
        .pc_jal(alu_ans_ex),
        .pc_jalr(pc_jalr_ex),
        .pc_sel(pc_sel_ex),
        .pc_next(pc_next),
        .dm_addr(alu_ans_ex),
        .dm_din(32'h0),//dm_din_ex
        .dm_dout(32'h0),
        .dm_we(dm_we_ex),   

        .check_addr(cpu_check_addr[4:0]),
        .check_data(check_data_ex)
    ); 


    Check_Data_SEL check_data_sel_mem(
        .pc_cur(pc_cur_mem),
        .instruction(inst_mem),
        .rf_ra0(rf_ra0_mem),
        .rf_ra1(rf_ra1_mem),
        .rf_re0(rf_re0_mem),
        .rf_re1(rf_re1_mem),
        .rf_rd0_raw(rf_rd0_raw_mem),
        .rf_rd1_raw(rf_rd1_raw_mem),
        .rf_rd0(rf_rd0_mem),
        .rf_rd1(rf_rd1_mem),
        .rf_wa(rf_wa_mem),
        .rf_wd_sel(rf_wd_sel_mem),
        .rf_wd(32'h0),
        .rf_we(rf_we_mem),
        .immediate(imm_mem),
        .alu_sr1(alu_src1_mem),
        .alu_sr2(alu_src2_mem),
        .alu_func(alu_func_mem),
        .alu_ans(alu_ans_mem),
        .pc_add4(pc_add4_mem),
        .pc_br(pc_br_mem),
        .pc_jal(pc_jal_mem),
        .pc_jalr(pc_jalr_mem),
        .pc_sel(pc_sel_mem),
        .pc_next(pc_next_mem),
        .dm_addr(dm_addr_mem),
        .dm_din(dm_din_mem),
        .dm_dout(dm_dout),
        .dm_we(dm_we_mem),   

        .check_addr(cpu_check_addr[4:0]),
        .check_data(check_data_mem)
    ); 

    Check_Data_SEL check_data_sel_wb(
        .pc_cur(pc_cur_wb),
        .instruction(inst_wb),
        .rf_ra0(rf_ra0_wb),
        .rf_ra1(rf_ra1_wb),
        .rf_re0(rf_re0_wb),
        .rf_re1(rf_re1_wb),
        .rf_rd0_raw(rf_rd0_raw_wb),
        .rf_rd1_raw(rf_rd1_raw_wb),
        .rf_rd0(rf_rd0_wb),
        .rf_rd1(rf_rd1_wb),
        .rf_wa(rf_wa_wb),
        .rf_wd_sel(rf_wd_sel_wb),
        .rf_wd(rf_wd_wb),
        .rf_we(rf_we_wb),
        .immediate(imm_wb),
        .alu_sr1(alu_src1_wb),
        .alu_sr2(alu_src2_wb),
        .alu_func(alu_func_wb),
        .alu_ans(alu_ans_wb),
        .pc_add4(pc_add4_wb),
        .pc_br(pc_br_wb),
        .pc_jal(pc_jal_wb),
        .pc_jalr(pc_jalr_wb),
        .pc_sel(pc_sel_wb),
        .pc_next(pc_next_wb),
        .dm_addr(dm_addr_wb),
        .dm_din(dm_din_wb),
        .dm_dout(dm_dout),
        .dm_we(dm_we_wb),   

        .check_addr(cpu_check_addr[4:0]),
        .check_data(check_data_wb)
    ); 
    wire [31:0] check_data_hzd;

        Check_Data_SEL_HZD check_data_sel_hzd (
        .rf_ra0_ex(rf_ra0_ex),
        .rf_ra1_ex(rf_ra1_ex),
        .rf_re0_ex(rf_re0_ex),
        .rf_re1_ex(rf_re1_ex),
        .pc_sel_ex(pc_sel_ex),
        .rf_wa_mem(rf_wa_mem),
        .rf_we_mem(rf_we_mem),
        .rf_wd_sel_mem(rf_wd_sel_mem),
        .alu_ans_mem(alu_ans_mem),
        .pc_add4_mem(pc_add4_mem),
        .imm_mem(imm_mem),
        .rf_wa_wb(rf_wa_wb),
        .rf_we_wb(rf_we_wb),
        .rf_wd_wb(rf_wd_wb),

        .rf_rd0_fe(rf_rd0_fe),
        .rf_rd1_fe(rf_rd1_fe),
        .rf_rd0_fd(rf_rd0_fd),
        .rf_rd1_fd(rf_rd1_fd),
        .stall_if(stall_if),
        .stall_id(stall_id),
        .stall_ex(stall_ex),
        .flush_if(flush_if),
        .flush_id(flush_id),
        .flush_ex(flush_ex),
        .flush_mem(flush_mem),

        .check_addr(cpu_check_addr[4:0]),
        .check_data(check_data_hzd)
        );

    wire [31:0] check_data;
    Check_Data_SEG_SEL check_data_seg_sel (
        .check_data_if(check_data_if),
        .check_data_id(check_data_id),
        .check_data_ex(check_data_ex),
        .check_data_mem(check_data_mem),
        .check_data_wb(check_data_wb),
        .check_data_hzd(check_data_hzd),

        .check_addr(cpu_check_addr[7:5]),
        .check_data(check_data)
    ); 

    //wire[31:0] cpucheckdata;
    MUX2 cpu_check_data_sel (
        .src0(check_data),
        .src1(rf_rd_dbg_id),
        .sel(cpu_check_addr[12]),

        .res(cpu_check_data)
    );    
    

    //ebreak pdu
   // wire ebreak_en;
    //reg btn_r1, btn_r2;
    assign ebreak_pdu = (inst_wb == 32'h00100073) ? 1 : 0;
    //always @(posedge clk) 
    //    btn_r1 <= ebreak_en;
    //always @(posedge clk) 
    //    btn_r2 <= btn_r1;
    //assign ebreak_pdu = btn_r1 & (~btn_r2);   
    wire br_pre_ex;
    wire[31:0] pc_jump;
    reg [31:0] pc_jump_id, pc_jump_ex;
    //wire inIfBranch;
    assign inIfBranch = (pc_jump_ex == alu_ans_ex) && (br_pre_ex | jal_ex); //???

    Cache Cache (
        .clk(clk),
        .address(pc_cur_if),
        .we_if(br_ex | jal_ex),// 
        .we_ex(br_pre_ex | jal_ex),  ///???? 
        .memAddr(pc_cur_ex),
        .memData(alu_ans_ex),
        .data(pc_jump),
        .real_hit(hit_if),
        .inIfBranch(br_pre_ex | jal_ex),//?????????????????????????????
        .rst(rst)
    ); 

    always @(posedge clk) begin
        pc_jump_id <= pc_jump;
        pc_jump_ex <= pc_jump_id;
    end

    wire forecast_fail, forecast_win;
    assign forecast_win = hit_ex & inIfBranch;
    wire [1:0] sel_two_bit;
    assign forecast_fail = hit_ex & (inIfBranch == 0);
    
    assign sel_two_bit = {forecast_fail, hit_if};

    MUX4 real_pc(.src0(pc_next), .src1(pc_jump), .src2(pc_cur_ex + 3'b100), .src3(32'b0), .sel(sel_two_bit), .res(real_pc_next));

    assign br_ex = br_pre_ex & (~forecast_win);
    Branch branch(.ra0(rf_rd0_ex), .ra1(rf_rd1_ex), .br_type(br_type_ex), .br(br_pre_ex), .forecast_win(forecast_win));


//    reg [3:0] GHR;      // global forecast
  //  initial GHR = 4'b0101;

    //always @(posedge clk) begin
     //   if(br_pre_ex)
            
    //end

//accuracy
 
    reg[7:0] count_win = 0;
    reg[7:0] count_total = 0;
    always @(posedge clk) begin
        if(forecast_win)
            count_win <= count_win + 1;
        else
            count_win <= count_win;    
    end

    always @(posedge clk) begin
        if(br_pre_ex | jal_ex)
            count_total <= count_total + 1;
        else
            count_total <= count_total;    
    end    
    
/*
    SEG_REG ??(     .pc_cur_in(),
                    .inst_in(),
                    .rf_ra0_in(),
                    .rf_ra1_in(),
                    .rf_re0_in(),
                    .rf_re1_in(),
                    .rf_rd0_raw_in(),
                    .rf_rd1_raw_in(),
                    .rf_rd0_in(),
                    .rf_rd1_in(),
                    .rf_wa_in(),
                    .rf_wd_sel_in(),
                    .rf_we_in(),
                    //.imm_type_in(),
                    .imm_in(),
                    .alu_src1_sel_in(),
                    .alu_src2_sel_in(),
                    .alu_src1_in(),
                    .alu_src2_in(),
                    .alu_func_in(),
                    .alu_ans_in(),
                    .pc_add4_in(),
                    .pc_br_in(),
                    .pc_jal_in(),
                    .pc_jalr_in(),
                    .jal_in(),
                    .jalr_in(),
                    .br_type_in(),
                    .br_in(),
                    .pc_sel_in(),
                    .pc_next_in(),
                    .dm_addr_in(),
                    .dm_din_in(),
                    .dm_dout_in(),
                    .dm_we_in(),

                    .clk(),
                    .flush(),
                    .stall(),
                    
                    .pc_cur_out(),
                    .inst_out(), 
                    .rf_ra0_out(),
                    .rf_ra1_out(),
                    .rf_re0_out(),
                    .rf_re1_out(),
                    .rf_rd0_raw_out(),
                    .rf_rd1_raw_out(),
                    .rf_rd0_out(),
                    .rf_rd1_out(),
                    .rf_wa_out(),
                    .rf_wd_sel_out(),
                    .rf_we_out(),
                    //.imm_type_out(),
                    .imm_out(),
                    .alu_src1_sel_out(),
                    .alu_src2_sel_out(),
                    .alu_src1_out(),
                    .alu_src2_out(),
                    .alu_func_out(),
                    .alu_ans_out(),
                    .pc_add4_out(),
                    .pc_br_out(),
                    .pc_jal_out(),
                    .pc_jalr_out(),
                    .jal_out(),
                    .jalr_out(),
                    .br_type_out(),
                    .br_out(),
                    .pc_sel_out(),
                    .pc_next_out(),
                    .dm_addr_out(),
                    .dm_din_out(),      
                    .dm_dout_out(),
                    .dm_we_out());
*/



endmodule


module PC(
    input [31:0]pc_next,
    input clk,
    input stall,
    input rst,
    output reg [31:0]pc_cur
);
    always @(posedge clk) begin
        if(rst)
            pc_cur <= 32'h00002ffc;
        else if(!stall)
            pc_cur <= pc_next;
        else
            ;    
    end
    
endmodule


module RF 
( 
    input clk, 
    input[4 : 0] ra0, 
    output[31 : 0] rd0, 
    input[4: 0] ra1, 
    input[4: 0] ra_dbg, 
    output[31 : 0] rd1, 
    output[31 : 0] rd_dbg,
    input[4 : 0] wa, 
    input we, 
    input[31 : 0] wd 
);

    reg [31 : 0] regfile[0 : 31];

    integer i;
    initial begin
        i = 0;
        while (i < 32) begin
        regfile[i] = 32'b0;
        i = i + 1;
        end
        regfile [2] = 32'h2ffc;
        regfile [3] = 32'h1800;
        //we = 0;
    end


    assign rd0 = (we && wa == ra0) ? wd : regfile[ra0]; 
    assign rd1 = (we && wa == ra1) ? wd : regfile[ra1];
    assign rd_dbg = (we && wa == ra_dbg) ? wd : regfile[ra_dbg];

    //initial begin regfile[0] = 0; regfile [2] = 32'h2ffc;   regfile [3] = 32'h1800;end
    
    always @ (posedge clk) begin
        if (we && wa != 0) regfile[wa] <= wd;
    end
endmodule



module CTRL(
    input [31:0]inst,
    output jal, //
    output jalr,//
    output reg [2:0] br_type,//
    output rf_we,
    output reg [1:0] rf_wd_sel,
    output reg alu_src1_sel,//
    output reg alu_src2_sel,//
    output reg [3:0] alu_ctrl,//
    output mem_we,//
    output rf_re0,
    output rf_re1,
    output ebreak       //new
);
    //initial begin
        
    //end
    assign ebreak = (inst == 32'h00100073);

    assign jal = (inst[6:0] == 7'h6f);
    assign jalr = (inst[6:0] == 7'h67);
    assign rf_we = (inst[11:7] == 5'b0) ? 0 : ((inst[6:0] == 7'h13) | (inst[6:0] == 7'h33) | (inst[6:0] == 7'h37) | (inst[6:0] == 7'h17) 
                 | (inst[6:0] == 7'h6f) | (inst[6:0] == 7'h67) | (inst[6:0] == 7'h03));    //R type, I type, lui, auipc, jal, jalr, lw


    assign mem_we = (inst[6:0] == 7'h23);      //sw

    //R type I type jalr B type lw sw
    assign rf_re0 = (inst[19:15] == 5'b0) ? 0 : ((inst[6:0] == 7'h13) | (inst[6:0] == 7'h33) | (inst[6:0] == 7'h67) | (inst[6:0] == 7'h63) | (inst[6:0] == 7'h03) | (inst[6:0] == 7'h23));
    // R type B type sw
    assign rf_re1 = (inst[24:20] == 5'b0) ? 0 : ((inst[6:0] == 7'h33) | (inst[6:0] == 7'h63) | (inst[6:0] == 7'h23));


    always @(*) begin
        if(inst[6:0] == 7'h63) begin
            case(inst[14:12])
                3'b000:    br_type = 3'b001;        //beq
                3'b100:    br_type = 3'b010;        //blt
                3'b001:    br_type = 3'b011;        //bne
                3'b101:    br_type = 3'b100;        //bge
                3'b110:    br_type = 3'b101;        //bltu
                3'b111:    br_type = 3'b110;        //bgeu
                default:   br_type = 3'b000;
            endcase
        end
        else
            br_type = 0;

    end    

    always @(*) begin
        if((inst[6:0] == 7'h13) || (inst[6:0] == 7'h33)|| (inst[6:0] == 7'h17))        //R type, I type, auipc
            rf_wd_sel = 2'b00;            
        else if((inst[6:0] == 7'h67) || (inst[6:0] == 7'h6f))         //jalr, jalr
            rf_wd_sel = 2'b01; 
        else if((inst[6:0] == 7'h03))         //lw
            rf_wd_sel = 2'b10;
        else if((inst[6:0] == 7'h37) )      //lui
            rf_wd_sel = 2'b11;      
        else 
            rf_wd_sel = 2'b00; 

    end

    always @(*) begin
        /*if((inst[6:0] == 7'h13) || (inst[6:0] == 7'h33) || (inst[6:0] == 7'h03) || (inst[6:0] == 7'h23) || (inst[6:0] == 7'h67))        // add, addi, lw, sw , jalr,  rs1
            alu_src1_sel = 2'b00;
        else if((inst[6:0] == 7'h6f)  || (inst[6:0] == 7'h17) || (inst[6:0] == 7'h63))    //jal,  auipc, b-type  pc
            alu_src1_sel = 2'b01;            
        else if((inst[6:0] == 7'h37))       // lui
            alu_src1_sel = 2'b10;    
        else    
            alu_src1_sel = 2'b11;   */

        if((inst[6:0] == 7'h6f)  || (inst[6:0] == 7'h17) || (inst[6:0] == 7'h63))    //jal,  auipc, b-type  pc
            alu_src1_sel = 1'b1;   
        else 
            alu_src1_sel = 1'b0;           
    end

    always @(*) begin
        if((inst[6:0] == 7'h33))        // R type      rs2
            alu_src2_sel = 1'b0;
        else if((inst[6:0] == 7'h13) || (inst[6:0] == 7'h03) || (inst[6:0] == 7'h23) || (inst[6:0] == 7'h67) 
            || (inst[6:0] == 7'h6f) || (inst[6:0] == 7'h37) || (inst[6:0] == 7'h17) || (inst[6:0] == 7'h63))    //I type, lw, sw, jal, jalr, lui, auipc, b-type    imm  
            alu_src2_sel = 1'b1;            
        else
            alu_src2_sel = 1'b0;    
    
    end

    always @(*) begin
        if(((inst[6:0] == 7'h13) && (inst[14:12] == 3'b000)) || ((inst[6:0] == 7'h33) && (inst[31:25] == 0) && (inst[14:12] == 3'b000)) || (inst[6:0] == 7'h03) || (inst[6:0] == 7'h23) 
        || (inst[6:0] == 7'h67) || (inst[6:0] == 7'h6f) || (inst[6:0] == 7'h37) || (inst[6:0] == 7'h17) || (inst[6:0] == 7'h63))    //all     +
            alu_ctrl = 4'b0000;
        else if((inst[6:0] == 7'h33) && (inst[14:12] == 3'b000) && (inst[31:25] == 7'h20)) //sub
            alu_ctrl = 4'b0001;
        else if((inst[6:0] == 7'h33) && (inst[14:12] == 3'b001)) //sll
            alu_ctrl = 4'b1001; 
        else if((inst[6:0] == 7'h33) && (inst[14:12] == 3'b111)) //and
            alu_ctrl = 4'b0101; 
        else if((inst[6:0] == 7'h13) && (inst[14:12] == 3'b111)) //andi
            alu_ctrl = 4'b0101;   
        else if((inst[6:0] == 7'h13) && (inst[14:12] == 3'b001)) //slli
            alu_ctrl = 4'b1001;     
        else if(((inst[6:0] == 7'h33) && (inst[14:12] == 3'b010)) || ((inst[6:0] == 7'h13) && (inst[14:12] == 3'b010))) //slt, slti
            alu_ctrl = 4'b0100;
        else if(((inst[6:0] == 7'h33) && (inst[14:12] == 3'b011)) || ((inst[6:0] == 7'h13) && (inst[14:12] == 3'b011))) //sltu, sltiu
            alu_ctrl = 4'b0011;    
        else if(((inst[6:0] == 7'h33) && (inst[14:12] == 3'b100)) || ((inst[6:0] == 7'h13) && (inst[14:12] == 3'b100))) //xor, xori
            alu_ctrl = 4'b0111;     
        else if(((inst[6:0] == 7'h33) && (inst[14:12] == 3'b101) && (inst[31:25] == 7'b0)) || ((inst[6:0] == 7'h13) && (inst[14:12] == 3'b101) && (inst[31:25] == 7'b0))) //srl, srli
            alu_ctrl = 4'b1000;
        else if(((inst[6:0] == 7'h33) && (inst[14:12] == 3'b101) && (inst[31:25] == 7'b0100000)) || ((inst[6:0] == 7'h13) && (inst[14:12] == 3'b101) && (inst[31:25] == 7'b0100000))) //sra, srai
            alu_ctrl = 4'b1010;
        else if(((inst[6:0] == 7'h33) && (inst[14:12] == 3'b110)) || ((inst[6:0] == 7'h13) && (inst[14:12] == 3'b110))) //or, ori
            alu_ctrl = 4'b0110;
        else
            alu_ctrl = 4'b1111;             
end
endmodule


module Immediate
(   
    input [31:0]inst,
    output reg [31:0]imm
);
    wire [6:0]type;
    assign type = inst[6:0];

    always@(*) begin
        case(type)
            7'h13:  begin if(inst[14:12] == 3'b001 || inst[14:12] == 3'b101) imm = (inst[24] == 0) ? {27'b0, inst[24:20]} : {32'b0}; 
                          else imm = {{20{inst[31]}}, inst[31:20]};    end//slli, srli, srai  else I type,  andi addi
            7'h37:  imm = {inst[31:12], 12'b0}; //lui
            7'h17:  imm = {inst[31:12], 12'b0}; //auipc
            7'h6f:  imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};   //jal
            7'h67:  imm = {{20{inst[31]}}, inst[31:20]};    //jalr
            7'h63:  imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}; //B type    
            7'h03:  imm = {{20{inst[31]}}, inst[31:20]};    //lw
            7'h23:  imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};    //sw
            default: imm = 0;
        endcase
    end   
endmodule


module alu 
(
    input [31:0] a, b, 
    input [3:0] func, 
    output reg [31:0] y
);
    always @(*) begin
        case(func)
            4'b0000:    y = a + b;
            4'b0001:    y = a - b;
            4'b0010:    y = (a == b) ? 1'b1 : 1'b0;
            4'b0011:    y = (a < b) ? 1'b1 : 1'b0;      //sltu
            4'b0100:    y = ($signed(a) < $signed(b)) ? 1'b1 : 1'b0;    //slt
            4'b0101:    y = a & b;
            4'b0110:    y = a | b;      //or
            4'b0111:    y = a ^ b;      //xor
            4'b1000:    y = a >> b;     //srl
            4'b1001:    y = a << b;
            4'b1010:    y = $signed(a) >>> $signed(b);    //sra
            4'b1011:    y = $signed(a) <<< $signed(b);
            default:    y = 6'b0;
        endcase     
    end
endmodule



module Branch(
    input [31:0] ra0,
    input [31:0] ra1,
    input [2:0] br_type,
    output reg br,

    input forecast_win
);
        always @(*) begin
            //if(forecast_win == 0) begin
                case(br_type)
                    3'b001:  br = (ra0 == ra1) ? 1 : 0;     //beq
                    3'b010:  br = ($signed(ra0) < $signed(ra1)) ? 1 : 0;    //blt
                    3'b011:  br = (ra0 != ra1) ? 1 : 0;       //bne
                    3'b100:  br = ($signed(ra0) >= $signed(ra1)) ? 1 : 0;           //bge
                    3'b101:  br = (ra0 < ra1) ? 1 : 0;      //bltu
                    3'b110:  br = (ra0 >= ra1) ? 1 : 0;     //bgeu
                    default: br = 0;

                endcase    
            //end
            //else
            //    br = 0;
        end 
    


endmodule



module SEG_REG (
    input [31:0]pc_cur_in,
    input [31:0]inst_in,
    input [4:0]rf_ra0_in,
    input [4:0]rf_ra1_in,
    input rf_re0_in,
    input rf_re1_in,
    input [31:0]rf_rd0_raw_in,
    input [31:0]rf_rd1_raw_in,
    input [31:0]rf_rd0_in,
    input [31:0]rf_rd1_in,
    input [4:0]rf_wa_in,
    input [1:0]rf_wd_sel_in,
    input rf_we_in,
    input [2:0]imm_type_in,
    input [31:0]imm_in,
    input alu_src1_sel_in,
    input alu_src2_sel_in,
    input [31:0]alu_src1_in,
    input [31:0]alu_src2_in,
    input [3:0]alu_func_in,
    input [31:0]alu_ans_in,
    input [31:0]pc_add4_in,
    input [31:0]pc_br_in,
    input [31:0]pc_jal_in,
    input [31:0]pc_jalr_in,
    input jal_in,
    input jalr_in,
    input [2:0]br_type_in,
    input br_in,
    input [1:0]pc_sel_in,
    input [31:0]pc_next_in,
    input [31:0]dm_addr_in,
    input [31:0]dm_din_in,
    input [31:0]dm_dout_in,
    input dm_we_in,

    output reg [31:0]pc_cur_out,
    output reg [31:0]inst_out,
    output reg [4:0]rf_ra0_out,
    output reg [4:0]rf_ra1_out,
    output reg rf_re0_out,
    output reg rf_re1_out,
    output reg [31:0]rf_rd0_raw_out,
    output reg [31:0]rf_rd1_raw_out,
    output reg [31:0]rf_rd0_out,
    output reg [31:0]rf_rd1_out,
    output reg [4:0]rf_wa_out,
    output reg [1:0]rf_wd_sel_out,
    output reg rf_we_out,
    output reg [2:0]imm_type_out,
    output reg [31:0]imm_out,
    output reg alu_src1_sel_out,
    output reg alu_src2_sel_out,
    output reg [31:0]alu_src1_out,
    output reg [31:0]alu_src2_out,
    output reg [3:0]alu_func_out,
    output reg [31:0]alu_ans_out,
    output reg [31:0]pc_add4_out,
    output reg [31:0]pc_br_out,
    output reg [31:0]pc_jal_out,
    output reg [31:0]pc_jalr_out,
    output reg jal_out,
    output reg jalr_out,
    output reg [2:0]br_type_out,
    output reg br_out,
    output reg [1:0]pc_sel_out,
    output reg [31:0]pc_next_out,
    output reg [31:0]dm_addr_out,
    output reg [31:0]dm_din_out,
    output reg [31:0]dm_dout_out,
    output reg dm_we_out,

    input clk,
    input flush,
    input stall,

    input hit_in,
    output reg hit_out
);
    initial begin
       rf_we_out = 0;
       inst_out = 32'h00000033;
       hit_out = 0;
    end

    always @(posedge clk) begin
        if(flush) begin
            pc_cur_out <= 0;
            inst_out <= 0;
            rf_ra0_out <= 0;
            rf_ra1_out <= 0;
            rf_re0_out <= 0;
            rf_re1_out <= 0;
            rf_rd0_raw_out <= 0;
            rf_rd1_raw_out <= 0;
            rf_rd0_out <= 0;
            rf_rd1_out <= 0;
            rf_wa_out <= 0;
            rf_wd_sel_out <= 0;
            rf_we_out <= 0;
            imm_type_out <= 0;
            imm_out <= 0;
            alu_src1_sel_out <= 0;
            alu_src2_sel_out <= 0;
            alu_src1_out <= 0;
            alu_src2_out <= 0;
            alu_func_out <= 0;
            alu_ans_out <= 0;
            pc_add4_out <= 0;
            pc_br_out <= 0;
            pc_jal_out <= 0;
            pc_jalr_out <= 0;
            jal_out <= 0;
            jalr_out <= 0;
            br_type_out <= 0;
            br_out <= 0;
            pc_sel_out <= 0;
            pc_next_out <= 0;
            dm_addr_out <= 0;
            dm_din_out <= 0;
            dm_dout_out <= 0;
            dm_we_out <= 0;
            hit_out <= 0;
        end
        else if(!stall) begin
            pc_cur_out <= pc_cur_in;
            inst_out <= inst_in;
            rf_ra0_out <= rf_ra0_in;
            rf_ra1_out <= rf_ra1_in;
            rf_re0_out <= rf_re0_in;
            rf_re1_out <= rf_re1_in;
            rf_rd0_raw_out <= rf_rd0_raw_in;
            rf_rd1_raw_out <= rf_rd1_raw_in;
            rf_rd0_out <= rf_rd0_in;
            rf_rd1_out <= rf_rd1_in;
            rf_wa_out <= rf_wa_in;
            rf_wd_sel_out <= rf_wd_sel_in;
            rf_we_out <= rf_we_in;
            imm_type_out <= imm_type_in;
            imm_out <= imm_in;
            alu_src1_sel_out <= alu_src1_sel_in;
            alu_src2_sel_out <= alu_src2_sel_in;
            alu_src1_out <= alu_src1_in;
            alu_src2_out <= alu_src2_in;
            alu_func_out <= alu_func_in;
            alu_ans_out <= alu_ans_in;
            pc_add4_out <= pc_add4_in;
            pc_br_out <= pc_br_in;
            pc_jal_out <= pc_jal_in;
            pc_jalr_out <= pc_jalr_in;
            jal_out <= jal_in;
            jalr_out <= jalr_in;
            br_type_out <= br_type_in;
            br_out <= br_in;
            pc_sel_out <= pc_sel_in;
            pc_next_out <= pc_next_in;
            dm_addr_out <= dm_addr_in;
            dm_din_out <= dm_din_in;
            dm_dout_out <= dm_dout_in;
            dm_we_out <= dm_we_in;
            hit_out <= hit_in;
        end
        else
            ;
    end
    
endmodule

module Hazard (
    input [4:0]rf_ra0_ex,//
    input [4:0]rf_ra1_ex,//
    input rf_re0_ex,//
    input rf_re1_ex,//
    input [4:0] rf_wa_mem,//
    input rf_we_mem,//
    input [1:0] rf_wd_sel_mem,//
    input [31:0] alu_ans_mem,//
    input [31:0] pc_add4_mem,//
    input [31:0] imm_mem,//
    input [4:0] rf_wa_wb,//
    input rf_we_wb,//
    input [31:0]rf_wd_wb,//
    input [1:0]pc_sel_ex,//
    input ebreak,

    output reg rf_rd0_fe,
    output reg rf_rd1_fe,
    output reg [31:0] rf_rd0_fd,
    output reg [31:0] rf_rd1_fd,
    output reg stall_if,
    output reg stall_id,
    output reg stall_ex,
    output reg flush_if,
    output reg flush_id,
    output reg flush_ex,
    output reg flush_mem,

    input hit_ex,
    input inIfBranch
);
    initial begin
        stall_if = 0;
        stall_id = 0;
        stall_ex = 0;
        flush_if = 0;
        flush_id = 0;
        flush_ex = 0;
        flush_mem = 0;
    end

    reg [31:0] wb_hazard;

    always @(*) begin
        case(rf_wd_sel_mem)
            2'b00:  wb_hazard = alu_ans_mem;
            2'b01:  wb_hazard = pc_add4_mem;
            2'b11:  wb_hazard = imm_mem;
            default:wb_hazard = 0;
        endcase
        
    end


    always @(*) begin
        if(rf_we_mem == 1 && (rf_re0_ex == 1 && (rf_ra0_ex == rf_wa_mem)) && rf_wd_sel_mem != 2'b10) begin
            rf_rd0_fe = 1;
            rf_rd0_fd = wb_hazard;        //??
        end
        else if(rf_we_wb == 1 && (rf_re0_ex == 1 && (rf_ra0_ex == rf_wa_wb))) begin
            rf_rd0_fe = 1;
            rf_rd0_fd = rf_wd_wb;
        end
        else begin
            rf_rd0_fe = 0;
            rf_rd0_fd = 0;
        end
    end

    always @(*) begin
        if(rf_we_mem == 1 && (rf_re1_ex == 1 && (rf_ra1_ex == rf_wa_mem)) && rf_wd_sel_mem != 2'b10) begin
            rf_rd1_fe = 1;
            rf_rd1_fd = wb_hazard;       
        end
        else if(rf_we_wb == 1 && (rf_re1_ex == 1 && (rf_ra1_ex == rf_wa_wb))) begin
            rf_rd1_fe = 1;
            rf_rd1_fd = rf_wd_wb;
        end
        else begin
            rf_rd1_fe = 0;
            rf_rd1_fd = 0;
        end
    end


    //load use hazard
    always @(*) begin
        if((rf_we_mem == 1 && (rf_re0_ex == 1 && (rf_ra0_ex == rf_wa_mem)) && rf_wd_sel_mem == 2'b10) 
        || (rf_we_mem == 1 && (rf_re1_ex == 1 && (rf_ra1_ex == rf_wa_mem)) && rf_wd_sel_mem == 2'b10)) begin
           flush_mem = 1;
           stall_ex = 1;
           stall_id = 1;
           stall_if = 1;
        end
        else begin
           flush_mem = 0;
           stall_ex = 0;
           stall_id = 0;
           stall_if = 0;
        end
    end


    //control hazard
    always @(*) begin
        if(hit_ex == 1 && inIfBranch != 1) begin    //forecast fail
            flush_id = 1;
            flush_ex = 1;
            flush_if = 1;
        end
        else if(pc_sel_ex != 2'b0 && (inIfBranch & hit_ex) == 0) begin
            flush_id = 1;
            flush_ex = 1;
            flush_if = 1;       //??
        end
        else begin
            flush_id = 0;
            flush_ex = 0;
            flush_if = 0;
        end
    end

    
endmodule


module MUX2(
    input [31:0] src0,
    input [31:0] src1,
    input sel,
    output reg [31:0] res
);

    //assign res = (sel == 0) ? src0 : src1;
    always @(*) begin
        if(sel == 0)
            res = src0;
        else
            res = src1;    
    
    end

endmodule

module MUX4(
    input [31:0] src0,
    input [31:0] src1,
    input [31:0] src2,
    input [31:0] src3,    
    input [1:0] sel,
    output reg [31:0] res
);

    always @(*) begin
        case(sel)
            2'b00:  res = src0;
            2'b01:  res = src1;
            2'b10:  res = src2;
            default:  res = src3;


        endcase
    end    

endmodule


module Encoder (
    input jal,
    input jalr,
    input br,
    output reg [1:0] pc_sel
);
    initial pc_sel = 2'b00;

    always @(*) begin
        if(jalr)
            pc_sel = 2'b01;
        else if(jal || br)    
            pc_sel = 2'b10;
        else
            pc_sel = 2'b00;    
    end
    
endmodule


module Cache (
    input clk,
    input [31:0] address,//mem address from cpu

    input we_if,              //锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�776锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�772锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777
    input [31:0] memAddr,//锟秸�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�774锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�778锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�777
    input [31:0] memData,//data to updata cache
    input we_ex,    //we_if 锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777ex

    output [31:0] data,
    output real_hit,         //锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�772锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�778锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�772锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777

    input inIfBranch,
    input rst
);
//锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777FIFO锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7778锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�77771锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�7761锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777777777

    reg [15:0] valid = 0;
    reg [29:0] tag[15:0];//锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777[31:2]锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�772锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777tag
    reg [31:0] cacheData[15:0];//锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�778锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�771锟�1锟�71锟�1锟�777锟�1锟�71锟�1锟�770锟�1锟�71锟�1锟�777

    //reg [1:0] counter[15:0]; //2 bit counter
    reg [7:0] counter[15:0]; //2 bit counter * 4
    reg [1:0] BHR[15:0]; // 2 bit insturction branch history     BHT
    reg [31:0] GHR_counter[15:0];     // 2 bit counter * 16 

    wire hit;
    integer i;
    initial begin
       
        for(i=0; i<16; i=i+1)
        begin
            counter[i] = 8'b01010101;
            cacheData[i] = 32'b0;
            valid[i] = 1'b0;
            tag[i] = 30'b0;
            BHR[i] = 2'b00;
            GHR_counter[i] = 31'h55555555;  // waekly not jump
        end
    end


    reg [15:0] eq,eqW;
    reg[3:0] cnt = 15;

    wire w;
    assign w=we_if & ~(|(eqW & valid));        //when valid and the address is already there, do not write
    always @(posedge clk) begin
        if(w)
            if(cnt == 15) 
                cnt = 0;
            else 
                cnt = cnt + 1;
        else
            ;        
    end
    always @(posedge clk) begin
        if(w) 
        begin
            valid[cnt] <= 1;
            tag[cnt] <= memAddr[31:2];
            cacheData[cnt] <= +++;
        end
    end

    /*
    reg[7:0] eq,eqW;
    integer i;end*/
    always @(*) begin
        for(i=0; i<16; i=i+1)
        begin
            eq[i]=(address[31:2]==tag[i]);
            eqW[i]=(memAddr[31:2]==tag[i]);
        end
    end

    wire [15:0] hitn;
    assign hitn = eq & valid;

    wire [3:0] sel;
    reg [3:0] sel_ex, sel_id;
    E16_4encoder E16_4encoder(.a(hitn), .b(sel));

    always @(posedge clk) begin
        sel_ex <= sel_id;
        sel_id <= sel;
    end

    reg [15:0] hitn_id, hitn_ex;

    always @(posedge clk) begin
        hitn_ex <= hitn_id;
        hitn_id <= hitn;
    end

    always @(posedge clk) begin
        if(|hitn_ex) begin   // hit, but don't know branch or not
            if(inIfBranch)
                BHR[sel_ex] <= (BHR[sel_ex] << 1) + 1;
            else
                BHR[sel_ex] <= (BHR[sel_ex] << 1);    
        end
        else
            ;
    end
    wire [7:0] counter_one_dimension;
    assign counter_one_dimension = counter[sel_ex];

    always @(posedge clk) begin //PHT
        case(BHR[sel_ex])
            2'b00: begin
                if(inIfBranch) begin
                    if(counter_one_dimension[1:0] == 2'b11) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] + 1'b1;
                end       
                else begin
                    if(counter_one_dimension[1:0] == 2'b00) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] - 1'b1;
                end                
            end
            2'b01:begin
                if(inIfBranch) begin
                    if(counter_one_dimension[3:2] == 2'b11) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] + 3'b100;
                end       
                else begin
                    if(counter_one_dimension[3:2] == 2'b00) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] - 3'b100;
                end                
            end

            2'b10:begin
                if(inIfBranch) begin
                    if(counter_one_dimension[5:4] == 2'b11) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] + 5'b10000;
                end       
                else begin
                    if(counter_one_dimension[5:4] == 2'b00) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] - 5'b10000;
                end                
            end
                
            2'b11:begin
                if(inIfBranch) begin
                    if(counter_one_dimension[7:6] == 2'b11) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] + 7'b1000000;
                end       
                else begin
                    if(counter_one_dimension[7:6] == 2'b00) 
                        counter[sel_ex] <= counter[sel_ex];
                    else 
                        counter[sel_ex] <= counter[sel_ex] - 7'b1000000;
                end                
            end
            default:
                ;

        endcase
    end


    //GHR

    reg [3:0] GHR;
    initial GHR = 4'b0101;

    always @(posedge clk) begin
        if(|hitn_ex) begin
            if(inIfBranch)  //jump
                GHR <= {GHR[2:0], 1'b1};
            else
                GHR <= {GHR[2:0], 1'b0};    

        end
        else
            ;
    end

    //GHR_PHT
    //reg [31:0] GHR_counter[7:0];     // 2 bit counter * 16 

    wire [31:0] GHR_counter_one_dimension;
    assign GHR_counter_one_dimension = GHR_counter[sel_ex];


    always @(posedge clk) begin //PHT
        case(GHR)
            4'b0000: begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[1:0] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 1'b1;
                end       
                else begin
                    if(GHR_counter_one_dimension[1:0] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 1'b1;
                end                
            end
            4'b0001:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[3:2] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 3'b100;
                end       
                else begin
                    if(GHR_counter_one_dimension[3:2] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 3'b100;
                end                
            end

            4'b0010:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[5:4] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 5'b10000;
                end       
                else begin
                    if(GHR_counter_one_dimension[5:4] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 5'b10000;
                end                
            end
                
            4'b0011:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[7:6] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 7'b1000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[7:6] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 7'b1000000;
                end                
            end

            4'b0100:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[9:8] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 9'b100000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[9:8] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 9'b100000000;
                end                
            end

            4'b0101:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[11:10] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 11'b10000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[11:10] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 11'b10000000000;
                end                
            end

            4'b0110:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[13:12] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 13'b1000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[13:12] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 13'b1000000000000;
                end                
            end

            4'b0111:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[15:14] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 15'b100000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[15:14] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 15'b100000000000000;
                end                
            end

            4'b1000:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[17:16] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 17'b10000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[17:16] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 17'b10000000000000000;
                end                
            end

            4'b1001:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[19:18] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 19'b1000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[19:18] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 19'b1000000000000000000;
                end                
            end

            4'b1010:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[21:20] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 21'b100000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[21:20] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 21'b100000000000000000000;
                end                
            end

            4'b1011:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[23:22] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 23'b10000000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[23:22] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 23'b10000000000000000000000;
                end                
            end

            4'b1100:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[25:24] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 25'b1000000000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[25:24] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 25'b1000000000000000000000000;
                end                
            end

            4'b1101:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[27:26] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 27'b100000000000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[27:26] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 27'b100000000000000000000000000;
                end                
            end

            4'b1110:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[29:28] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 29'b10000000000000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[29:28] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 29'b10000000000000000000000000000;
                end                
            end

            4'b1111:begin
                if(inIfBranch) begin
                    if(GHR_counter_one_dimension[31:30] == 2'b11) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] + 31'b1000000000000000000000000000000;
                end       
                else begin
                    if(GHR_counter_one_dimension[31:30] == 2'b00) 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex];
                    else 
                        GHR_counter[sel_ex] <= GHR_counter[sel_ex] - 31'b1000000000000000000000000000000;
                end                
            end
            default:
                ;

        endcase
    end

    //BHR
    wire taken;
    //assign taken = (counter[sel] == 2'b10) | (counter[sel] == 2'b11);
    wire [7:0]counter_sel;
    assign counter_sel = counter[sel];
    assign taken = ((BHR[sel] == 2'b00) & counter_sel[1]) | ((BHR[sel] == 2'b01) & counter_sel[3]) 
                 | ((BHR[sel] == 2'b10) & counter_sel[5]) | ((BHR[sel] == 2'b11) & counter_sel[7]);
    assign hit = (|hitn) & taken;    
    assign data = cacheData[sel];


    //    GHR

    wire GHR_taken;
    wire [31:0] GHR_counter_sel;
    assign GHR_counter_sel = GHR_counter[sel];
    assign GHR_taken = ((GHR == 4'b0000) & GHR_counter_sel[1]) | ((GHR == 4'b0001) & GHR_counter_sel[3]) | ((GHR == 4'b0010) & GHR_counter_sel[5]) 
                     | ((GHR == 4'b0011) & GHR_counter_sel[7]) | ((GHR == 4'b0100) & GHR_counter_sel[9]) | ((GHR == 4'b0101) & GHR_counter_sel[11])
                     | ((GHR == 4'b0110) & GHR_counter_sel[13]) | ((GHR == 4'b0111) & GHR_counter_sel[15]) | ((GHR == 4'b1000) & GHR_counter_sel[17]) 
                     | ((GHR == 4'b1001) & GHR_counter_sel[19]) | ((GHR == 4'b1010) & GHR_counter_sel[21]) | ((GHR == 4'b1011) & GHR_counter_sel[23])
                     | ((GHR == 4'b1100) & GHR_counter_sel[25]) | ((GHR == 4'b1101) & GHR_counter_sel[27]) | ((GHR == 4'b1110) & GHR_counter_sel[29])
                     | ((GHR == 4'b1111) & GHR_counter_sel[31]);
    wire GHR_hit;
    assign GHR_hit = (|hitn) & GHR_taken;      
    wire [31:0] GHR_data;
    assign GHR_data = cacheData[sel];
    reg GHR_hit_id, GHR_hit_ex;

    always @(posedge clk) begin
        GHR_hit_ex <= GHR_hit_id;
        GHR_hit_id <= GHR_hit;
    end

    // compete

    reg [1:0] global;
    initial global = 2'b01; //weakly local

    always @(posedge clk) begin
        if((|hitn_ex) & inIfBranch)
            global <= (global == 2'b00) ? global : global - 1;
        else if(GHR_hit_ex & inIfBranch)
            global <= (global == 2'b11) ? global : global + 1;
        else
            global <= global;         
    end

    assign real_hit = (global[1] == 0) ? hit : GHR_hit;

endmodule 

module E16_4encoder(
    input [15:0] a,
    output reg [3:0] b
);  //priority encoder

    always @(*) begin
        if(a[15] == 1)
            b = 4'hF;
        else if(a[14] == 1)
            b = 4'hE;
        else if(a[13] == 1)
            b = 4'hD;
        else if(a[12] == 1)
            b = 4'hC;
        else if(a[11] == 1)
            b = 4'hB;
        else if(a[10] == 1)
            b = 4'hA;
        else if(a[9] == 1)
            b = 4'h9;
        else if(a[8] == 1)
            b = 4'h8;
        else if(a[7] == 1)
            b = 4'h7;
        else if(a[6] == 1)
            b = 4'h6;
        else if(a[5] == 1)
            b = 4'h5;
        else if(a[4] == 1)
            b = 4'h4;
        else if(a[3] == 1)
            b = 4'h3;
        else if(a[2] == 1)
            b = 4'h2;
        else if(a[1] == 1)
            b = 4'h1;
        else if   (a[0] == 1)
            b = 4'h0;        
        else
            b = 4'b1111;    
    end
endmodule
