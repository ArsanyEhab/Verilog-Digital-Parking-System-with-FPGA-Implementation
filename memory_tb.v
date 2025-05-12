`timescale 1ns/1ps

module memory_tb;
    reg clk;
    reg reset;
    reg [2:0] car_sel;
    reg write_entry;
    reg write_cost;
    reg [9:0] entry_time_in;
    reg [9:0] cost_in;
    wire [9:0] entry_time_out;
    wire [9:0] cost_out;

    // Instantiate the memory module
    memory dut (
        .clk(clk),
        .reset(reset),
        .car_sel(car_sel),
        .write_entry(write_entry),
        .write_cost(write_cost),
        .entry_time_in(entry_time_in),
        .cost_in(cost_in),
        .entry_time_out(entry_time_out),
        .cost_out(cost_out)
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
        car_sel = 0;
        write_entry = 0;
        write_cost = 0;
        entry_time_in = 0;
        cost_in = 0;
        #20;
        
        // Release reset
        reset = 0;
        #20;

        // Test writing entry time for car 1
        car_sel = 3'b001;
        entry_time_in = 10'h123;
        write_entry = 1;
        #10;
        write_entry = 0;
        #20;

        // Test writing cost for car 1
        cost_in = 10'h456;
        write_cost = 1;
        #10;
        write_cost = 0;
        #20;

        // Test writing entry time for car 2
        car_sel = 3'b010;
        entry_time_in = 10'h789;
        write_entry = 1;
        #10;
        write_entry = 0;
        #20;

        // Test writing cost for car 2
        cost_in = 10'hABC;
        write_cost = 1;
        #10;
        write_cost = 0;
        #20;

        // Test reading data for car 1
        car_sel = 3'b001;
        #20;

        // Test reading data for car 2
        car_sel = 3'b010;
        #20;

        // Apply reset
        reset = 1;
        #20;
        
        // Release reset
        reset = 0;
        #20;

        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t reset=%b car_sel=%b write_entry=%b write_cost=%b entry_time_in=%h cost_in=%h entry_time_out=%h cost_out=%h",
                 $time, reset, car_sel, write_entry, write_cost, entry_time_in, cost_in, entry_time_out, cost_out);
    end

endmodule 