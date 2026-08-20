\# SecureRISC 🔐

\### Hardware-Assisted Secure RISC-V Processor



SecureRISC is a 32-bit RISC-V-style processor designed with

hardware-assisted security mechanisms for detecting and blocking

unauthorized instruction execution and memory access.



The project combines processor architecture, RTL design, hardware security,

simulation, and verification into a single processor implementation.



\---



\## 🚀 Project Highlights



\- 32-bit RISC-V-style processor

\- ALU and register file

\- Program counter

\- Instruction decoder

\- Immediate generator

\- Instruction memory

\- Data memory

\- Hardware instruction verifier

\- Hardware Memory Protection Unit (MPU)

\- Illegal instruction detection

\- Unauthorized memory access detection

\- Protected memory regions

\- CPU-level security attack simulation

\- Icarus Verilog simulation

\- GTKWave waveform verification

\- Security regression testing



\---



\## 🧠 System Architecture



```text

&#x20;                +--------------------+

&#x20;                |   Program Counter  |

&#x20;                +---------+----------+

&#x20;                          |

&#x20;                          v

&#x20;                +--------------------+

&#x20;                | Instruction Memory |

&#x20;                +---------+----------+

&#x20;                          |

&#x20;                          v

&#x20;                +--------------------+

&#x20;                | Instruction        |

&#x20;                | Verifier           |

&#x20;                +---------+----------+

&#x20;                          |

&#x20;                    Valid / Invalid

&#x20;                          |

&#x20;                          v

&#x20;                +--------------------+

&#x20;                | Instruction Decoder|

&#x20;                +---------+----------+

&#x20;                          |

&#x20;             +------------+------------+

&#x20;             |                         |

&#x20;             v                         v

&#x20;      +-------------+          +---------------+

&#x20;      | Register    |          | Immediate     |

&#x20;      | File        |          | Generator     |

&#x20;      +------+------+          +-------+-------+

&#x20;             |                         |

&#x20;             +------------+------------+

&#x20;                          |

&#x20;                          v

&#x20;                   +-------------+

&#x20;                   |     ALU     |

&#x20;                   +------+------+

&#x20;                          |

&#x20;                          v

&#x20;                +--------------------+

&#x20;                | Memory Protection  |

&#x20;                | Unit (MPU)         |

&#x20;                +---------+----------+

&#x20;                          |

&#x20;                +---------+---------+

&#x20;                |                   |

&#x20;                v                   v

&#x20;         Authorized Access    Unauthorized Access

&#x20;                |                   |

&#x20;                v                   v

&#x20;          +-----------+       +-------------+

&#x20;          | Data      |       | Security    |

&#x20;          | Memory    |       | Violation   |

&#x20;          +-----------+       +-------------+


