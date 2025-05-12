`timescale 1ns/1ps

module parking_system_top_tb;
    // Inputs
    reg clk;
    reg reset;
    reg car_enter;
    reg car_exit;
    reg [2:0] car_sel;

    // Outputs
    wire car1_state;
    wire car2_state;
    wire car3_state;
    wire [6:0] led_timer_1;
    wire [6:0] led_timer_2;
    wire [6:0] led_timer_3;
    wire [6:0] led_cost_1;
    wire [6:0] led_cost_2;
    wire [6:0] led_cost_3;

    // Instantiate the Unit Under Test (UUT)
    parking_system_top uut (
        .clk(clk),
        .reset(reset),
        .car_enter(car_enter),
        .car_exit(car_exit),
        .car_sel(car_sel),
        .car1_state(car1_state),
        .car2_state(car2_state),
        .car3_state(car3_state),
        .led_timer_1(led_timer_1),
        .led_timer_2(led_timer_2),
        .led_timer_3(led_timer_3),
        .led_cost_1(led_cost_1),
        .led_cost_2(led_cost_2),
        .led_cost_3(led_cost_3)
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
        car_enter = 0;
        car_exit = 0;
        car_sel = 0;
        #20;
        
        // Release reset
        reset = 0;
        #20;

        // Test Case 1: Car 1 enters
        car_sel = 3'b001;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 2: Car 2 enters
        car_sel = 3'b010;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 3: Car 1 exits
        car_sel = 3'b001;
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 4: Car 3 enters
        car_sel = 3'b011;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 5: Car 2 exits
        car_sel = 3'b010;
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 6: Car 3 exits
        car_sel = 3'b011;
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test reset functionality
        reset = 1;
        #20;
        reset = 0;
        #20;

        // Test invalid car selection
        car_sel = 3'b111;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t reset=%b car_sel=%b car_enter=%b car_exit=%b car1_state=%b car2_state=%b car3_state=%b",
                 $time, reset, car_sel, car_enter, car_exit, car1_state, car2_state, car3_state);
    end

    // Waveform dump
    initial begin
        $dumpfile("parking_system_top_tb.vcd");
        $dumpvars(0, parking_system_top_tb);
    end

endmodule 