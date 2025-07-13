module vga_sync (
    input  wire clk,           // 25 MHz pixel clock
    input  wire reset,
    output reg  hsync,         // Horizontal sync signal
    output reg  vsync,         // Vertical sync signal
    output reg  video_on,      // Active video area (1 inside 640x480)
    output reg [9:0] h_count,  // Horizontal pixel count (0 to 799)
    output reg [9:0] v_count   // Vertical line count (0 to 524)
);

    //VGA timing
    localparam H_VISIBLE   = 640;
    localparam H_FRONT     = 16;
    localparam H_SYNC      = 96;
    localparam H_BACK      = 48;
    localparam H_TOTAL     = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;

    localparam V_VISIBLE   = 480;
    localparam V_FRONT     = 10;
    localparam V_SYNC      = 2;
    localparam V_BACK      = 33;
    localparam V_TOTAL     = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;

    always @(posedge clk or posedge reset) begin
        if (reset)
            h_count <= 0;
        else if (h_count == H_TOTAL - 1)
            h_count <= 0;
        else
            h_count <= h_count + 1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            v_count <= 0;
        else if (h_count == H_TOTAL - 1) begin
            if (v_count == V_TOTAL - 1)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end
    end

    //HSYNC Gen
    always @(*) begin
        if (h_count >= H_VISIBLE + H_FRONT &&
            h_count <  H_VISIBLE + H_FRONT + H_SYNC)
            hsync = 0;
        else
            hsync = 1;
    end

    //VSYNC Gen
    always @(*) begin
        if (v_count >= V_VISIBLE + V_FRONT &&
            v_count <  V_VISIBLE + V_FRONT + V_SYNC)
            vsync = 0;
        else
            vsync = 1;
    end

    //Screen area
    always @(*) begin
        video_on = (h_count < H_VISIBLE && v_count < V_VISIBLE);
    end

endmodule
