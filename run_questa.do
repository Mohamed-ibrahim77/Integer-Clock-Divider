vlib work

vlog -f source_file.txt

vsim -voptargs="+acc" work.Integer_Clk_Divider_TB -logfile transcript_output.log 

#write transcript trans.log 

add wave *

add wave -position insertpoint  \
sim:/Integer_Clk_Divider_TB/DUT/odd_toggle_flag \
sim:/Integer_Clk_Divider_TB/DUT/odd_Div_flag \
sim:/Integer_Clk_Divider_TB/DUT/div_counter

run -all
