module Integer_Clk_Divider (

	input 	wire			I_ref_clk,    	// Clock
	input 	wire 			I_clk_en, 		// Clock Enable
	input 	wire 			I_rst_n,  		// Asynchronous reset active low
	input 	wire	[7:0]	I_div_ratio,	// The divided ratio (integer value)	
	
	output  reg				o_div_clk
);
	
	reg 				odd_toggle_flag;	// 0 >> first toggle, 1 >> second toggle
	reg 				odd_Div_flag;
	reg 	[3:0]		div_counter;

always @(posedge I_ref_clk or negedge I_rst_n) begin 
	
	if(~I_rst_n) begin
		o_div_clk <= 0;
		odd_Div_flag <= 0;
		odd_toggle_flag <= 0;
		div_counter <= 1;
	
	end 

	else if(I_clk_en) begin
			
			odd_Div_flag <= I_div_ratio[0];	// 0 >> even, 1 >> odd

			/********************* even division ***********************/
			if (odd_Div_flag == 0) begin 	
			 	
			 	if (div_counter == (I_div_ratio >> 1) ) begin
			 		
			 		o_div_clk <= ~ o_div_clk;
			 		div_counter <= 1'b1;
			 	end

			 	else begin
			 		div_counter <= div_counter + 1'b1;
			 	end
			end

			/********************* odd division ***********************/
			else begin

				// first toggle

				if ( (div_counter == I_div_ratio >> 1) && (!odd_toggle_flag) ) begin 	
					
					o_div_clk <= ~ o_div_clk;
					odd_toggle_flag <= ~ odd_toggle_flag;
				end
				
				// second toggle

				else if( (div_counter == (I_div_ratio >> 1)+1) && (odd_toggle_flag) ) begin
					
					o_div_clk <= ~ o_div_clk;
					odd_toggle_flag <= ~ odd_toggle_flag;
					div_counter <= 1'b1;					
				end

				else begin
			 		div_counter <= div_counter + 1'b1;
				end
			end 
	end
end

endmodule : Integer_Clk_Divider