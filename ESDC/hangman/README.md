# Hangman FPGA Project

This project implements a digital hangman game on an FPGA board using VHDL. It was designed as an educational digital design project, combining a keyboard input interface, game logic, LCD output, and state-machine control.

## Overview

The system is built around a finite-state machine that manages the full game flow:

- waiting for the game to start
- receiving the player word
- generating and validating game challenges
- exchanging status with the opponent
- updating lives and game verdicts
- showing the final result on the display

The design targets an FPGA development board (compatible with the Altera/Intel DE2 family) and interfaces with a PS/2 keyboard and LCD display.

## Main features

- Hangman gameplay in hardware
- PS/2 keyboard input for user interaction
- LCD output for game status and word display
- Life counter and game-over conditions
- Finite-state machine-based control logic
- LED indication for win/lose states
- FPGA-ready design in VHDL

## Project structure

The repository contains the VHDL modules and Quartus project files needed to compile and deploy the design.

- `main.vhd` — top-level state machine that starts and orchestrates the game flow
- `game.vhd` — core game logic, including lives, verdict generation, and ready/send signals
- `PS2_keyboard.vhd` — keyboard interface for reading user input
- `LCD_controller.vhd` / `lcd.vhd` — LCD control and display logic
- `user_interface.vhd` — user interface support for the game
- `hangman.qpf` / `hangman.qsf` — Quartus project configuration files
- `hangman.sof` and related generated files — compiled FPGA programming artifacts
- `docs/` — PDF specification and project documentation

## Hardware context

This project is intended for an FPGA evaluation board with:

- a clock source
- a PS/2 keyboard connector
- an LCD display
- LEDs for status indication
- the required I/O resources for game interaction

## How the game works

1. The game waits for a start signal.
2. The user enters a word or challenge code.
3. The game state machine initializes the round.
4. The system receives guesses from the input interface.
5. The game validates the guess and updates the remaining lives.
6. The LCD shows the current status and partial word information.
7. The round ends when the player wins or loses.

## Build and execution

To build the project:

1. Open the Quartus project file `hangman.qpf`.
2. Ensure the required FPGA device is selected in the project settings.
3. Compile the design.
4. Program the generated `.sof` file to the FPGA board.
5. Run the game using the keyboard and display outputs.

## Notes

This project is a practical digital electronics assignment focused on hardware design, sequential logic, and FPGA implementation. It demonstrates how an interactive game can be realized using VHDL and a synchronous state-machine approach.
