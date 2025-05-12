module parking_system_top (
    input clk, reset,
    input car_enter, car_exit,
    input [2:0] car_sel,
    output car1_state, car2_state, car3_state,
    output [9:0] car1_count, car2_count, car3_count,
    output [9:0] car1_cost, car2_cost, car3_cost,
    output [9:0] current_cost,
    output led_a, led_b, led_c, led_d, led_e, led_f, led_g
);

    wire CLK1Hz;
    wire [9:0] timer_count;
    wire [9:0] entry_time_out, cost_out;

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
        .car_sel(car_sel[1:0]),
        .write_entry(car_enter),
        .write_cost(car_exit),
        .entry_time_in(timer_count),
        .cost_in(current_cost),
        .entry_time_out(entry_time_out),
        .cost_out(cost_out)
    );

    // Instantiate 7-segment display
    // Assuming 7seg module is used to display current_cost
    // You may need to adjust the inputs based on your display logic
    wire [3:0] display_data;
    assign display_data = current_cost[3:0]; // Example: display lower 4 bits of current_cost

    seven_segment_display display_inst (
        .A(display_data[3]),
        .B(display_data[2]),
        .C(display_data[1]),
        .D(display_data[0]),
        .led_a(led_a),
        .led_b(led_b),
        .led_c(led_c),
        .led_d(led_d),
        .led_e(led_e),
        .led_f(led_f),
        .led_g(led_g)
    );

endmodule