#include "network.h"

void short_term_memory(float *state, float *attention, uint8_t *hash) {
    // Simplified attention mechanism
    state[0] = attention[0] * state[0];
    compute_neuron_hash(0, state[0], hash);
}

void long_term_memory(float *pattern, uint8_t *hash) {
    // Simplified knowledge graph storage
    compute_neuron_hash(0, pattern[0], hash);
}
