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
    wire full_flag;
    wire empty_flag;

    // Internal signals for monitoring
    wire [9:0] timer_count;
    wire [9:0] current_cost;
    wire write_entry;
    wire write_cost;
    wire [9:0] entry_time_in;
    wire [9:0] cost_in;
    wire [9:0] entry_time_out;
    wire [9:0] cost_out;

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
        .led_cost_3(led_cost_3),
        .full_flag(full_flag),
        .empty_flag(empty_flag)
    );

    // Assign internal signals for monitoring
    assign timer_count = uut.timer_inst.timer_count;
    assign current_cost = uut.car_ctrl.current_cost;
    assign write_entry = uut.car_ctrl.write_entry;
    assign write_cost = uut.car_ctrl.write_cost;
    assign entry_time_in = uut.car_ctrl.entry_time_in;
    assign cost_in = uut.car_ctrl.cost_in;
    assign entry_time_out = uut.mem.entry_time_out;
    assign cost_out = uut.mem.cost_out;

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
        $display("\n=== Car 1 Enters ===");
        car_sel = 3'b001;  // Car 1
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 2: Car 2 enters
        $display("\n=== Car 2 Enters ===");
        car_sel = 3'b010;  // Car 2
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 3: Car 3 enters (should set full_flag)
        $display("\n=== Car 3 Enters (Parking Full) ===");
        car_sel = 3'b100;  // Car 3
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 4: Try to enter Car 1 again (should be ignored due to full_flag)
        $display("\n=== Try to Enter Car 1 (Should be Ignored) ===");
        car_sel = 3'b001;  // Car 1
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 5: Car 1 exits (should clear full_flag)
        $display("\n=== Car 1 Exits ===");
        car_sel = 3'b001;  // Car 1
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 6: Car 1 enters again (should work now)
        $display("\n=== Car 1 Enters Again ===");
        car_sel = 3'b001;  // Car 1
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 7: Car 2 exits
        $display("\n=== Car 2 Exits ===");
        car_sel = 3'b010;  // Car 2
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 8: Car 3 exits
        $display("\n=== Car 3 Exits ===");
        car_sel = 3'b100;  // Car 3
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test Case 9: Car 1 exits (should set empty_flag)
        $display("\n=== Car 1 Exits (Parking Empty) ===");
        car_sel = 3'b001;  // Car 1
        car_exit = 1;
        #10;
        car_exit = 0;
        #50;

        // Wait for some time
        #100;

        // Test reset functionality
        $display("\n=== Testing Reset ===");
        reset = 1;
        #20;
        reset = 0;
        #20;

        // Test invalid car selection
        $display("\n=== Testing Invalid Car Selection ===");
        car_sel = 3'b111;
        car_enter = 1;
        #10;
        car_enter = 0;
        #50;

        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t reset=%b car_sel=%b car_enter=%b car_exit=%b car1_state=%b car2_state=%b car3_state=%b full_flag=%b empty_flag=%b write_entry=%b write_cost=%b entry_time_in=%d cost_in=%d entry_time_out=%d cost_out=%d",
                 $time, reset, car_sel, car_enter, car_exit, car1_state, car2_state, car3_state, full_flag, empty_flag,
                 write_entry, write_cost, entry_time_in, cost_in, entry_time_out, cost_out);
    end

    // Display time and cost values
    always @(posedge clk) begin
        if (!reset) begin
            $display("Time: %d, Cost: %d", timer_count, current_cost);
        end
    end

    // Waveform dump
    initial begin
        $dumpfile("parking_system_top_tb.vcd");
        $dumpvars(0, parking_system_top_tb);
    end

endmodule 