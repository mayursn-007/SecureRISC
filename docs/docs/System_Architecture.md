# System Architecture

## Overview

SecureRISC is a lightweight RISC-V processor designed for secure IoT applications. The architecture combines a standard processor pipeline with dedicated hardware security modules.

## High-Level Architecture

```
                +----------------------+
                |   Instruction Memory |
                +----------+-----------+
                           |
                           v
                 +-------------------+
                 | Instruction Fetch |
                 +-------------------+
                           |
                           v
                 +-------------------+
                 | Instruction Decode|
                 +-------------------+
                           |
                           v
                 +-------------------+
                 |   Control Unit    |
                 +-------------------+
                           |
            +--------------+--------------+
            |                             |
            v                             v
      +-----------+                 +-------------+
      | Register  |                 | Security    |
      |   File    |                 | Monitor     |
      +-----------+                 +-------------+
            |                             |
            +--------------+--------------+
                           |
                           v
                     +-----------+
                     |    ALU    |
                     +-----------+
                           |
                           v
                    +-------------+
                    | Data Memory |
                    +-------------+
                           |
                           v
                    +-------------+
                    | Write Back  |
                    +-------------+
```

## Major Modules

- Instruction Fetch Unit
- Instruction Decoder
- Register File
- Arithmetic Logic Unit (ALU)
- Control Unit
- Data Memory
- Security Monitor
- Memory Protection Unit
- UART Interface
