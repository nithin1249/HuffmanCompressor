cmake_minimum_required(VERSION 3.10)

# Match the C++ standard used in your Jack Compiler
project(Huffman VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Source files
set(SOURCES
        src/main.cpp
        src/Huffman.cpp
        src/Node.cpp
)


# Create the executable
add_executable(huff ${SOURCES})

# Explicitly include src for header discovery
target_include_directories(huff PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)

# --- OS Specific Output Naming ---
if(APPLE)
    # On Mac -> produces "huff_mac"
    set_target_properties(huff PROPERTIES OUTPUT_NAME "huff_mac")
elseif(WIN32)
    # On Windows -> produces "huff_win.exe"
    set_target_properties(huff PROPERTIES OUTPUT_NAME "huff_win")
elseif(UNIX)
    # On Linux -> produces "huff_linux"
    set_target_properties(huff PROPERTIES OUTPUT_NAME "huff_linux")
endif()

install(TARGETS huff DESTINATION bin)

if(WIN32)
    # Windows-specific installer script
    install(FILES scripts/install.bat DESTINATION .)
elseif(UNIX)
    # Mac & Linux (UNIX) installer script
    install(PROGRAMS scripts/install.sh DESTINATION .)
endif()

# README for the release package
install(FILES docs/RELEASE_README.txt
        DESTINATION .
        RENAME README.txt)
