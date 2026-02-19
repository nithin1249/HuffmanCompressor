#!/bin/bash

# --- Configuration ---
INSTALL_DIR="$HOME/.huff_toolchain"
SOURCE_DIR="$(cd "$(dirname "$0")"/.. && pwd)" # Assumes script is in scripts/
OS="$(uname -s)"
COMMAND_NAME="huff"

echo "🚀 Installing Huffman Compressor..."

# 1. Detect OS and Pick Binary Name (Matching your CMake output names)
if [ "$OS" = "Darwin" ]; then
    BINARY_NAME="huff_mac"
    echo "   -> Detected macOS"
elif [ "$OS" = "Linux" ]; then
    BINARY_NAME="huff_linux"
    echo "   -> Detected Linux"
else
    echo "❌ Error: Unsupported OS: $OS"
    exit 1
fi

# 2. Check for Binary (Assumes you've already built it or downloaded it into bin/)
if [ ! -f "$SOURCE_DIR/bin/$BINARY_NAME" ]; then
    echo "❌ Error: Could not find '$BINARY_NAME' in bin/ folder."
    echo "   👉 Please run 'cmake --build build' first."
    exit 1
fi

# 3. Setup Install Directory
echo "📂 Setting up toolchain at $INSTALL_DIR..."
rm -rf "$INSTALL_DIR" 2>/dev/null
mkdir -p "$INSTALL_DIR/bin"

# 4. Copy Binary
cp "$SOURCE_DIR/bin/$BINARY_NAME" "$INSTALL_DIR/bin/"
chmod +x "$INSTALL_DIR/bin/$BINARY_NAME"

# 5. Create Wrapper Script
# This allows the user to call 'huff' which then points to the correct OS binary
cat <<EOF > "$INSTALL_DIR/huff_wrapper.sh"
#!/bin/bash
"$INSTALL_DIR/bin/$BINARY_NAME" "\$@"
EOF
chmod +x "$INSTALL_DIR/huff_wrapper.sh"

# 6. Create Global Link (Requires sudo)
echo "🔗 Creating global '$COMMAND_NAME' command..."
if [ -L "/usr/local/bin/$COMMAND_NAME" ]; then
    sudo rm "/usr/local/bin/$COMMAND_NAME"
fi

# Attempt to create the symlink
if sudo ln -s "$INSTALL_DIR/huff_wrapper.sh" "/usr/local/bin/$COMMAND_NAME" 2>/dev/null; then
    echo ""
    echo "🎉 SUCCESS! You can now run '$COMMAND_NAME' from anywhere."
    echo "   Try: $COMMAND_NAME -e yourfile.txt"
else
    echo "⚠️  Permission denied (Sudo failed)."
    echo "✅ Install complete. Please add this to your .zshrc or .bashrc:"
    echo "   export PATH=\"\$PATH:$INSTALL_DIR\""
fi