module memory (
    input clk,
    input reset,
    input [1:0] car_sel,         // 0=car1, 1=car2, 2=car3
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

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 3; i = i + 1) begin
                entry_time_mem[i] <= 10'd0;
                cost_mem[i] <= 10'd0;
            end
        end else begin
            if (write_entry) begin
                entry_time_mem[car_sel] <= entry_time_in;
            end
            if (write_cost) begin
                cost_mem[car_sel] <= cost_in;
            end
        end
    end

    always @(*) begin
        entry_time_out = entry_time_mem[car_sel];
        cost_out = cost_mem[car_sel];
    end

endmodule
