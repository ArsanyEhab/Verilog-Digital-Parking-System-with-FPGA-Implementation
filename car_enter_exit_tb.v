`timescale 1ns/1ps

module car_enter_exit_tb;
    reg clk;
    reg reset;
    reg car_enter;
    reg car_exit;
    reg [2:0] car_sel;
    reg [9:0] timer_count;
    wire [9:0] car1_enter_time;
    wire [9:0] car2_enter_time;
    wire [9:0] car3_enter_time;
    wire car1_state;
    wire car2_state;
    wire car3_state;
    wire [9:0] car1_count;
    wire [9:0] car2_count;
    wire [9:0] car3_count;
    wire [9:0] car1_cost;
    wire [9:0] car2_cost;
    wire [9:0] car3_cost;
    wire [9:0] current_cost;

    // Instantiate the car enter/exit module
    car_enter_exit dut (
        .clk(clk),
        .reset(reset),
        .car_enter(car_enter),
        .car_exit(car_exit),
        .car_sel(car_sel),
        .timer_count(timer_count),
        .car1_enter_time(car1_enter_time),
        .car2_enter_time(car2_enter_time),
        .car3_enter_time(car3_enter_time),
        .car1_state(car1_state),
        .car2_state(car2_state),
        .car3_state(car3_state),
        .car1_count(car1_count),
        .car2_count(car2_count),
        .car3_count(car3_count),
        .car1_cost(car1_cost),
        .car2_cost(car2_cost),
        .car3_cost(car3_cost),
        .current_cost(current_cost)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock (10ns period)
    end

    // Timer count generation
    initial begin
        timer_count = 0;
        forever #10 timer_count = timer_count + 1;
    end

    // Test stimulus
    initial begin
        // Initialize
        reset = 1;
        car_enter = 0;
        car_exit = 0;
        car_sel = 0;
        #20;
        
        // Release reset
        reset = 0;
        #20;

        // Test car 1 entering
        car_sel = 3'b001;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Test car 2 entering
        car_sel = 3'b010;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Test car 1 exiting
        car_sel = 3'b001;
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Test car 3 entering
        car_sel = 3'b100;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Test car 2 exiting
        car_sel = 3'b010;
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

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
        $monitor("Time=%t reset=%b car_sel=%b car_enter=%b car_exit=%b timer_count=%d car1_state=%b car2_state=%b car3_state=%b current_cost=%d",
                 $time, reset, car_sel, car_enter, car_exit, timer_count, car1_state, car2_state, car3_state, current_cost);
    end

endmodule 