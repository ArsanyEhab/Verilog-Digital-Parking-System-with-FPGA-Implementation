module timer (clk, reset);
input clk, reset;
output reg [9:0] timer_count; // 10 bits for 0-1023
// ------------------------------------------------- //

always @(posedge clk or posedge reset)
begin
    if(reset) // initial (zero)
        begin
            clk <= 0;
            timer_count <= 10b'0; // reset the timer count
        end
    else
        begin
            if(timer_count < 10d'1111100111)
              timer_count <= timer_count + 10d'0000000001; // count 1023 
            else 
              begin
                timer_count <= 10b'0; // reset the timer count
              end
        end
    end


    
endmodule