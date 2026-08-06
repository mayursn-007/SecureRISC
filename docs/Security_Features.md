# Security Features

## Overview

SecureRISC enhances the security of embedded IoT devices by integrating dedicated hardware-based security mechanisms.

## Features

### 1. Instruction Verification
Every instruction is checked before execution to prevent unauthorized code execution.

### 2. Memory Protection Unit (MPU)
Restricts access to protected memory regions and prevents illegal reads or writes.

### 3. Privilege Checking
Supports User Mode and Supervisor Mode to ensure only authorized software can access critical resources.

### 4. Exception Handler
Detects illegal instructions, memory violations, and execution faults, then safely transfers control to an exception routine.

### 5. UART Security
Allows secure communication between the processor and external devices while monitoring invalid transactions.

## Benefits

- Improved embedded security
- Lightweight hardware implementation
- Suitable for FPGA prototyping
- Scalable for future ASIC implementation
