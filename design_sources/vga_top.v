module vga_top (
    input  wire clk_100MHz,       
    input  wire reset,             
    output wire hsync,         
    output wire vsync,           
    output wire [2:0] red,       
    output wire [2:0] green,      
    output wire [1:0] blue       
);

    wire clk_25MHz;            
    wire video_on;             
    wire [9:0] h_count;     
    wire [9:0] v_count;  

    clk_div clk_div_inst (
        .clk_in(clk_100MHz),
        .reset(reset),
        .clk_out(clk_25MHz)
    );

    vga_sync vga_sync_inst (
        .clk(clk_25MHz),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .video_on(video_on),
        .h_count(h_count),
        .v_count(v_count)
    );

    vga_display vga_display_inst (
        .clk(clk_25MHz),
        .reset(reset),
        .video_on(video_on),
        .h_count(h_count),
        .v_count(v_count),
        .red(red),
        .green(green),
        .blue(blue)
    );
    

endmodule
