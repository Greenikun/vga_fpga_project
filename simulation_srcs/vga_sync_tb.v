`timescale 1ns / 1ns 

module vga_sync_tb;

    reg clk;            
    reg reset;          
    wire hsync;
    wire vsync;         
    wire video_on;    
    wire [9:0] h_count; 
    wire [9:0] v_count;

    vga_sync uut (
        .clk(clk),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .video_on(video_on),
        .h_count(h_count),
        .v_count(v_count)
    );

    always #20 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;         
        #100;             
        reset = 0;       
        #100000000;      
        $finish;    
    end

endmodule
