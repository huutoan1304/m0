-makelib xcelium_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ip/clk_wiz_100/clk_wiz_100_clk_wiz.v" \
  "../../../ip/clk_wiz_100/clk_wiz_100.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

