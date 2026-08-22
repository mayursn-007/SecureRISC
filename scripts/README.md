# Scripts

Helper scripts for repeatable SecureRISC simulation and verification.

## `run_tests.sh`

Runs the main local regression set using Icarus Verilog:

1. CPU integration test
2. Instruction verifier test
3. Memory Protection Unit test
4. CPU instruction-security attack test
5. CPU memory-protection attack test

### Requirements

- Bash
- Icarus Verilog (`iverilog` and `vvp`)

### Run

From the repository root:

```bash
bash scripts/run_tests.sh
```

The script creates a local `build/` directory for compiled simulation executables.
