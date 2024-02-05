module MEM(
    input clk,

    // MEM Data BUS with CPU
	// IM port
    input [31:0] im_addr,
    output [31:0] im_dout,
	
	// DM port
    input  [31:0] dm_addr,
    input dm_we,
    input  [31:0] dm_din,
    output reg [31:0] dm_actual_dout,

    // MEM Debug BUS
    input [31:0] mem_check_addr,
    output [31:0] mem_check_data,

    // extend
    input [31:0]inst    //inst_mem
);

   // TODO: Your IP here.
   // Remember that we need [9:2]?
   wire [31:0] im_addr_rom;
    assign im_addr_rom = (im_addr - 32'h00003000);
    // TODO
    inst_memory inst_memory(.a(im_addr_rom[10:2]), .spo(im_dout));


    wire [2:0]func;
    assign func = inst[14:12];
    wire mem_read;
    assign mem_read = (inst[6:0] == 7'h03) ? 1 : 0;

    reg [31:0] dm_actual_din;
    wire [31:0] dm_dout;

    always @(*) begin       //store
        if(dm_we) begin
            case(func)
                3'b000:         //byte
                    case(dm_addr[1:0])
                        2'b00:  dm_actual_din = {dm_dout[31:8], dm_din[7:0]};   //�Ͱ�λ
                        2'b01:  dm_actual_din = {dm_dout[31:16], dm_din[7:0], dm_dout[7:0]};
                        2'b10:  dm_actual_din = {dm_dout[31:24], dm_din[7:0], dm_dout[15:0]};
                        default:dm_actual_din = {dm_din[7:0], dm_dout[23:0]};
                    endcase
                3'b001:         //half word
                    case(dm_addr[1])    
                        1'b0:   dm_actual_din = {dm_dout[31:16], dm_din[15:0]};   //��16λ
                        default:dm_actual_din = {dm_din[15:0], dm_dout[15:0]};
                    endcase    
                3'b010:     dm_actual_din = dm_din;         //sw
                default:    dm_actual_din = dm_dout;
            endcase
        end 
        else
            dm_actual_din = dm_dout;
    end

    always @(*) begin       //load
        if(mem_read) begin
            case(func)
                3'b000:     //byte
                    case(dm_addr[1:0])
                        2'b00:  dm_actual_dout = {{24{dm_dout[7]}}, dm_dout[7:0]};
                        2'b01:  dm_actual_dout = {{24{dm_dout[15]}}, dm_dout[15:8]}; 
                        2'b10:  dm_actual_dout = {{24{dm_dout[23]}}, dm_dout[23:16]}; 
                        default:dm_actual_dout = {{24{dm_dout[31]}}, dm_dout[31:24]}; 
                    endcase 
                3'b001:     //half word
                    case(dm_addr[1])
                        1'b0:   dm_actual_dout = {{16{dm_dout[15]}}, dm_dout[15:0]};   
                        default:dm_actual_dout = {{16{dm_dout[31]}}, dm_dout[31:16]};
                    endcase
                3'b010:     dm_actual_dout = dm_dout;
                3'b100:
                    case(dm_addr[1:0])
                        2'b00:  dm_actual_dout = {24'b0, dm_dout[7:0]};
                        2'b01:  dm_actual_dout = {24'b0, dm_dout[15:8]}; 
                        2'b10:  dm_actual_dout = {24'b0, dm_dout[23:16]}; 
                        default:dm_actual_dout = {24'b0, dm_dout[31:24]}; 
                    endcase   
                3'b101:
                    case(dm_addr[1])
                        1'b0:   dm_actual_dout = {16'b0, dm_dout[15:0]};   
                        default:dm_actual_dout = {16'b0, dm_dout[31:16]};
                    endcase       
                default:    dm_actual_dout = dm_dout;                                       
            endcase
        end
        else
            dm_actual_dout = dm_dout;      
    end


    //wire [31:0] dm_addr_ram;
    //assign dm_addr_ram = dm_addr/4;
    data_memory data_memory(.a(dm_addr[9:2]), .d(dm_actual_din), .dpra(mem_check_addr[7:0]), .spo(dm_dout), .dpo(mem_check_data), .we(dm_we), .clk(clk));
endmodule