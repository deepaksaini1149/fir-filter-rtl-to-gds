# 4-Tap Pipelined FIR Filter — RTL to GDS

## Project Overview
A pipelined 4-tap FIR filter implemented in synthesizable Verilog and evaluated using the Sky130HD standard-cell flow.

## Project Contents
- `rtl/` — FIR filter RTL
- `tb/` — Testbench sources
- `sim/` — Simulation artifacts
- `synth/` — Synthesis scripts, netlists and reports
- `sta/` — Timing constraints
- `STA_16_CORNERS/` — Exploratory timing reports and comparison graphs
- `FINAL_EVIDENCE/` — Selected project evidence

## Timing Status
The nominal TT run reported setup slack of +7.84 ns, hold slack of +0.43 ns, and TNS of 0.00 ns under the original SDC.

Two exploratory SS library-view runs reported negative setup slack. The 16-view analysis reused the same SPEF file, so it is not a corner-specific signoff analysis. Full multi-corner signoff remains unverified.

## Tools
Verilog, Yosys, OpenROAD, OpenSTA and Sky130HD.

## FIR Filter Block Diagram

![4-Tap Pipelined FIR Filter Block Diagram](FINAL_EVIDENCE/fir_block_diagram.png)

Editable diagram source: [`fir_block_diagram.dot`](fir_block_diagram.dot)

## Static Timing Analysis (STA)

### Setup Slack Comparison
![Setup Slack](STA_16_CORNERS/Setup_Slack_Comparison.png)

### Hold Slack Comparison
![Hold Slack](STA_16_CORNERS/Hold_Slack_Comparison.png)

### WNS Comparison
![WNS](STA_16_CORNERS/WNS_Comparison.png)

### TNS Comparison
![TNS](STA_16_CORNERS/TNS_Comparison.png)

Detailed results: [STA Summary CSV](STA_16_CORNERS/STA_16_Corners_Summary.csv) · [STA Excel Report](STA_16_CORNERS/STA_16_Corners_Report.xlsx)
