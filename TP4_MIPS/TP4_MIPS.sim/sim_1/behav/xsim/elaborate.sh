#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Wed Jul 08 02:36:16 -03 2020
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto e25cc01912a946c0a26cdad418b243aa --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot readmemh_tb_behav xil_defaultlib.readmemh_tb xil_defaultlib.glbl -log elaborate.log"
xelab -wto e25cc01912a946c0a26cdad418b243aa --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot readmemh_tb_behav xil_defaultlib.readmemh_tb xil_defaultlib.glbl -log elaborate.log

