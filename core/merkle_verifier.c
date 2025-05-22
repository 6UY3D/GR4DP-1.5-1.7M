#include "network.h"

void merkle_verifier(float *activations, int n, uint8_t *root_hash) {
    build_merkle_tree(activations, n, root_hash);
}
