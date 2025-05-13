module memory (
    input clk,
    input reset,
    input [2:0] car_sel,         // One-hot encoding: 001=car1, 010=car2, 100=car3
    input write_entry,           // Write enable for entry time
    input write_cost,            // Write enable for cost
    input [9:0] entry_time_in,   // Data to write as entry time
    input [9:0] cost_in,         // Data to write as cost
    output reg [9:0] entry_time_out, // Current entry time for selected car
    output reg [9:0] cost_out        // Current cost for selected car
);

    // Internal storage for 3 cars
    reg [9:0] entry_time_mem [2:0];
    reg [9:0] cost_mem [2:0];

    integer i;
    reg [1:0] car_index;

    // Convert one-hot to index
    always @(*) begin
        case (car_sel)
            3'b001: car_index = 2'd0;  // Car 1
            3'b010: car_index = 2'd1;  // Car 2
            3'b100: car_index = 2'd2;  // Car 3
            default: car_index = 2'd0; // Default to Car 1
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 3; i = i + 1) begin
                entry_time_mem[i] <= 10'd0;
                cost_mem[i] <= 10'd0;
            end
        end else begin
            if (write_entry) begin
                entry_time_mem[car_index] <= entry_time_in;
            end
            if (write_cost) begin
                cost_mem[car_index] <= cost_in;
            end
        end
    end

    always @(*) begin
        entry_time_out = entry_time_mem[car_index];
        cost_out = cost_mem[car_index];
    end

endmodule
