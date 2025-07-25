<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## What it does

Explain what your peripheral does and how it works

## Register map

Document the registers that are used to interact with your peripheral

| Address | Name      | Access | Description                                               |
| ------- | --------- | ------ | --------------------------------------------------------- |
| 0x00    | INPUT     | W      | Input data value to be spike-encoded                      |
| 0x01    | THRESHOLD | W      | Threshold for spike generation (compare against INPUT)    |
| 0x02    | CONTROL   | W      | Bit0 = Enable, Bit1 = Continuous mode                     |
| 0x03    | STATUS    | R      | Bit0 = Spike active (1 when spike generated, 0 otherwise) |

## How to test

1. **Simulation:**
   - Run `make SIM=icarus TOPLEVEL=tt_um_tqv_peripheral_harness MODULE=test`
   - Check `tb_spike.vcd` waveform and test logs.

2. **On silicon:**
   - Provide an input rate via SPI register 0.
   - Set threshold via SPI register 1.
   - Enable encoder (bit0=1 of register 2).
   - Observe `spike_out` on the output pin (uo_out[0]).

3. **Expected behavior:**
   - When input > threshold → `spike_out` pulses.
   - When input < threshold → no spikes.

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
