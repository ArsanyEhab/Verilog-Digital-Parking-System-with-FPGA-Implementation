module seven_seg (A, B, C, D, led_a, led_b, led_c, led_d, led_e, led_f, led_g);
	input A, B, C, D;
	output led_a, led_b, led_c, led_d, led_e, led_f, 
             led_g;

	// Active-high seven-segment display (1 means segment is ON)
	// For common-cathode display, segments should be ON (1) to display numbers
	assign led_a = ~(A | C | B&D | ~B&~D);
	assign led_b = ~(~B | ~C&~D | C&D);
	assign led_c = ~(B | ~C | D);
	assign led_d = ~(~B&~D | C&~D | B&~C&D | ~B&C | A);
	assign led_e = ~(~B&~D | C&~D);
	assign led_f = ~(A | ~C&~D | B&~C | B&~D);
	assign led_g = ~(A | B&~C | ~B&C | C&~D);
endmodule