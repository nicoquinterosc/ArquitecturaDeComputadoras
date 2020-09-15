#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Fri Sep 11 17:54:04 -03 2020
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 8015f300b3d34882a60daff96c615a84 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot uart_test_behav xil_defaultlib.uart_test xil_defaultlib.glbl -log elaborate.log"
xelab -wto 8015f300b3d34882a60daff96c615a84 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot uart_test_behav xil_defaultlib.uart_test xil_defaultlib.glbl -log elaborate.log
