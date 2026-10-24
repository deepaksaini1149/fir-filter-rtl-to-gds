create_clock -name clk -period 10.000 [get_ports clk]

set_input_delay 1.000 -clock clk [get_ports {data_in[*] valid_in}]
set_output_delay 1.000 -clock clk [get_ports {data_out[*] valid_out}]

set_input_transition 0.100 [get_ports {data_in[*] valid_in}]
set_load 0.010 [get_ports {data_out[*] valid_out}]
