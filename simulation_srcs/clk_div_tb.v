module clk_div (
    input  wire clk_in,    
    input  wire reset,
    output reg  clk_out   
);
    reg [1:0] counter;
    
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 2'd3)
                clk_out <= ~clk_out;
        end
    end
endmodule
