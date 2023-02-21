module mul_pipe
    #(
        parameter N=4,
        parameter M=4
    )
    (
        input                      clk       ,
        input                      rstn      ,

        input                      vld       ,
        input [M-1:0]              mult1     ,
        input [N-1:0]              mult2     ,

        output  [N+M-1:0]          res       ,
        output                     res_vld
    );





endmodule //mul_pipe




module adder_half(a,b,c,s);

    input a, b;
    output c, s;

    assign s = a ^ b;
    assign c = a & b;

endmodule

module adder_full(a, b, cin, cout, s);
    input a, b, cin;
    output cout, s;

    wire d, g, p, cp;

    adder_half u_ha1(a,d,g,p);
    adder_half u_ha2(cin,p,cp,s);

    assign cout = g | cp;

endmodule
