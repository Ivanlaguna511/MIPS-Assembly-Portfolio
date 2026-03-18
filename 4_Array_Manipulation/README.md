# Array Manipulation

<div align="center">
  
  ![Assembly](https://img.shields.io/badge/Assembly-MIPS32-blue?style=for-the-badge&logo=assembly)
  ![Memory](https://img.shields.io/badge/Memory-Data_Segment-success?style=for-the-badge)
  ![Academic](https://img.shields.io/badge/Academic_Project-1st_Year-purple?style=for-the-badge)

</div>

> **ABOUT THIS MODULE:**
> This sub-project focuses on direct memory access, dynamic array allocation, and pointer traversal. It demonstrates how to manage contiguous blocks of memory manually without the safety nets of high-level languages.

---

## About the Project

In MIPS Assembly, there are no built-in "Array" or "List" objects; everything is just a contiguous block of bytes in the `.data` segment. This module proves the ability to traverse, read, write, and manipulate these memory blocks dynamically using pointer arithmetic.

The goal of these scripts is to perform complex iterations over memory structures, filtering data based on mathematical properties, and generating new sequences recursively.

### Tech Stack
- **Language:** MIPS32 Assembly
- **Simulator:** MARS 4.5
- **Core Concepts:** Pointer Arithmetic, Memory Allocation (`.space`), Modulo Operations.

### Key Technical Features
* **Dynamic Fibonacci Generator:** Dynamically calculates the Fibonacci sequence ($F_n = F_{n-1} + F_{n-2}$) using shifting memory offsets and stores the resulting 32-bit words consecutively in a pre-allocated `.space` buffer.
* **Array Splitting & Filtering:** Traverses an established array, identifies even and odd numbers using modulo arithmetic (`div` and `mfhi`), and splits them into two entirely separate memory buffers.
* **Reverse Array Copying:** Reads an array sequentially while writing it into a new memory location in reverse order by manipulating two independent memory pointers simultaneously.
* **Arithmetic Mean Calculation:** Accumulates the total sum of an array's elements dynamically during traversal and calculates the average using the `mflo` register.

---

## How to Run Locally

**1. Open the project in MARS:**
Load either `array_split_reverse.asm` or `fibonacci_generator.asm` into the MARS Simulator.

**2. Assemble the Code:**
Press `F3` to assemble the program.

**3. Inspect the Memory (Data Segment):**
Before pressing run, look at the "Data Segment" window at the bottom of the MARS interface. Ensure the memory view is set to `Hexadecimal` or `Decimal`. 
Press `F5` to run the program and watch the empty memory blocks (`0x00000000`) instantly populate with the computed arrays, reversed lists, and Fibonacci sequences.

## Original Authors

- Iván Moro Cienfuegos and Diego Martín García
