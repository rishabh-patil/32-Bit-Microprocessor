// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2024 22:58:57
// Design Name: 
// Module Name: test3_mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test3_mips32;
    reg clk1, clk2;
    integer k;
pipe_MIPS32 mips(clk1, clk2);
    initial
    begin
        clk1=0; clk2=0;
         repeat(50) begin
    #5 clk1=1; #5 clk1=0;
    #5 clk2=1; #5 clk2=0;
    end
end
initial
begin
    for(k=0; k<31; k=k+1)
        mips.Reg[k]=k;
        
        mips.Mem[0]=32'h280a00c8;       //ADDI R10, R0, 200
        mips.Mem[1]=32'h28020001;       //ADDI R2, R0, 1
        mips.Mem[2]=32'h0e94a000;       //OR R20, R20, R20--Dummy inst
        mips.Mem[3]=32'h21430000;       //LW R3, 0(R10)
        mips.Mem[4]=32'h0e94a000;       //OR R20, R20, R20--Dummy inst
        mips.Mem[5]=32'h14431000;       //LOOP: MUL R2, R2, R3
        mips.Mem[6]=32'h2c630001;       //SUBI R3, R3, 1
        mips.Mem[7]=32'h0e94a000;       
        mips.Mem[8]=32'h3460fffc;       //BNEQZ R3,Loop(ie -4 offset because PC is at mem9)
        mips.Mem[9]=32'h2542fffe;       //SW R2, -2(R10)
        mips.Mem[10]=32'hfc000000;      //HLT
        
        mips.Mem[200]=7;  //Facrorial of 7
        
        mips.PC=0;
        mips.HALTED=0;
        mips.TAKEN_BRANCH=0;
        
        
        end
initial 
begin
    $dumpfile("mips.vcd");
    $dumpvars(0, test3_mips32);
    $monitor("R2: %4d", mips.Reg[2]);
    $display("Mem[198] = %2d", mips.Mem[198]);

    #3000 $finish;
    end
endmodule