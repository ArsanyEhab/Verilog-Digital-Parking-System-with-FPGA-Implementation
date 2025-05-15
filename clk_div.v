module clk_div (
    input clk,
    input reset,
    output reg CLK1Hz
);

    // For 50MHz input clock, we need to divide by 50,000,000 to get 1Hz
    // Using 26 bits to count up to 50,000,000
    reg [25:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 26'd0;
            CLK1Hz <= 1'b0;
        end else begin
            if (count >= 26'd24999999) begin  // 50MHz/2 = 25MHz, so count to 25M-1
                count <= 26'd0;
                CLK1Hz <= ~CLK1Hz;  // Toggle the output clock
            end else begin
                count <= count + 1'b1;
            end
        end
    end

endmodule
