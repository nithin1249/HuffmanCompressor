[![Build Status](https://github.com/nithin1249/Huffman/actions/workflows/build.yml/badge.svg)](https://github.com/nithin1249/Huffman/actions/workflows/build.yml)
# Huffman Compressor: High-Performance Systems Utility

![Language](https://img.shields.io/badge/language-C%2B%2B17-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey)
![Algorithm](https://img.shields.io/badge/algorithm-Greedy-orange.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

A professional-grade, cross-platform systems utility for lossless data compression.

This project implements the **Huffman Coding algorithm** to provide a robust command-line tool for file size reduction. Developed with a "Systems Engineering" mindset, it features bit-level manipulation, custom binary serialization, and a fully automated CI/CD toolchain for global distribution.

**[📥 Download Latest Release](https://github.com/nithin1249/HuffmanCompressor/releases)** ---

## 🚀 Key Features & Performance

* **🧬 Optimal Prefix Coding:** Implements a greedy algorithm using a frequency-sorted binary tree to generate prefix-free codes, ensuring zero ambiguity during decompression.
* **📦 Bit-Packing Engine:** Goes beyond byte-level processing by packing variable-length codes into raw bits. It utilizes custom bit-shifting logic and a `paddingOffset` to maintain data integrity across byte boundaries.
* **🛡️ Lossless Round-Trip:** Guarantees 100% data integrity. The decoding process reconstructs the exact original file through recursive tree traversal based on the stored frequency table.
* **🛠️ Cross-Platform Toolchain:** Includes automated installation scripts for Windows, macOS, and Linux. These scripts configure the system environment for global terminal access—mirroring professional production compilers.
* **⚡ $O(n \log n)$ Efficiency:** Optimized tree construction using a min-priority queue allows for rapid compression of large-scale text data.

---



---

## 🏗 Architectural Pipeline

The utility follows a high-performance three-stage pipeline designed for reliability:

### 1. Frequency Analysis & Tree Construction
* **Mechanism:** Map-Reduce $\rightarrow$ Min-Heap $\rightarrow$ Huffman Tree.
* **Detail:** Scans the source file to build a character frequency map. It then uses a priority queue to iteratively combine the least frequent nodes, constructing an optimal binary tree where more frequent characters occupy shorter paths.

### 2. Binary Serialization (The `.htbl` & `.hdta`)
* **Mechanism:** Metadata + Bit-Packed Payload.
* **Detail:** To ensure the file is portable, the utility generates a **Table File** (`.htbl`) for the frequency dictionary and a **Data File** (`.hdta`) for the compressed bits. This separation allows for modular decompression without needing the original source.

### 3. Bit-Level Reconstruction (Decoding)
* **Mechanism:** Stream-to-Leaf Traversal.
* **Detail:** The decoder reads the binary stream bit-by-bit using bitwise operators (`>>` and `&`). It traverses the reconstructed Huffman tree from the root for every bit until a leaf is reached, perfectly recreating the original byte sequence.

---

## 📦 Installation

### 1. Download
Get the latest `Huffman-OS.zip` from the **[Releases Page](https://github.com/nithin1249/HuffmanCompressor/releases)**.

### 2. Folder Contents:
- `bin/`      : Pre-compiled binaries for Windows, macOS, and Linux.
- `install.sh`: Automated installer for macOS and Linux.
- `install.bat`: Automated installer for Windows.
- `README.txt`: Quick-start technical guide.

### 3. Install

#### Windows
1. Extract the zip file.
2. Right-click `install.bat` and select **Run as Administrator**.
   *(This injects the global `huff` command into your system PATH.)*

#### macOS / Linux
1. Extract the zip file and open your terminal.
2. Run the installer:
   ```bash
   ./install.sh