module Integer_Clk_Divider_TB ();

///////////////////// Parameters ////////////////////////

	parameter		CLK_PERIOD = 10 ;

//////////////////// DUT Signals ////////////////////////

	reg				I_ref_clk_TB;    	// Clock
	reg 			I_clk_en_TB; 		// Clock Enable
	reg 			I_rst_n_TB;  		// Asynchronous reset active low
	reg		[7:0]	I_div_ratio_TB;		// The divided ratio (integer value)	
	
	wire			o_div_clk_TB;

////////////////// module instantation /////////////////////// 

Integer_Clk_Divider DUT (
.I_clk_en   (I_clk_en_TB),
.I_ref_clk  (I_ref_clk_TB),
.I_rst_n    (I_rst_n_TB),
.I_div_ratio(I_div_ratio_TB),
.o_div_clk  (o_div_clk_TB)
);

////////////////// Clock Generator /////////////////////// 

always #(CLK_PERIOD/2) I_ref_clk_TB = ~I_ref_clk_TB ;


////////////////// initial block ///////////////////////

initial begin
	
	// Initialization
	I_ref_clk_TB = 1'b0  ;
	I_rst_n_TB   = 1'b0  ;    // rst is activated
	I_clk_en_TB  = 1'b0  ;

	// Reset is deactivated
	#(CLK_PERIOD)	I_rst_n_TB = 1'b1; 

	// Enable
	#(CLK_PERIOD)	I_clk_en_TB = 1'b1; 

	////////////// Test Case 1 (even division) //////////////////

	// Load div ratio 
	I_div_ratio_TB = 8'h04;  

	#(20*CLK_PERIOD);
	 
	////////////// Test Case 2 (odd division) ////////////////

	// Load div ratio 
	I_div_ratio_TB = 8'h03;  
	
	#(20*CLK_PERIOD);

	#20;

	if(I_clk_en_TB && ( I_div_ratio_TB != 0) && ( I_div_ratio_TB != 1)) begin
	
		$display("corner Case is passed succesfully !! , I_div_ratio not equals Zero or One before enable the clock divider");

	end

	$stop ;

end 

endmodule : Integer_Clk_Divider_TB
