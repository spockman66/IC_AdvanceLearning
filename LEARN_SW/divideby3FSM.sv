module divideby3FSM(
    input logic clk,
    input logic reset,
    output logic y
);

typedef enum logic [1:0] { S0, S1, S2 } statetype;
statetype [1:0] state, next_state;

always_ff @(posedge clk, posedge reset)
    if(reset)   state <= S0;
    else state <= next_state;
end

always_comb begin
    case (state)
        S0: next_state <= S1;
        S1: next_state <= S2;
        S2: next_state <= S3;
        default: next_state <= S0;
    endcase
end

assign y = state==S0;

endmodule 