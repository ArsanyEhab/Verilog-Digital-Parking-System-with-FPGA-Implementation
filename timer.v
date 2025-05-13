module timer (
    input clk, reset,
    output reg [9:0] timer_count // 10 bits for 0-1023
);
// ------------------------------------------------- //

always @(posedge clk or posedge reset)
begin
    if(reset) // initial (zero)
        begin
            timer_count <= 10'b0000000000; // reset the timer count
        end
    else
        begin
            if(timer_count < 10'b1111100111) // count till 999
              timer_count <= timer_count + 10'b0000000001; 
            else 
              begin
                timer_count <= 10'b0000000000; // reset the timer count
              end
        end
    end


    
endmodule