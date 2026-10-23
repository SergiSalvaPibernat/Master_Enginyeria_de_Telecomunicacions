# Lab 2 to 4 - FPGA Graphics and Game Logic

This project groups several FPGA exercises focused on video generation, user interaction, and game logic. The design integrates multiple hardware modules for VGA output, keyboard input, and state-controlled behavior.

## Objective

The main goal of the lab is to explore advanced digital design concepts by building an interactive system on an FPGA. The project combines:

- VGA signal generation
- video memory and display management
- keyboard or keypad input handling
- game logic and control states
- a hardware-based user interface

## Main components

The project includes several VHDL modules and schematic files, such as:

- `VGA_SYNC.VHD` — VGA synchronization logic
- `Video_Memory.vhd` — storage for displayed content
- `main.vhd` — main control logic for game behavior
- `game.vhd` — game state and rule handling
- `keyboard.bdf` and `keypad.vhd` — input acquisition logic
- `TX_RX_BLOCK.bdf`, `TXmodule.bdf`, `RXmodule.bdf` — communication-related building blocks
- `practice1.qpf`, `practice1.qsf`, and generated `.sof` files — Quartus project and programming outputs

## Functional concept

The system is a practical example of an FPGA-based interactive application. It uses the board's input devices and display system to create a visual, state-driven environment. In the project files, the design appears to integrate:

- keyboard interactions
- game rules and states
- VGA visual output
- synchronization and timing control

This makes it a strong example of a complete embedded hardware design, combining logic, memory, and peripheral interfaces.

## Learning focus

This lab series is intended to develop skills in:

- FPGA state-machine design
- video timing and screen generation
- hardware input handling
- memory-based graphical output
- digital system integration and testing

## Tools used

- Quartus Prime
- VHDL and block diagram design
- FPGA simulation tools
- display and board-level verification

## Notes

This project represents a progression from basic communication logic toward a more complex digital system with graphics, interaction, and control flow. It is suitable for understanding how hardware modules are combined into a complete FPGA application.
