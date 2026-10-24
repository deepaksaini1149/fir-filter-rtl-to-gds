
`timescale 1ns/1ps

module tb_fir_filter;

    reg clk = 0;
    reg rst = 1;
    reg valid_in = 0;
    reg [7:0] data_in = 0;

    wire valid_out;
    wire [15:0] data_out;

    integer errors = 0;
    integer count = 0;

    reg [7:0] samples [0:7];
    reg [15:0] expected [0:7];

    fir_filter dut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .data_in(data_in),
        .valid_out(valid_out),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/fir_filter.vcd");
        $dumpvars(0, tb_fir_filter);

        samples[0]=10; samples[1]=20;
        samples[2]=30; samples[3]=40;
        samples[4]=50; samples[5]=60;
        samples[6]=70; samples[7]=80;

        expected[0]=10;  expected[1]=40;
        expected[2]=100; expected[3]=180;
        expected[4]=260; expected[5]=340;
        expected[6]=420; expected[7]=500;

        repeat (2) @(negedge clk);
        rst = 0;

        for (integer i=0; i<8; i=i+1) begin
            @(negedge clk);
            valid_in = 1;
            data_in = samples[i];
        end

        @(negedge clk);
        valid_in = 0;
        data_in = 0;

        repeat (8) @(negedge clk);

        if (count == 8 && errors == 0)
            $display("PASS: All 8 FIR outputs verified.");
        else
            $display("FAIL: checked=%0d errors=%0d", count, errors);

        $finish;
    end

    // Check the output on each rising edge after sequential updates settle.
    always @(negedge clk) begin
        if (!rst && valid_out) begin
            if (count < 8) begin
                #1;
                if (data_out === expected[count]) begin
                    $display("PASS sample %0d: output=%0d",
                             count, data_out);
                end else begin
                    $display("FAIL sample %0d: expected=%0d got=%0d",
                             count, expected[count], data_out);
                    errors = errors + 1;
                end
                count = count + 1;
            end
        end
    end

endmodule
