module flags (
    input clk,
    input reset,
    input car1_state,
    input car2_state,
    input car3_state,
    output reg full_flag,
    output reg empty_flag
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            full_flag <= 0;
            empty_flag <= 1;
        end else begin
            if (car1_state && car2_state && car3_state) begin
                full_flag <= 1; // All cars are in
                empty_flag <= 0; // No cars are out
            end else if (!car1_state && !car2_state && !car3_state) begin
                full_flag <= 0; // No cars are in
                empty_flag <= 1; // All cars are out
            end else begin
                full_flag <= 0; // Not full
                empty_flag <= 0; // Not empty
            end
        end
    end

endmodule