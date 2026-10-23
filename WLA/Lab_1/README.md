# Lab 1 - Antenna Radiation Patterns and Directivity

This project focuses on the analysis of antenna radiation and directivity using MATLAB. The main script (`Laboratory_1.m`) evaluates several antenna configurations and plots the corresponding E-plane and H-plane patterns.

## Objective

The goal of the lab is to study how different dipole-like antenna geometries affect:

- radiation pattern shape
- directivity
- field distribution
- angular dependence of radiated power

## Main files

- `Laboratory_1.m` – main script for the exercises
- `extrae_corte.m` – extracts radiation cuts from the simulated field pattern
- `polar_xy.m` and `polar_zx.m` – plotting helpers for polar diagrams
- `MATLAB FUNCTIONS-20210926/` – utility functions used by the project
- `EP_P1.pdf` – additional documentation related to the lab

## Topics covered

The script includes several exercises about:

- theoretical antenna directivity
- comparison between different dipole lengths
- E-plane and H-plane radiation plots
- influence of element spacing and phase/current distribution on the pattern
- directivity calculations from numerical integration

## Methodology

The project models the antenna field in spherical coordinates and computes normalized power patterns. These patterns are then used to:

1. extract field cuts at specific planes,
2. plot polar diagrams,
3. estimate directivity using the standard definition:
   D = 4π / (∫ P(θ,φ) sin(θ) dθ dφ)

This allows a direct comparison between different radiating structures and their performance.

## Learning outcomes

By completing this lab, students gain practical experience in:

- antenna field simulation in MATLAB
- directivity estimation
- radiation pattern visualization
- interpretation of antenna geometry and performance

## Notes

This lab is a numerical electromagnetics exercise aimed at understanding how antenna dimensions and current distributions influence radiation behavior.
