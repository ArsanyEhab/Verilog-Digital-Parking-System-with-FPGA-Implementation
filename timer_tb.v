`timescale 1ns/1ps

module timer_tb;
    reg clk;
    reg reset;
    wire [9:0] timer_count;

    // Instantiate the timer
    timer dut (
        .clk(clk),
        .reset(reset),
        .timer_count(timer_count)
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
        
        // Release reset and let timer count
        reset = 0;
        #1000;
        
        // Apply reset to check if timer resets
        reset = 1;
        #20;
        
        // Release reset and let timer count again
        reset = 0;
        #1000;
        
        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t reset=%b clk=%b timer_count=%d", 
                 $time, reset, clk, timer_count);
    end

endmodule 