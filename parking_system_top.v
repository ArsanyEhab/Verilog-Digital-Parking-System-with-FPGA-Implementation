module parking_system_top (
    input clk,
    input reset,
    input car_enter,
    input car_exit,
    input [2:0] car_sel,         // One-hot encoding: 001=car1, 010=car2, 100=car3
    output wire car1_state,
    output wire car2_state,
    output wire car3_state,
    output full_flag,
    output empty_flag,
    output [6:0] led_timer_1,
    output [6:0] led_timer_2,
    output [6:0] led_timer_3,
    output [6:0] led_cost_1,
    output [6:0] led_cost_2,
    output [6:0] led_cost_3
);

    // Internal signals
    wire [9:0] timer_count;
    wire [9:0] car1_enter_time, car2_enter_time, car3_enter_time;
    wire [9:0] car1_cost, car2_cost, car3_cost;
    wire [9:0] car1_count, car2_count, car3_count;
    wire [9:0] current_cost;
    wire write_entry;
    wire write_cost;
    wire [9:0] entry_time_in;
    wire [9:0] cost_in;
    wire [9:0] entry_time_out;
    wire [9:0] cost_out;
    
    // BCD conversion signals for cost
    reg [3:0] bcd_units;    // 0-9
    reg [3:0] bcd_tens;     // 0-9
    reg [3:0] bcd_hundreds; // 0-9

    // BCD conversion signals for timer display
    reg [3:0] timer_units;    // 0-9
    reg [3:0] timer_tens;     // 0-9
    reg [3:0] timer_hundreds; // 0-9

    // Binary to BCD conversion for cost
    always @(*) begin
        bcd_units = current_cost % 10;
        bcd_tens = (current_cost / 10) % 10;
        bcd_hundreds = (current_cost / 100) % 10;
    end

    // Binary to BCD conversion for timer
    always @(*) begin
        timer_units = timer_count % 10;
        timer_tens = (timer_count / 10) % 10;
        timer_hundreds = (timer_count / 100) % 10;
    end

    // Instantiate timer module
    timer timer_inst (
        .clk(clk),
        .reset(reset),
        .timer_count(timer_count)
    );

    // Instantiate car_enter_exit module
    car_enter_exit car_ctrl (
        .clk(clk),
        .reset(reset),
        .car_enter(car_enter),
        .car_exit(car_exit),
        .car_sel(car_sel),
        .timer_count(timer_count),
        .car1_state(car1_state),
        .car2_state(car2_state),
        .car3_state(car3_state),
        .car1_enter_time(car1_enter_time),
        .car2_enter_time(car2_enter_time),
        .car3_enter_time(car3_enter_time),
        .car1_count(car1_count),
        .car2_count(car2_count),
        .car3_count(car3_count),
        .car1_cost(car1_cost),
        .car2_cost(car2_cost),
        .car3_cost(car3_cost),
        .current_cost(current_cost),
        .write_entry(write_entry),
        .write_cost(write_cost),
        .entry_time_in(entry_time_in),
        .cost_in(cost_in)
    );

    // Instantiate memory module
    memory mem (
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

    // Instantiate flags module
    flags flag_ctrl (
        .clk(clk),
        .reset(reset),
        .car1_state(car1_state),
        .car2_state(car2_state),
        .car3_state(car3_state),
        .full_flag(full_flag),
        .empty_flag(empty_flag)
    );

    // Timer displays
    seven_seg timer_display1 (
        .A(timer_units[3]),
        .B(timer_units[2]),
        .C(timer_units[1]),
        .D(timer_units[0]),
        .led_a(led_timer_1[6]),
        .led_b(led_timer_1[5]),
        .led_c(led_timer_1[4]),
        .led_d(led_timer_1[3]),
        .led_e(led_timer_1[2]),
        .led_f(led_timer_1[1]),
        .led_g(led_timer_1[0])
    );

    seven_seg timer_display2 (
        .A(timer_tens[3]),
        .B(timer_tens[2]),
        .C(timer_tens[1]),
        .D(timer_tens[0]),
        .led_a(led_timer_2[6]),
        .led_b(led_timer_2[5]),
        .led_c(led_timer_2[4]),
        .led_d(led_timer_2[3]),
        .led_e(led_timer_2[2]),
        .led_f(led_timer_2[1]),
        .led_g(led_timer_2[0])
    );

    seven_seg timer_display3 (
        .A(timer_hundreds[3]),
        .B(timer_hundreds[2]),
        .C(timer_hundreds[1]),
        .D(timer_hundreds[0]),
        .led_a(led_timer_3[6]),
        .led_b(led_timer_3[5]),
        .led_c(led_timer_3[4]),
        .led_d(led_timer_3[3]),
        .led_e(led_timer_3[2]),
        .led_f(led_timer_3[1]),
        .led_g(led_timer_3[0])
    );

    // Cost displays
    seven_seg cost_display1 (
        .A(bcd_units[3]),
        .B(bcd_units[2]),
        .C(bcd_units[1]),
        .D(bcd_units[0]),
        .led_a(led_cost_1[6]),
        .led_b(led_cost_1[5]),
        .led_c(led_cost_1[4]),
        .led_d(led_cost_1[3]),
        .led_e(led_cost_1[2]),
        .led_f(led_cost_1[1]),
        .led_g(led_cost_1[0])
    );

    seven_seg cost_display2 (
        .A(bcd_tens[3]),
        .B(bcd_tens[2]),
        .C(bcd_tens[1]),
        .D(bcd_tens[0]),
        .led_a(led_cost_2[6]),
        .led_b(led_cost_2[5]),
        .led_c(led_cost_2[4]),
        .led_d(led_cost_2[3]),
        .led_e(led_cost_2[2]),
        .led_f(led_cost_2[1]),
        .led_g(led_cost_2[0])
    );

    seven_seg cost_display3 (
        .A(bcd_hundreds[3]),
        .B(bcd_hundreds[2]),
        .C(bcd_hundreds[1]),
        .D(bcd_hundreds[0]),
        .led_a(led_cost_3[6]),
        .led_b(led_cost_3[5]),
        .led_c(led_cost_3[4]),
        .led_d(led_cost_3[3]),
        .led_e(led_cost_3[2]),
        .led_f(led_cost_3[1]),
        .led_g(led_cost_3[0])
    );

endmodule