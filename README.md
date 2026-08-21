# SecureRISC 

[![SecureRISC CI](https://github.com/mayursn-007/SecureRISC/actions/workflows/verilog.yml/badge.svg)](https://github.com/mayursn-007/SecureRISC/actions/workflows/verilog.yml)
[![Release](https://img.shields.io/github/v/release/mayursn-007/SecureRISC)](https://github.com/mayursn-007/SecureRISC/releases)
[![License](https://img.shields.io/github/license/mayursn-007/SecureRISC)](https://github.com/mayursn-007/SecureRISC/blob/main/LICENSE)
[![Stars](https://img.shields.io/github/stars/mayursn-007/SecureRISC)](https://github.com/mayursn-007/SecureRISC/stargazers)

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![RISC-V](https://img.shields.io/badge/Architecture-RISC--V-orange)
![Icarus Verilog](https://img.shields.io/badge/Simulation-Icarus%20Verilog-purple)
![GTKWave](https://img.shields.io/badge/Waveform-GTKWave-green)

## A Hardware-Assisted Secure RISC-V-Style Processor

SecureRISC is a 32-bit RISC-V-style processor architecture implemented in
Verilog RTL with hardware-assisted security mechanisms for instruction
verification and memory protection.

The project explores how security policies can be enforced directly at the
hardware level rather than relying only on software-based protection.

---

##  Overview

Modern processors can encounter security threats involving malformed
instructions and unauthorized memory accesses.

SecureRISC addresses these threats using two primary hardware security
mechanisms:

- **Enhanced Instruction Verification**
- **Memory Protection Unit (MPU)**

These mechanisms are integrated into the processor datapath and verified
through dedicated RTL testbenches, security attack simulations, and waveform
analysis.

---

##  Key Features

- 32-bit RISC-V-style processor architecture
- Arithmetic Logic Unit (ALU)
- Register file
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
- Automated GitHub Actions CI

---

#  System Architecture

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
                  | Data Memory |       | Security       |
                  |             |       | Violation      |
                  +-------------+       +----------------+
