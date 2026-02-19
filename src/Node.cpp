#include <iostream>
#include "Node.h"

// ---------- NODE (LEAF) CONSTRUCTOR ---------------------------------------------------
Node::Node(char d, int s, NODE_TYPE t) {
    type = t;
    data = d;
    frequency = s;
    left = right = NULL;
}

// ---------- NODE (BIND) CONSTRUCTOR ---------------------------------------------------
Node::Node(Node* l, Node* r, NODE_TYPE t) {
    type = t;
    data = 0;
    frequency = l->getFrequency() + r->getFrequency();
    left = l;
    right = r;
}

// ---------- NODE DECONSTRUCTOR --------------------------------------------------------
Node::~Node() {
    delete left;
    delete right;
}

// ---------- GET NODE FREQUENCY --------------------------------------------------------
int Node::getFrequency() {
    return frequency;
}

// ---------- FILL NODE WITH DATA -------------------------------------------------------
void Node::fill(std::map<char, std::pair<int, int>>& enc, int bits, int nbits) {
    if (type == LEAF) {
        enc[data] = std::pair<int, int>(bits, nbits);
    }
    else if (type == BIND) {
        nbits += 1;
        bits <<= 1;
        left->fill(enc, bits, nbits);
        bits += 1;
        right->fill(enc, bits, nbits);
        bits >>= 1;
        nbits--;
    }
}

void Node::insert(int bits, int nbits, char d) {
    if (nbits == 0) {
        this->data = d;
        this->type = LEAF;
        return;
    }

    this->type = BIND;
    // Extract the most significant bit of the code
    int bit = (bits >> (nbits - 1)) & 1;

    if (bit == 0) {
        if (!left) left = new Node(0, 0, BIND);
        left->insert(bits, nbits - 1, d);
    } else {
        if (!right) right = new Node(0, 0, BIND);
        right->insert(bits, nbits - 1, d);
    }
}