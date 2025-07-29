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

| Address | Name      | Access | Description                                                                  |
| ------- | --------- | ------ | ---------------------------------------------------------------------------- |
| 0x00    | PIXEL     | W/R    | Current pixel intensity (write new pixel value; read back last written)      |
| 0x01    | THRESHOLD | W/R    | Threshold for edge detection (default 20)                                    |
| 0x02    | SPIKE     | R      | Bit0 = Spike detected (1 = spike event, 0 = no spike)                        |
| 0x03    | COUNT     | R      | Spike count (increments each time a spike is detected; resets on system rst) |


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
