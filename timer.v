module timer (clk, reset);
input clk, reset;
output reg [9:0] timer_count; // 10 bits for 0-1023
// ------------------------------------------------- //

always @(posedge clk or posedge reset)
begin
    if(reset) // initial (zero)
        begin
            clk <= 0;
            timer_count <= 0;
        end
    else
        begin
            if(timer_count < 999)
              timer_count <= timer_count + 1; // count 1023 
            else 
              begin
                timer_count <= 0; // reset the timer count
              end
        end
    end


    
endmodule