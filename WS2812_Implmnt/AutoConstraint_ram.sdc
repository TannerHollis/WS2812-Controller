
#Begin clock constraint
define_clock -name {ram|wclk} {p:ram|wclk} -period 8350.000 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 4175.000 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {ram|rclk} {p:ram|rclk} -period 21037.000 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 10518.500 -route 0.000 
#End clock constraint
