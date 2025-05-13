`timescale 1ns/1ps

module seven_segment_display_tb;
    reg A, B, C, D;
    wire led_a, led_b, led_c, led_d, led_e, led_f, led_g;

    // Instantiate the seven-segment display
    seven_seg dut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .led_a(led_a),
        .led_b(led_b),
        .led_c(led_c),
        .led_d(led_d),
        .led_e(led_e),
        .led_f(led_f),
        .led_g(led_g)
    );

    // Test stimulus
    initial begin
        // Test all possible combinations (0-9)
        // 0
        {A,B,C,D} = 4'b0000;
        #10;
        
        // 1
        {A,B,C,D} = 4'b0001;
        #10;
        
        // 2
        {A,B,C,D} = 4'b0010;
        #10;
        
        // 3
        {A,B,C,D} = 4'b0011;
        #10;
        
        // 4
        {A,B,C,D} = 4'b0100;
        #10;
        
        // 5
        {A,B,C,D} = 4'b0101;
        #10;
        
        // 6
        {A,B,C,D} = 4'b0110;
        #10;
        
        // 7
        {A,B,C,D} = 4'b0111;
        #10;
        
        // 8
        {A,B,C,D} = 4'b1000;
        #10;
        
        // 9
        {A,B,C,D} = 4'b1001;
        #10;

        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%t A=%b B=%b C=%b D=%b led_a=%b led_b=%b led_c=%b led_d=%b led_e=%b led_f=%b led_g=%b",
                 $time, A, B, C, D, led_a, led_b, led_c, led_d, led_e, led_f, led_g);
    end

endmodule 