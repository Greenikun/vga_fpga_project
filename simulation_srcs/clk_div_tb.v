`timescale 1ns / 1ps  // Time unit = 1ns, time precision = 1ps

module clk_div_tb;

    // Testbench signals to connect to the clk_div module
    reg clk_in;         // Clock input (100 MHz)
    reg reset;          // Reset signal
    wire clk_out;       // Output clock from divider

    // Instantiate the clk_div module
    clk_div uut (
        .clk_in(clk_in),    // Connect testbench clk_in to module input
        .reset(reset),      // Connect reset
        .clk_out(clk_out)   // Observe output clock
    );

    // Generate 100 MHz clock: toggle every 5ns (10ns period)
    always #5 clk_in = ~clk_in;

    initial begin
        // Initialize signals
        clk_in = 0;
        reset = 1;         // Start with reset active
        #20;               // Wait 20ns

        reset = 0;         // Deassert reset
        #200;              // Let simulation run to observe clk_out toggles

        $finish;           // End simulation
    end

endmodule
