module parking_system_top (
    input clk, reset, //1 Clock, 1 Reset
    input car_enter, car_exit, //2 Switches
    input [2:0] car_sel, //3 Switches
    output car1_state, car2_state, car3_state, //3 LEDs
    output [6:0] led_timer_1, led_timer_2, led_timer_3, //3 * 7-segment displays
    output [6:0] led_cost_1, led_cost_2, led_cost_3 //3 * 7-segment displays
);

    wire CLK1Hz;
    wire [9:0] timer_count;
    wire [9:0] entry_time_out, cost_out;
    wire [9:0] car1_count, car2_count, car3_count;
    wire [9:0] car1_cost, car2_cost, car3_cost;
    wire [9:0] current_cost;
    wire [9:0] selected_cost;

    // Instantiate clock divider
    clock_divider clk_div_inst (
        .clk(clk),
        .reset(reset),
        .CLK1Hz(CLK1Hz)
    );

    // Instantiate timer
    timer timer_inst (
        .clk(CLK1Hz),
        .reset(reset),
        .timer_count(timer_count)
    );

    // Instantiate car enter/exit module
    car_enter_exit car_inst (
        .clk(CLK1Hz),
        .reset(reset),
        .car_enter(car_enter),
        .car_exit(car_exit),
        .car_sel(car_sel),
        .timer_count(timer_count),
        .car1_enter_time(entry_time_out),
        .car2_enter_time(entry_time_out),
        .car3_enter_time(entry_time_out),
        .car1_state(car1_state),
        .car2_state(car2_state),
        .car3_state(car3_state),
        .car1_count(car1_count),
        .car2_count(car2_count),
        .car3_count(car3_count),
        .car1_cost(car1_cost),
        .car2_cost(car2_cost),
        .car3_cost(car3_cost),
        .currunt_cost(current_cost)
    );

    // Instantiate memory module
    memory memory_inst (
        .clk(CLK1Hz),
        .reset(reset),
        .car_sel(car_sel),  // Use all 3 bits
        .write_entry(car_enter),
        .write_cost(car_exit),
        .entry_time_in(timer_count),
        .cost_in(current_cost),
        .entry_time_out(entry_time_out),
        .cost_out(cost_out)
    );

    // Timer displays
    seven_segment_display timer_display1 (
        .A(timer_count[3]),
        .B(timer_count[2]),
        .C(timer_count[1]),
        .D(timer_count[0]),
        .led_a(led_timer_1[0]),
        .led_b(led_timer_1[1]),
        .led_c(led_timer_1[2]),
        .led_d(led_timer_1[3]),
        .led_e(led_timer_1[4]),
        .led_f(led_timer_1[5]),
        .led_g(led_timer_1[6])
    );

    seven_segment_display timer_display2 (
        .A(timer_count[7]),
        .B(timer_count[6]),
        .C(timer_count[5]),
        .D(timer_count[4]),
        .led_a(led_timer_2[0]),
        .led_b(led_timer_2[1]),
        .led_c(led_timer_2[2]),
        .led_d(led_timer_2[3]),
        .led_e(led_timer_2[4]),
        .led_f(led_timer_2[5]),
        .led_g(led_timer_2[6])
    );

    seven_segment_display timer_display3 (
        .A(0),
        .B(0),
        .C(timer_count[9]),
        .D(timer_count[8]),
        .led_a(led_timer_3[0]),
        .led_b(led_timer_3[1]),
        .led_c(led_timer_3[2]),
        .led_d(led_timer_3[3]),
        .led_e(led_timer_3[4]),
        .led_f(led_timer_3[5]),
        .led_g(led_timer_3[6])
    );

    // Cost displays
    seven_segment_display cost_display1 (
        .A(current_cost[3]),
        .B(current_cost[2]),
        .C(current_cost[1]),
        .D(current_cost[0]),
        .led_a(led_cost_1[0]),
        .led_b(led_cost_1[1]),
        .led_c(led_cost_1[2]),
        .led_d(led_cost_1[3]),
        .led_e(led_cost_1[4]),
        .led_f(led_cost_1[5]),
        .led_g(led_cost_1[6])
    );

    seven_segment_display cost_display2 (
        .A(current_cost[7]),
        .B(current_cost[6]),
        .C(current_cost[5]),
        .D(current_cost[4]),
        .led_a(led_cost_2[0]),
        .led_b(led_cost_2[1]),
        .led_c(led_cost_2[2]),
        .led_d(led_cost_2[3]),
        .led_e(led_cost_2[4]),
        .led_f(led_cost_2[5]),
        .led_g(led_cost_2[6])
    );

    seven_segment_display cost_display3 (
        .A(0),
        .B(0),
        .C(current_cost[9]),
        .D(current_cost[8]),
        .led_a(led_cost_3[0]),
        .led_b(led_cost_3[1]),
        .led_c(led_cost_3[2]),
        .led_d(led_cost_3[3]),
        .led_e(led_cost_3[4]),
        .led_f(led_cost_3[5]),
        .led_g(led_cost_3[6])
    );

endmodule