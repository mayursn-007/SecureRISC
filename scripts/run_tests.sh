#!/usr/bin/env bash
set -euo pipefail

# SecureRISC local regression helper
# Requires: Icarus Verilog (iverilog) and vvp

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

BUILD_DIR="build"
mkdir -p "$BUILD_DIR"

RTL=(
  rtl/secure_risc_core.v
  rtl/alu_v2.v
  rtl/register_file.v
  rtl/program_counter.v
  rtl/instruction_decoder.v
  rtl/immediate_generator.v
  rtl/instruction_memory.v
  rtl/data_memory.v
  rtl/instruction_verifier.v
  rtl/memory_protection_unit.v
)

echo "=============================================="
echo " SecureRISC Local Verification"
echo "=============================================="

echo

echo "[1/4] CPU integration test"
iverilog -g2012 -o "$BUILD_DIR/cpu_sim" "${RTL[@]}" testbench/secure_risc_core_tb.v
vvp "$BUILD_DIR/cpu_sim"

echo
echo "[2/4] Instruction verifier test"
iverilog -g2012 -o "$BUILD_DIR/verifier_sim" \
  rtl/instruction_verifier.v \
  testbench/instruction_verifier_tb.v
vvp "$BUILD_DIR/verifier_sim"

echo
echo "[3/4] MPU test"
iverilog -g2012 -o "$BUILD_DIR/mpu_sim" \
  rtl/memory_protection_unit.v \
  testbench/memory_protection_unit_tb.v
vvp "$BUILD_DIR/mpu_sim"

echo
echo "[4/4] Security attack tests"
iverilog -g2012 -o "$BUILD_DIR/security_sim" "${RTL[@]}" testbench/secure_risc_security_tb.v
vvp "$BUILD_DIR/security_sim"

iverilog -g2012 -o "$BUILD_DIR/memory_attack_sim" "${RTL[@]}" testbench/memory_attack_tb.v
vvp "$BUILD_DIR/memory_attack_sim"

echo
echo "=============================================="
echo " SecureRISC verification run completed"
echo "=============================================="
echo "Generated simulation files are kept in the testbench working directory"
echo "when produced by the corresponding testbenches."
