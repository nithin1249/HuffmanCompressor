Author: Nithin Kondabathini
Version: 1.0

1. Installation
This utility installs a global huff command to your system.

macOS / Linux

Open terminal in the project folder.

Run: chmod +x install.sh && ./install.sh

Windows

Right-click install.bat and select "Run as Administrator".


You can now run huff from any directory in your terminal.
To Compress:
huff -e <your_file.txt>
(Produces .hdta and .htbl files)

To Decompress:
huff -d <file.hdta> <file.htbl>
(Reconstructs the original file as 'filename(decoded).txt')
