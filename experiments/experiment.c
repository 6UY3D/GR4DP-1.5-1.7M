#include "experiment.h"
#include "network.h"

void run_experiment(float *weights, float *test_inputs, float *test_targets, int n_samples) {
    int correct = 0;
    for (int i = 0; i < n_samples; i++) {
        float output[OUTPUT_DIM];
        uint8_t root_hash[32];
        forward_pass(test_inputs + i * INPUT_DIM, weights, output, root_hash);
        if (is_correct(output, test_targets + i * OUTPUT_DIM)) {
            correct++;
        }
        int explanation_set[10]; // Placeholder
        run_revp(test_inputs + i * INPUT_DIM, output, root_hash, explanation_set, 10);
        log_results(correct, root_hash);
    }
    printf("Accuracy: %f\n", (float)correct / n_samples);
}

static bool is_correct(float *output, float *target) {
    // Placeholder: Compare outputs
    return true;
}

static void log_results(int correct, uint8_t *hash) {
    // Placeholder: Log to file
}
