#include "network.h"

void info_processing_module(float *state, float *operator, uint8_t *hash) {
    // Means-ends analysis placeholder
    state[0] += operator[0];
    compute_neuron_hash(0, state[0], hash);
}
