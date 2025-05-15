module timer (
    input clk, reset,
    output reg [9:0] timer_count // 10 bits for 0-1023
);
// ------------------------------------------------- //

always @(posedge clk or posedge reset)
begin
    if(reset) // initial (zero)
        timer_count <= 10'b0000000000; // reset the timer count
    else if(timer_count >= 10'd999) // count till 999
        timer_count <= 10'b0000000000; // reset when reaching 999
    else
        timer_count <= timer_count + 10'b0000000001; // increment counter
end

endmodule