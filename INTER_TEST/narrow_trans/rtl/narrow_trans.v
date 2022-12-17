module narrow_trans(
    input  clk,
    input rst_n,

    input [31 : 0] i_data,
    input [3 : 0] i_data_strobe,
    output reg [63 : 0] o_data,
    output reg o_vld
);
    //==============defination
    reg [3 : 0] cnt;
    //==============combinal logic
    
    //==============sequential logic
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n) o_data <= 'd0;
        else begin
            case(i_data_strobe)
                4'b0000 : o_data <= o_data;
                4'b0001 : o_data <= {o_data, i_data[7 : 0]};
                4'b0010 : o_data <= {o_data, i_data[15 : 8]};
                4'b0011 : o_data <= {o_data, i_data[15 : 0]};
                4'b0100 : o_data <= {o_data, i_data[23 : 16]};
                4'b0101 : o_data <= {o_data, i_data[23 : 16], i_data[7 : 0]};
                4'b0110 : o_data <= {o_data, i_data[23 : 8]};
                4'b0111 : o_data <= {o_data, i_data[23 : 0]};
                4'b1000 : o_data <= {o_data, i_data[31 : 24]};
                4'b1001 : o_data <= {o_data, i_data[31 : 24], i_data[7 : 0]};
                4'b1010 : o_data <= {o_data, i_data[31 : 24], i_data[15 : 8]};
                4'b1011 : o_data <= {o_data, i_data[31 : 24], i_data[15 : 0]};
                4'b1100 : o_data <= {o_data, i_data[31 : 16]};
                4'b1101 : o_data <= {o_data, i_data[31 : 16], i_data[7 : 0]};
                4'b1110 : o_data <= {o_data, i_data[31 : 8]};
                4'b1111 : o_data <= {o_data, i_data[31 : 0]};
            endcase
        end
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n) cnt <= 'd0;
        else begin
            if(cnt >= 8) begin
                case(i_data_strobe)
                    4'b0000 : cnt <= cnt - 'd8;
                    4'b0001 : cnt <= cnt - 'd8 + 'd1;
                    4'b0010 : cnt <= cnt - 'd8 + 'd1;
                    4'b0011 : cnt <= cnt - 'd8 + 'd2;
                    4'b0100 : cnt <= cnt - 'd8 + 'd1;
                    4'b0101 : cnt <= cnt - 'd8 + 'd2;
                    4'b0110 : cnt <= cnt - 'd8 + 'd2;
                    4'b0111 : cnt <= cnt - 'd8 + 'd3;
                    4'b1000 : cnt <= cnt - 'd8 + 'd1;
                    4'b1001 : cnt <= cnt - 'd8 + 'd2;
                    4'b1010 : cnt <= cnt - 'd8 + 'd2;
                    4'b1011 : cnt <= cnt - 'd8 + 'd3;
                    4'b1100 : cnt <= cnt - 'd8 + 'd2;
                    4'b1101 : cnt <= cnt - 'd8 + 'd3;
                    4'b1110 : cnt <= cnt - 'd8 + 'd3;
                    4'b1111 : cnt <= cnt - 'd8 + 'd4;
                endcase
            end
            else begin
                case(i_data_strobe)
                    4'b0000 : cnt <= cnt;
                    4'b0001 : cnt <= cnt + 'd1;
                    4'b0010 : cnt <= cnt + 'd1;
                    4'b0011 : cnt <= cnt + 'd2;
                    4'b0100 : cnt <= cnt + 'd1;
                    4'b0101 : cnt <= cnt + 'd2;
                    4'b0110 : cnt <= cnt + 'd2;
                    4'b0111 : cnt <= cnt + 'd3;
                    4'b1000 : cnt <= cnt + 'd1;
                    4'b1001 : cnt <= cnt + 'd2;
                    4'b1010 : cnt <= cnt + 'd2;
                    4'b1011 : cnt <= cnt + 'd3;
                    4'b1100 : cnt <= cnt + 'd2;
                    4'b1101 : cnt <= cnt + 'd3;
                    4'b1110 : cnt <= cnt + 'd3;
                    4'b1111 : cnt <= cnt + 'd4;
                endcase
            end
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n) o_vld <= 1'b0;
        else begin
            if(cnt >= 'd8) o_vld <= 1'b1;
            else o_vld <= 1'b0;
        end
    end
endmodule

