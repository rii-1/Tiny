# SPDX-FileCopyrightText: © 2025 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

from tqv import TinyQV

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 100 ns (10 MHz)
    clock = Clock(dut.clk, 100, units="ns")
    cocotb.start_soon(clock.start())

    # Initialize TinyQV for register read/write
    tqv = TinyQV(dut)

    # Reset
    await tqv.reset()
    dut._log.info("Reset done")

    # Write a value to register 0
    await tqv.write_reg(0, 100)
    read_val = await tqv.read_reg(0)
    dut._log.info(f"Register 0 read back: {read_val}")
    assert read_val == 100, "Register write/read failed"

    # Wait for spike output to reflect input (with sync delay)
    await ClockCycles(dut.clk, 3)

    # Check spike output
    spike_out = dut.uo_out.value & 0x1
    dut._log.info(f"Spike output: {spike_out}")

    # Replace with your logic if spike is threshold-based
    assert spike_out in (0,1), "Spike output must be 0 or 1"

    # Further tests can be added based on thresholding behavior:
    # For example, set low register value and check no spike
    await tqv.write_reg(0, 1)
    await ClockCycles(dut.clk, 3)
    spike_out_low = dut.uo_out.value & 0x1
    dut._log.info(f"Spike output for low input: {spike_out_low}")
    assert spike_out_low == 0, "Spike output should be 0 for low input"

    dut._log.info("Test completed successfully")

