`timescale 1ns/1ps

module clock_divider_tb;
    reg clk;
    reg reset;
    wire CLK1Hz;

    // Instantiate the clock divider
    clock_divider dut (
        .clk(clk),
        .reset(reset),
        .CLK1Hz(CLK1Hz)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock (10ns period)
    end

    // Test stimulus
    initial begin
        // Initialize
        reset = 1;
        #20;
        
        // Release reset
        reset = 0;
        
        // Wait for a few clock cycles
        #1000;
        
        // Apply reset again
        reset = 1;
        #20;
        
        // Release reset
        reset = 0;
        
        // Wait for more clock cycles
        #1000;
        
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t reset=%b clk=%b CLK1Hz=%b", 
                 $time, reset, clk, CLK1Hz);
    end

endmodule 