# Digital Parking System with FPGA Implementation

## Project Overview

This project implements a digital parking management system using Verilog HDL, designed and tested on FPGA hardware. The system demonstrates practical applications of digital design principles and hardware description languages in real-world scenarios.

## Features

- Real-time parking slot management
- Automated car entry/exit detection
- Visual display interface using seven-segment displays
- Memory-based slot tracking system
- Precise timing control and synchronization
- Complete testbench coverage for verification

## Project Structure

The project consists of the following main modules:

### Core System Modules

- `parking_system_top.v` - Main system controller and top-level module
- `car_enter_exit.v` - Handles car entry and exit detection logic
- `memory.v` - Manages parking slot memory and tracking
- `seven_seg.v` - Controls the seven-segment display interface
- `clk_div.v` - Clock division module for timing control
- `timer.v` - Timing control module
- `flags.v` - System status and flag management

### Testbenches

- `parking_system_top_tb.v` - Top-level system testbench
- `car_enter_exit_tb.v` - Entry/exit detection testbench
- `memory_tb.v` - Memory management testbench
- `seven_segment_display_tb.v` - Display interface testbench
- `clock_divider_tb.v` - Clock division testbench
- `timer_tb.v` - Timing control testbench

## Module Descriptions

### Parking System Top Module

The top-level module that integrates all system components and manages the overall parking system functionality.

### Car Enter/Exit Module

- Handles detection of cars entering and exiting the parking system
- Manages entry/exit signals and timing
- Coordinates with the memory module for slot allocation

### Memory Module

- Manages parking slot memory
- Tracks available and occupied slots
- Handles slot allocation and deallocation

### Seven-Segment Display Module

- Controls the visual display interface
- Shows current parking status
- Displays relevant information to users

### Clock Divider Module

- Provides necessary clock signals for system operation
- Manages timing synchronization

### Timer Module

- Handles timing-related operations
- Manages system timing requirements

### Flags Module

- Manages system status flags
- Handles error conditions and system states

## Implementation Details

### FPGA Implementation

The system has been successfully synthesized and implemented on FPGA hardware, demonstrating real-world functionality with:

- Real-time parking management
- Visual feedback through seven-segment displays
- Automated entry/exit detection
- Memory-based slot tracking

### Verification

Each module includes comprehensive testbenches for:

- Functional verification
- Timing analysis
- System-level testing
- Edge case handling

## Getting Started

### Prerequisites

- Verilog simulator (e.g., ModelSim, Icarus Verilog)
- FPGA development tools
- Basic understanding of digital design concepts

### Installation

1. Clone the repository:

```bash
git clone https://github.com/ArsanyEhab/Verilog-Digital-Parking-System-with-FPGA-Implementation.git
```
