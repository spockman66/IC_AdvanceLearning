//************************************************
// Author       : Jack
// Creat Date   : 2022/12/26
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module sort3
(
    input   wire            clk     ,
    input   wire            rst_n   ,
    input   wire    [7:0]   data1   ,
    input   wire    [7:0]   data2   ,
    input   wire    [7:0]   data3   ,
    output  reg     [7:0]   max     ,
    output  reg     [7:0]   mid     ,
    output  reg     [7:0]   min     
);

// wire define


// reg define


//*******************************************
//*****************main code*****************
//*******************************************
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
        max <= 8'd0;
        mid <= 8'd0;
        min <= 8'd0;
        end
    else if(data1 > data2)
        if(data2 > data3)
            begin
            max <= data1;
            mid <= data2;
            min <= data3;
            end
        else if(data1 > data3)
            begin
            max <= data1;
            mid <= data3;
            min <= data2;
            end
        else
            begin
            max <= data3;
            mid <= data1;
            min <= data2;
            end
    else if(data1 > data3)
        begin
        max <= data2;
        mid <= data1;
        min <= data3;
        end
    else if(data2 > data3)
        begin
        max <= data2;
        mid <= data3;
        min <= data1;
        end
    else
        begin
        max <= data3;
        mid <= data2;
        min <= data1;
        end
end

endmodule
