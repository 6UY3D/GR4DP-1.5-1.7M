#include "network.h"

void test_merkle_tree() {
    float activations[4] = {1.0, 2.0, 3.0, 4.0};
    uint8_t root_hash[32];
    build_merkle_tree(activations, 4, root_hash);
    uint8_t expected[32] = {0}; // Placeholder
    if (memcmp(root_hash, expected, 32) != 0) {
        printf("Merkle test failed\n");
        exit(1);
    }
    printf("Merkle test passed\n");
}

int main() {
    test_merkle_tree();
    return 0;
}
