### Encoder Project

<div align="center">
  
  ![Assembly](https://img.shields.io/badge/Assembly-MIPS32-blue?style=for-the-badge&logo=assembly)
  ![Data Parsing](https://img.shields.io/badge/Logic-Data_Parsing-success?style=for-the-badge)
  ![Academic](https://img.shields.io/badge/Academic_Project-2nd_Year-purple?style=for-the-badge)

</div>

> **ABOUT THIS MODULE:**
> This sub-project demonstrates advanced command-line string parsing and cryptography using pure MIPS Assembly. It showcases how to build a fully functional application using modular subroutines and strict stack memory management.

---

## About the Project

The MIPS Command-Line Encoder is a robust application designed to parse user input, validate strict syntactical configurations, and encrypt or decrypt strings based on a dynamic key. 

The main objective of this practice was to handle complex data structures in memory. Instead of passing variables through basic registers, the program builds a `conf_t` configuration object directly in the Stack Memory (`$sp`), passing memory pointers between the Lexical Parser and the Encryption Engine.

### Tech Stack
- **Language:** MIPS32 Assembly
- **Simulator:** MARS 4.5
- **Paradigm:** Modular Low-Level Programming

### Key Technical Features
* **Custom Lexical Parser (`parser.asm`):** Scans raw ASCII input, skips whitespaces, validates the `enc` command prefix, and isolates the target string and cryptographic key.
* **Data Conversion (`atoi` & `itoa`):** Hand-coded ASCII-to-Integer and Integer-to-ASCII algorithms that handle negative Two's Complement conversions and syntax error flags.
* **Stack Frames:** Advanced usage of `$sp` to allocate dynamic buffers (up to 1024 bytes) and safely pass arguments between nested function calls without overwriting temporary registers.

---

## How to Run Locally

**1. Open the project in MARS:**
Load the `main.asm` file into the MARS Simulator. Ensure the option `Settings -> Assemble all files in directory` is **checked** so the simulator links `parser.asm`, `encoder.asm`, and the other utilities automatically.

**2. Assemble and Run:**
Press `F3` to assemble, then `F5` to run.

**3. Pipeline Testing:**
Load the `mars_pipeline_conf.xml` in the MARS Tools to analyze the code's behavior against data hazards and branch predictions.

## Original Authors

- Iván Moro Cienfuegos and Diego Martín García
