/*
 * Spike Module Peripheral
 * Converts input data to spike-encoded address and data_out
 */

`default_nettype none
/*
 * Spike Encoder Peripheral Module
 * Rewritten for integration with TinyQV peripheral harness
 */

module spike (
  input wire clk,
  input wire rst_n,

  input wire [7:0] ui_in,      // External inputs if needed
  output reg [7:0] uo_out,     // Outputs

  input wire [3:0] address,    // Peripheral register address
  input wire data_write,       // Write strobe
  input wire [7:0] data_in,    // Data to write
  output reg [7:0] data_out    // Data to read
);

  // Internal register to store input value
  reg [7:0] input_reg;
  reg spike_reg;

  // Example: address map
  localparam ADDR_INPUT = 4'h0;
  localparam ADDR_SPIKE = 4'h1;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      input_reg <= 8'd0;
      spike_reg <= 1'b0;
      uo_out    <= 8'd0;
    end else begin
      // Write to registers
      if (data_write) begin
        case (address)
          ADDR_INPUT: input_reg <= data_in;
          default: ;
        endcase
      end

      // Spike encoding logic (simple threshold example)
      if (input_reg >=8'd100)
        spike_reg <= 1'b1;
      else
        spike_reg <= 1'b0;

      // Drive uo_out[0] as spike output
      uo_out[0] <= spike_reg;
    end
  end

  // Read from registers
  always @(*) begin
    case (address)
      ADDR_INPUT: data_out = input_reg;
      ADDR_SPIKE: data_out = {7'd0, spike_reg};
      default:    data_out = 8'd0;
    endcase
  end

endmodule

