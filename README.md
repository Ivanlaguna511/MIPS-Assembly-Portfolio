# MIPS Assembly Portfolio (Computer Fundamentals & Computer Architecture)

<div align="center">
  
  ![Assembly](https://img.shields.io/badge/Assembly-MIPS32-blue?style=for-the-badge&logo=assembly)
  ![Simulator](https://img.shields.io/badge/Simulator-MARS_4.5-orange?style=for-the-badge)
  ![Low Level](https://img.shields.io/badge/Domain-Low_Level_Programming-success?style=for-the-badge)
  ![Academic](https://img.shields.io/badge/Academic_Project-1st_&_2nd_Year-purple?style=for-the-badge)

</div>

> **PROFESSIONAL REFACTOR:**
> This repository contains the consolidated and refactored source code of my practical assignments for the **Computer Fundamentals** (1st Year, 2nd Quarter) and **Computer Architecture and Organization** (2nd Year, 1st Quarter) courses. 
> The original legacy code has been translated to English, optimized for readability (Clean Code), and modularized to demonstrate advanced low-level programming concepts.

---

## About the Portfolio

This repository serves as a comprehensive showcase of low-level algorithms and memory management techniques written entirely in MIPS32 Assembly. 

Rather than relying on high-level abstractions, these projects require direct interaction with the CPU registers, manual stack frame allocation, dynamic memory traversal, and processor pipeline hazard management. The repository is divided into specialized sub-projects, including cryptographic encoders, complex 2D matrix operations, and mathematical generators.

### Tech Stack
- **Language:** MIPS32 Assembly
- **Environment/Simulator:** MARS (MIPS Assembler and Runtime Simulator) 4.5
- **Paradigm:** Procedural & Low-Level Hardware Programming

### Key Technical Features
* **Stack Memory Management:** Strict adherence to MIPS calling conventions, manually saving and restoring `$ra` and `$s` registers in the stack pointer (`$sp`) to prevent data corruption during nested subroutines.
* **1D to 2D Memory Mapping:** Advanced pointer arithmetic to simulate and manipulate multi-dimensional matrices ($O(N^3)$ complexity) in a linear memory space.
* **Custom I/O Parsers:** Manual implementation of standard C-library functions (like `atoi` and `itoa`) to handle ASCII-to-Integer conversions, negative numbers, and overflow without external libraries.
* **Pipeline Hazard Testing:** Included XML configurations to test the algorithms against different processor pipeline behaviors (forwarding, 2-bit dynamic branch prediction).

---

## How to Run Locally

If you want to run these assembly programs on your machine, you will need a MIPS simulator.

**1. Clone the repository:**
```bash
git clone [https://github.com/YOUR_USERNAME/MIPS-Assembly-Portfolio.git](https://github.com/YOUR_USERNAME/MIPS-Assembly-Portfolio.git)
cd MIPS-Assembly-Portfolio
```

**2. Download the Simulator:**
Download the MARS 4.5 Simulator (Requires Java to run).

**3. Run the application:**
### 1. Open the MARS.jar executable.
### 2. Open any .asm file from the repository (e.g., 1_Encoder_Project/main.asm).
### 3. Press F3 to Assemble the code.
### 4. Press F5 to Execute the program.

**Original Authors**

-Iván Moro Cienfuegos and Diego Martín García
