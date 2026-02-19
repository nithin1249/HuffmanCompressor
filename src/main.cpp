// ---------- INCLUDES ------------------------------------------------------------------
#include <iostream>
#include <fstream>
#include <cstring>
#include "Huffman.h"

// ---------- MAIN ----------------------------------------------------------------------
int main(const int argc, char* argv[]) {
    std::ifstream file;
    Huffman h;

    try {
        // Ensure the user provided the correct number of arguments
        if (argc != 3 && argc != 4) throw "Invalid number of arguments";

        // ENCODING MODE: -e <filename>
        if (std::strcmp(argv[1], "-e") == 0) {
            if (argc != 3) throw "Invalid number of arguments for encoding";

            // Verify file exists before starting
            file.open(argv[2]);
            if (!file) throw "Could not open file for encoding";
            file.close();

            std::cout << "Encoding file: " << argv[2] << "..." << std::endl;
            h.encode(argv[2]);
            std::cout << "Encoding complete." << std::endl;
        }

        // DECODING MODE: -d <datafile> <tablefile>
        else if (std::strcmp(argv[1], "-d") == 0) {
            if (argc != 4) throw "Invalid number of arguments for decoding";

            // Verify both necessary files exist
            file.open(argv[2]);
            if (!file) throw "Could not open compressed data file (.hdta)";
            file.close();

            file.open(argv[3]);
            if (!file) throw "Could not open frequency table file (.htbl)";
            file.close();

            std::cout << "Decoding files..." << std::endl;
            h.decode(argv[2], argv[3]);
            std::cout << "Decoding complete. Original file reconstructed." << std::endl;
        }
        else {
            throw "Incorrect arguments. Use -e for encoding or -d for decoding";
        }
    }
    catch (const char* err) {
        if (file.is_open()) file.close();
        std::cout << "\nError: " << err << "\n";
        std::cout << "\nUsage Guide:\n";
        std::cout << "\t- Encoding: ./huffman -e <filename>\n";
        std::cout << "\t- Decoding: ./huffman -d <file.hdta> <file.htbl>\n" << std::endl;
    }

    return 0;
}