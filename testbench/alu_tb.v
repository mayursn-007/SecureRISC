
// SecureRISC
// ALU Testbench


`timescale 1ns/1ps

module alu_tb;

reg [31:0] A;
reg [31:0] B;
reg [3:0] ALU_Control;

wire [31:0] Result;
wire Zero;

alu uut (

.A(A),
.B(B),
.ALU_Control(ALU_Control),

.Result(Result),
.Zero(Zero)

);

initial begin


// ADD


A = 10;
B = 5;
ALU_Control = 4'b0000;

#10;


// SUB


A = 20;
B = 7;
ALU_Control = 4'b0001;

#10;

// AND


A = 12;
B = 10;
ALU_Control = 4'b0010;

#10;

// OR


A = 12;
B = 10;
ALU_Control = 4'b0011;

#10;


// XOR


A = 12;
B = 10;
ALU_Control = 4'b0100;

#10;


// SHIFT LEFT


A = 4;
B = 2;
ALU_Control = 4'b0101;

#10;


// SHIFT RIGHT


A = 32;
B = 2;
ALU_Control = 4'b0110;

#10;


// SET LESS THAN


A = 3;
B = 7;
ALU_Control = 4'b0111;

#10;

$finish;

end

endmodule
