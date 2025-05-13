module car_enter_exit (
  input clk, reset,
  input car_enter, car_exit,
  input [2:0]car_sel,
  input [9:0] timer_count,
  output reg car1_state, car2_state, car3_state,
  output reg [9:0] car1_enter_time, car2_enter_time, car3_enter_time,
  output reg [9:0] car1_count,car2_count,car3_count, // 10 bits for 0-1023
  output reg [9:0] car1_cost,car2_cost,car3_cost, // 10 bits for 0-1023
  output reg [9:0] currunt_cost // 10 bits for 0-1023
);


    // ------------------------------------------------- //

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            car1_count <= 10'd0;
            car2_count <= 10'd0;
            car3_count <= 10'd0;
            currunt_cost <= 10'd0;
            car1_state <= 0; // car1 is out
            car2_state <= 0; // car2 is out
            car3_state <= 0; // car3 is out
            car1_cost <= 10'd0; // reset cost
            car2_cost <= 10'd0; // reset cost
            car3_cost <= 10'd0; // reset cost
            car1_enter_time <= 10'd0; // reset enter time
            car2_enter_time <= 10'd0; // reset enter time
            car3_enter_time <= 10'd0; // reset enter time
        end else begin
            if (car_enter) begin
                case (car_sel)
                    3'b001: begin
                            car1_enter_time <= timer_count; // count 1023 
                            car1_state <= 1; // car1 is in
                            car1_cost <= 10'd0; // reset cost
                    end
                    3'b010: begin
                            car2_enter_time <= timer_count; // count 1023 
                            car2_state <= 1; // car2 is in
                            car2_cost <= 10'd0; // reset cost
                    end
                    3'b100: begin
                            car3_enter_time <= timer_count; // count 1023 
                            car3_state <= 1; // car3 is in
                            car3_cost <= 10'd0; // reset cost
                    end
                endcase
            end else if (car_exit) begin
                case (car_sel)
                3'b001: begin
                            car1_state <= 0; // car1 is out
                            car1_cost <= (timer_count - car1_enter_time); // calculate cost
                            currunt_cost <= car1_cost; // display cost
                            car1_enter_time <= 10'd0; // reset enter time
                end
                3'b010: begin
                            car2_state <= 0; // car2 is out
                            car2_cost <= (timer_count - car2_enter_time); // calculate cost
                            currunt_cost <= car2_cost; // display cost
                            car2_enter_time <= 10'd0; // reset enter time
                end
                3'b100: begin
                            car3_state <= 0; // car3 is out
                            car3_cost <= (timer_count - car3_enter_time); // calculate cost
                            currunt_cost <= car3_cost; // display cost
                            car3_enter_time <= 10'd0; // reset enter time
                end
                default: begin
                    currunt_cost <= 10'd0;
                end

                endcase
            end
        end
    end

    
endmodule