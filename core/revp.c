#include "network.h"

bool run_revp(float *input, float *output, uint8_t *root_hash, int *explanation_set, int set_size) {
    uint8_t new_hash[32];
    float new_output[OUTPUT_DIM];
    // Scramble non-explanation neurons
    for (int i = 0; i < INPUT_DIM; i++) {
        if (!in_explanation_set(i, explanation_set, set_size)) {
            input[i] = rand_float(); // Simplified
        }
    }
    forward_pass(input, new_output, new_hash);
    if (memcmp(new_hash, root_hash, 32) != 0 && outputs_equal(output, new_output)) {
        // Ablate explanation neurons
        for (int i = 0; i < set_size; i++) {
            float temp_input[INPUT_DIM];
            memcpy(temp_input, input, INPUT_DIM * sizeof(float));
            temp_input[explanation_set[i]] = 0.0;
            forward_pass(temp_input, new_output, new_hash);
            if (outputs_equal(output, new_output)) {
                return false;
            }
        }
        return true;
    }
    return false;
}

static bool in_explanation_set(int idx, int *set, int size) {
    for (int i = 0; i < size; i++) {
        if (set[i] == idx) return true;
    }
    return false;
}

static bool outputs_equal(float *a, float *b) {
    for (int i = 0; i < OUTPUT_DIM; i++) {
        if (fabs(a[i] - b[i]) > 1e-5) return false;
    }
    return true;
}

static float rand_float() {
    return (float)rand() / RAND_MAX;
}
