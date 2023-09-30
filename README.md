<div align="center"><img src="https://i.imgur.com/Ba9CDl0.jpg" alt="IEEE ASUSB logo" width="300" height="300"/></div>

# IEEE-Digital-IC-Design
**This repo is for my IEEE Digital IC Design workshop, an introduction to digital design using verilog, and this is a documentation of my tasks, all folders include pdf with the task's requirements.**


## Lecture 1 - Intro to:
-  Introduction to verilog and it's concurrent behaviour.
-  Syntax, logical operators, arithmetic operators and modules.
-  Gate-level design.
-  Structural design.

## Task 1: 
- **Basic Logic circuits using Gate-level and Structural design**
<hr>

## Lecture 2 - Intro to: 
- Sequential blocks (always, initial), how to use them, what is the senstivity list.
- Behavioural desgin.
- Testbench files
- .do file / scripting.
- Basic logic units using behavioural desing (Mux, decoders, ALU).
- Parameters.

## Task 2:
-  **Create a 3->8 Decoder with enable.**
-  **N-bit comparator with 3 inputs, there are 2 (2*N) Outputs, outputs are decided according to the task pdt attached.**
<hr>

## Lecture 3 - Intro to:
- Sequential circuits.
- Using (posedge, negedge).
- Video Graphics Array standards.
- Basic sequential Logic units (D-Latch, D-Flip Flop, T-Flip Flop, 4-bit register with load, up down load coutner).

## Task 3:
- **Creating a VGA Controller, with 640 * 480 @ 60Hz industry standard, this interfaces with the VGA connector forcing a color to the whole screen pixel array using a parameter.**
<hr>
  
## Lecture 4 - Intro to:
- Universal Asynchronous Receiver / Transmitter (UART) protocol.
- Generating required baud rate using counter and master clock.
- Design of the transmitter module using MUX and Counters.
- Basics of Static Time Analysis (STA).
- FPGA Intellectual Properties (IP) and Phase-Locked Loop (PLL).

## Task 4:
- **Implement the transmitter module discussed in the session.**
- **Design the architecture for a receiver module and implement it with the same baud rate.**
- **Create a top-level UART module that instantiates both Tx and Rx modules making proper communication**
- **Make a testbench for the UART module to prove functionality**
<hr>

## Lecture 5 - Intro to:
- Finite State Machines (FSM).
- Mealy and Moore machines and their corresponding state diagrams.
- Implementation of FSM in Verilog using structured steps:
  - Accurate machine description
  - Creating the State Diagram. (Define both States and Transitions)
  - Synthesize the logic. (Implement State memory, Next State logic, Output Logic)
- Hands-on lab to implement a Sequence Detector that supports overlapping and increments a counter every time the sequence is detected.

## Task 5:
**No Task for session 5**
<hr>

## Lecture 6 (Final Lecture) - Intro to:
- Memory addressing.
- Designing addressing schemes.
- Using the previously built VGA Controller with active memory to pull pixel RGB values from the memory to display live images.
- Rescaling VGA standard resolution without affecting timing to overcome memory limitations.
- RISC-V open-source processor architecture.
- Assembly code and how a RISC-VI interprets it.

## Final Project:
**Implement a basic Single Cycle RISC-V processor using Verilog, which interprets Binary Assembly code according to the RISC-V architecture and performs the corresponding operation on the operands.**
