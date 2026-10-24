`timescale 1ns/1ps
module fir_filter (
    input  wire       clk,
    input  wire       rst,
    input  wire       valid_in,
    input  wire [7:0] data_in,
    output reg        valid_out,
    output reg [15:0] data_out
);

    // Three previous input samples
    reg [7:0] x1, x2, x3;

    // Pipeline registers for weighted samples
    reg [9:0] p0, p1, p2, p3;

    // Pipeline registers for partial sums
    reg [10:0] sum01;
    reg [10:0] sum23;
    reg [11:0] final_sum;

    // Pipeline validity tracking
    reg [3:0] valid_pipe;

    always @(posedge clk) begin
        if (rst) begin
            x1 <= 0;
            x2 <= 0;
            x3 <= 0;

            p0 <= 0;
            p1 <= 0;
            p2 <= 0;
            p3 <= 0;

            sum01 <= 0;
            sum23 <= 0;
            final_sum <= 0;

            data_out <= 0;
            valid_pipe <= 0;
            valid_out <= 0;
        end else begin
            // Delay line
            x1 <= data_in;
            x2 <= x1;
            x3 <= x2;

            // Weighted samples: coefficients 1, 2, 3, 2
            p0 <= {2'b00, data_in};
            p1 <= {1'b0, x1, 1'b0};
            p2 <= (x2 * 3);
            p3 <= {1'b0, x3, 1'b0};

            // Pipelined addition stages
            sum01 <= p0 + p1;
            sum23 <= p2 + p3;
            final_sum <= sum01 + sum23;

            // Output register
            data_out <= final_sum;

            // Align valid signal with the datapath latency
            valid_pipe <= {valid_pipe[2:0], valid_in};
            valid_out <= valid_pipe[2];
        end
    end

endmodule
