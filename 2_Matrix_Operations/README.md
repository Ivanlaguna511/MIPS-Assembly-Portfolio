# Matrix Operations

<div align="center">
  
  ![Assembly](https://img.shields.io/badge/Assembly-MIPS32-blue?style=for-the-badge&logo=assembly)
  ![Algorithm](https://img.shields.io/badge/Algorithm-O(N³)-success?style=for-the-badge)
  ![Academic](https://img.shields.io/badge/Academic_Project-1st_Year-purple?style=for-the-badge)

</div>

> **ABOUT THIS MODULE:**
> This sub-project focuses strictly on high-performance mathematical logic and complex memory addressing. It proves the ability to translate high-level nested loops and 2D arrays into linear machine code.

---

## About the Project

Implementing multi-dimensional arrays in Assembly is inherently complex because RAM is strictly one-dimensional. This project tackles that challenge by manually calculating memory offsets to perform advanced matrix mathematics.

The primary objective was to implement Matrix Multiplication and Matrix Transposition by translating mathematical formulas into optimized register operations, minimizing memory loads/stores to maximize CPU efficiency.

### Tech Stack
- **Language:** MIPS32 Assembly
- **Simulator:** MARS 4.5
- **Mathematical Focus:** Linear Algebra & Memory Offsets

### Key Technical Features
* **O(N³) Matrix Multiplication:** Multiplies an $N \times K$ matrix by a $K \times M$ matrix. Uses three nested loops (`i`, `j`, `k`) entirely managed within temporary registers (`$t0` - `$t9`).
* **Advanced Pointer Arithmetic:** Calculates exact memory addresses on the fly using the Row-Major Order formula: `Base_Address + (Row * Total_Columns + Column) * 4 bytes`.
* **Matrix Transposition:** Efficiently swaps rows and columns reading from a source array and writing directly to a destination array buffer in memory.

---

## How to Run Locally

**1. Open the project in MARS:**
Load either `matrix_multiplication.asm` or `matrix_transpose.asm` into the MARS Simulator.

**2. Assemble and Run:**
Press `F3` to assemble, then `F5` to run. 

**3. View Memory:**
To see the resulting matrices, open the "Data Segment" window in MARS at the bottom of the screen and observe the values changing in the `.data` space upon execution.

## Original Authors

- Iván Moro Cienfuegos and Diego Martín García
