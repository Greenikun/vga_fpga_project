//MAKE THIS TOP

`timescale 1ns / 1ps

module vga_top_tb;

    reg clk_100MHz_tb = 0;
    reg reset_tb = 1;

    wire hsync_tb;
    wire vsync_tb;
    wire [2:0] red_tb;
    wire [2:0] green_tb;
    wire [1:0] blue_tb;

    vga_top uut (
        .clk_100MHz(clk_100MHz_tb),
        .reset(reset_tb),
        .hsync(hsync_tb),
        .vsync(vsync_tb),
        .red(red_tb),
        .green(green_tb),
        .blue(blue_tb)
    );

    always #5 clk_100MHz_tb = ~clk_100MHz_tb;

    initial begin
        #100;
        reset_tb = 0;

        #100000000;
        $stop;
    end
    
    initial begin
    $dumpfile("vga_top_tb.vcd");
    $dumpvars(0, vga_top_tb);
    #2000000 $finish;
end


endmodule
