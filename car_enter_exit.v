module car_enter_exit (
  input clk, reset,
  input car_enter, car_exit,
  input [2:0] car_sel,
  input [9:0] timer_count,
  output reg car1_state, car2_state, car3_state,
  output reg [9:0] car1_enter_time, car2_enter_time, car3_enter_time,
  output reg [9:0] car1_count, car2_count, car3_count,
  output reg [9:0] car1_cost, car2_cost, car3_cost,
  output reg [9:0] current_cost,
  output reg write_entry,
  output reg write_cost,
  output reg [9:0] entry_time_in,
  output reg [9:0] cost_in
);


    // ------------------------------------------------- //

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            car1_count <= 10'd0;
            car2_count <= 10'd0;
            car3_count <= 10'd0;
            current_cost <= 10'd0;
            car1_state <= 0; // car1 is out
            car2_state <= 0; // car2 is out
            car3_state <= 0; // car3 is out
            car1_cost <= 10'd0; // reset cost
            car2_cost <= 10'd0; // reset cost
            car3_cost <= 10'd0; // reset cost
            car1_enter_time <= 10'd0; // reset enter time
            car2_enter_time <= 10'd0; // reset enter time
            car3_enter_time <= 10'd0; // reset enter time
            write_entry <= 1'b0;
            write_cost <= 1'b0;
            entry_time_in <= 10'd0;
            cost_in <= 10'd0;
        end else begin
            if (car_enter) begin
                case (car_sel)
                    3'b001: begin
                            car1_enter_time <= timer_count;
                            car1_state <= 1; // car1 is in
                            car1_cost <= 10'd0; // reset cost
                            current_cost <= 10'd0; // clear cost display
                            write_entry <= 1'b1;
                            entry_time_in <= timer_count;
                            cost_in <= 10'd0;
                    end
                    3'b010: begin
                            car2_enter_time <= timer_count;
                            car2_state <= 1; // car2 is in
                            car2_cost <= 10'd0; // reset cost
                            current_cost <= 10'd0; // clear cost display
                            write_entry <= 1'b1;
                            entry_time_in <= timer_count;
                            cost_in <= 10'd0;
                    end
                    3'b100: begin
                            car3_enter_time <= timer_count;
                            car3_state <= 1; // car3 is in
                            car3_cost <= 10'd0; // reset cost
                            current_cost <= 10'd0; // clear cost display
                            write_entry <= 1'b1;
                            entry_time_in <= timer_count;
                            cost_in <= 10'd0;
                    end
                    default: begin
                            current_cost <= 10'd0; // clear cost display for invalid selection
                            write_entry <= 1'b0;
                            write_cost <= 1'b0;
                    end
                endcase
            end else if (car_exit) begin
                case (car_sel)
                    3'b001: begin
                            if (car1_state) begin // only calculate cost if car is in
                                car1_state <= 0; // car1 is out
                                car1_cost <= (timer_count - car1_enter_time); // calculate cost
                                current_cost <= (timer_count - car1_enter_time); // display cost
                                car1_enter_time <= 10'd0; // reset enter time
                                write_cost <= 1'b1;
                                cost_in <= (timer_count - car1_enter_time);
                            end
                    end
                    3'b010: begin
                            if (car2_state) begin // only calculate cost if car is in
                                car2_state <= 0; // car2 is out
                                car2_cost <= (timer_count - car2_enter_time); // calculate cost
                                current_cost <= (timer_count - car2_enter_time); // display cost
                                car2_enter_time <= 10'd0; // reset enter time
                                write_cost <= 1'b1;
                                cost_in <= (timer_count - car2_enter_time);
                            end
                    end
                    3'b100: begin
                            if (car3_state) begin // only calculate cost if car is in
                                car3_state <= 0; // car3 is out
                                car3_cost <= (timer_count - car3_enter_time); // calculate cost
                                current_cost <= (timer_count - car3_enter_time); // display cost
                                car3_enter_time <= 10'd0; // reset enter time
                                write_cost <= 1'b1;
                                cost_in <= (timer_count - car3_enter_time);
                            end
                    end
                    default: begin
                            current_cost <= 10'd0; // clear cost display for invalid selection
                            write_entry <= 1'b0;
                            write_cost <= 1'b0;
                    end
                endcase
            end else begin
                write_entry <= 1'b0;
                write_cost <= 1'b0;
            end
        end
    end

    
endmodule