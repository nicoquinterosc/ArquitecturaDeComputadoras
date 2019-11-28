#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/home/nicoq/Xilinx/SDK/2019.1/bin:/home/nicoq/Xilinx/Vivado/2019.1/ids_lite/ISE/bin/lin64:/home/nicoq/Xilinx/Vivado/2019.1/bin
else
  PATH=/home/nicoq/Xilinx/SDK/2019.1/bin:/home/nicoq/Xilinx/Vivado/2019.1/ids_lite/ISE/bin/lin64:/home/nicoq/Xilinx/Vivado/2019.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/nicoq/Facu/Arquitectura/ArquitecturaDeComputadoras/TP3_BIP2/TP3_BIP.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log top_level.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source top_level.tcl -notrace


