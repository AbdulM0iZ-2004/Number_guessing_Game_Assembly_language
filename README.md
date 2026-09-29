# 8086 Assembly - Number Guessing Game

A classic interactive number guessing game written in 16-bit **x86 Assembly (MASM/TASM)** for DOS / DOSBox environments. The player attempts to guess a randomly generated number between 0 and 100 within a limited number of attempts, receiving proximity and directional hints along the way.

---

## Features

- **Pseudo-Random Generation:** Seeds the secret number (0–100) using system clock seconds via DOS Interrupt `INT 21h, AH=2Ch`.
- **Proximity & Directional Hints:**
  - `Too High!` / `Too Low!` directional guidance.
  - Proximity cues: `Very Close!` (within $\le 5$) and `Close!` (within $\le 10$).
- **Multi-Digit I/O:** Supports reading multi-digit decimal inputs and printing multi-digit numbers via standard ASCII conversion routines.
- **Attempt Tracking:** Gives the player 5 attempts per game round.
- **Replayability:** Prompts to play again (`y`/`n`) upon winning or losing without restarting the emulator.

---

## Prerequisites

To assemble and run this program on modern operating systems (Windows 10/11, macOS, Linux), you need:

1. **[DOSBox](https://www.dosbox.com/)** or **DOSBox-X / DOSBox-Staging**
2. **MASM 6.11** (or **TASM 1.4+**) with standard DOS linkers (`LINK.EXE` or `TLINK.EXE`)

---

## Getting Started

### 1. File Setup
Place the assembly file (e.g., `game.asm`) in your DOSBox working directory (for example, `C:\dos\game.asm`).

### 2. Running in DOSBox

Mount your directory and assemble the program:

#### Using MASM:
```dos
Z:\> MOUNT C C:\dos
Z:\> C:
C:\> MASM game.asm;
C:\> LINK game.obj;
C:\> game.exe
