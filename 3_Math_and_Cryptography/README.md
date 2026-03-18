# Math & Cryptography

<div align="center">
  
  ![Assembly](https://img.shields.io/badge/Assembly-MIPS32-blue?style=for-the-badge&logo=assembly)
  ![Cryptography](https://img.shields.io/badge/Logic-Cryptography-success?style=for-the-badge)
  ![Academic](https://img.shields.io/badge/Academic_Project-1st_Year-purple?style=for-the-badge)

</div>

> **ABOUT THIS MODULE:**
> This sub-project demonstrates the implementation of pure mathematical algorithms and classic cryptographic ciphers at the instruction level, showcasing control over ALU operations and ASCII boundaries.

---

## About the Project

Implementing mathematical sequences and cryptography in Assembly requires a deep understanding of how data is represented in hardware (ASCII vs. Integers) and how the Arithmetic Logic Unit (ALU) handles division and remainders.

The main objective of these scripts is to manipulate data securely, ensuring that operations like character shifting do not overflow into non-printable ASCII characters, and that mathematical divisions are accurately tracked.

### Tech Stack
- **Language:** MIPS32 Assembly
- **Simulator:** MARS 4.5
- **Algorithmic Focus:** Prime Factorization & Caesar Cipher

### Key Technical Features
* **Prime Factorization:** Decomposes a given integer into its prime factors using recursive division. It leverages the `div` instruction and evaluates the `HI` and `LO` registers (`mfhi`, `mflo`) to check for exact remainders and update quotients dynamically.
* **Caesar Cipher Cryptography:** Shifts ASCII characters by a user-defined key. It includes strict boundary checking to ensure shifted characters seamlessly wrap around within the printable ASCII range (32-126) and actively filters out system control characters like line-feeds (`\n`).
* **Input Sanitization:** Custom subroutines to traverse user-input strings and strip unwanted terminator bytes before processing.

---

## How to Run Locally

**1. Open the project in MARS:**
Load either `prime_factorization.asm` or `caesar_cipher.asm` into the MARS Simulator.

**2. Assemble and Run:**
Press `F3` to assemble the code, then `F5` to execute it.

**3. Interact with the I/O Console:**
The programs will prompt you for input (a number to factorize, or a string and a key to encrypt) via the "Run I/O" terminal at the bottom of the MARS interface.

## Original Authors

- Iván Moro Cienfuegos and Diego Martín García
