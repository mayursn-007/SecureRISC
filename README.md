# SecureRISC 🔐

[![SecureRISC CI](https://github.com/mayursn-007/SecureRISC/actions/workflows/verilog.yml/badge.svg)](https://github.com/mayursn-007/SecureRISC/actions/workflows/verilog.yml)

## A Hardware-Assisted Secure RISC-V-Style Processor

SecureRISC is a 32-bit RISC-V-style processor designed with
hardware-assisted security mechanisms for detecting and blocking
unauthorized instruction execution and memory access.

The project combines processor architecture, RTL design, hardware security,
simulation, and verification into a single processor implementation.

---

## 🚀 Overview

Modern processors can be exposed to attacks involving malformed
instructions and unauthorized memory accesses.

SecureRISC explores how these threats can be addressed directly at the
hardware level.

The processor incorporates two primary security mechanisms:

1. **Enhanced Instruction Verification**
2. **Hardware Memory Protection Unit (MPU)**

These mechanisms are integrated into the CPU datapath and verified through
simulation and deliberate security attack scenarios.

---

## ✨ Key Features

- 32-bit RISC-V-style processor architecture
- Arithmetic Logic Unit (ALU)
- 32 × 32-bit register file
- Program counter
- Instruction decoder
- Immediate generator
- Instruction memory
- Data memory
- Enhanced instruction verification
- Hardware Memory Protection Unit (MPU)
- Illegal instruction detection
- Instruction encoding validation
- Protected memory regions
- Unauthorized memory access detection
- Unauthorized memory access blocking
- CPU-level security attack simulation
- RTL simulation using Icarus Verilog
- Waveform analysis using GTKWave
- Automated security regression testing

---

# 🧩 System Architecture

```text
                         +----------------------+
                         |   Program Counter    |
                         +----------+-----------+
                                    |
                                    v
                         +----------------------+
                         |  Instruction Memory  |
                         +----------+-----------+
                                    |
                                    v
                         +----------------------+
                         | Instruction Verifier |
                         |    Security Check    |
                         +----------+-----------+
                                    |
                         Valid Instruction
                                    |
                                    v
                         +----------------------+
                         | Instruction Decoder  |
                         +----------+-----------+
                                    |
                    +---------------+---------------+
                    |                               |
                    v                               v
             +-------------+                +---------------+
             | Register    |                | Immediate     |
             | File        |                | Generator     |
             +------+------+                +-------+-------+
                    |                               |
                    +---------------+---------------+
                                    |
                                    v
                              +-----------+
                              |    ALU    |
                              +-----+-----+
                                    |
                                    v
                         +----------------------+
                         | Memory Protection    |
                         | Unit (MPU)           |
                         +----------+-----------+
                                    |
                         +----------+----------+
                         |                     |
                         v                     v
                  Authorized Access      Unauthorized Access
                         |                     |
                         v                     v
                  +-------------+       +----------------+
                  | Data Memory  |       | Security       |
                  |             |       | Violation      |
                  +-------------+       +----------------+


