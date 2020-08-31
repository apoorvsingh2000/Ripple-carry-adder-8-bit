module fulladder(a,b,cin,sum,carry);
input a,b,cin;
output reg sum, carry;
always@(a, b, cin)
begin
sum=a^b^cin;
carry= (a&b)|(cin&(a^b));
end
endmodule

module RCA4(a,b,c,s, cout);
input [3:0] a,b;
input c;
output  [3:0] s;
output  cout;
wire c1,c2,c3;
begin
fulladder fa0(a[0], b[0],c, s[0],c1);
fulladder fa1(a[1], b[1],c1, s[1],c2);
fulladder fa2(a[2], b[2],c2, s[2],c3);
fulladder fa3(a[3], b[3],c3, s[3],cout);
end
endmodule

module RCA8(a,b,c,s,cout);
input [7:0] a,b;
input c;
output [7:0] s;
output cout;
wire c1;
begin 
RCA4 adder1(a[3:0],b[3:0],c,s[3:0],c1);
RCA4 adder2(a[7:4],b[7:4],c1,s[7:4],cout);
end
endmodule

module RCA8_test;
reg [7:0] a,b;
reg c;
wire [7:0] s;
wire c1,cout;
RCA8 uut(a,b,c,s,cout);
initial
begin
a=8'b10101010;
b=8'b01010101;
c=1'b0;
#200;
a=8'b11001100;
b=8'b11110000;
c=1'b1;
#200;
end
initial
$monitor($time, "a=%b,b=%b,c=%b,s=%b,cout=%b", a,b,c,s,cout);
endmodule