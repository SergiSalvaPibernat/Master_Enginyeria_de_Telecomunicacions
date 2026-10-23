# Lab 1 - Transmitter/Receiver

This project is the first FPGA laboratory in the ESDC course and focuses on digital communication between a transmitter and a receiver.

## Objective

The goal of the lab is to design and implement a simple serial communication system using hardware description logic. The project demonstrates how data can be transmitted between modules, synchronized with clock signals, and processed by a receiver using a well-defined protocol.

## Main components

The project contains several Quartus design files and block diagrams, including:

- `Transmiter_Receiver.bdf` and `Transmiter_Receiver(1).bdf` — top-level schematic blocks
- `Datagram1.vwf` — simulation waveform for validating the design
- `practice-1.qpf` and `practice-1.qsf` — Quartus project files
- generated output files such as `.sof`, `.pof`, and reports — FPGA programming artifacts

## Functional concept

The lab models a communication link in which:

- a transmitter sends data packets or frames
- a receiver captures and interprets them
- protocol-oriented control signals coordinate the exchange
- timing and synchronization are handled by the FPGA logic

This kind of design is representative of low-level digital communication used in embedded and FPGA systems.

## Tools used

- Quartus Prime / Intel FPGA design environment
- VHDL and schematic-based design entry
- FPGA simulation and timing analysis tools

## Expected learning outcomes

By working on this project, students practice:

- synchronous digital design
- signal routing and protocol handling
- FPGA block interconnection
- debugging through simulation and timing reports
- hardware verification on a DE2-like board

## Notes

This laboratory is a foundational exercise in digital systems and embedded communication. It introduces the principles required for more advanced FPGA projects involving control logic, interfaces, and data exchange.
