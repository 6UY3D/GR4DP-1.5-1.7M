#ifndef NETWORK_H
#define NETWORK_H

#include <stdint.h>
#include <openssl/sha.h>

#define INPUT_DIM 3072      // 32x32x3 for images, adjustable
#define OUTPUT_DIM 10       // 10 classes for images, adjustable
#define MAX_EXPERTS 6
#define MAX_LAYERS 3
#define MAX_NEURONS 256

typedef struct {
    float *weights;
    float *activations;
    uint8_t hash[32];
} Neuron;

typedef struct {
    Neuron *neurons;
    int num_neurons;
    uint8_t layer_hash[32];
} Layer;

typedef struct {
    Layer layers[MAX_LAYERS];
    int num_experts;
    float *gating_weights;
} Network;

void forward_pass(float *input, float *output, uint8_t *root_hash);
void backward_pass(float *input, float *output, float *weights);
void compute_loss(float *output, float *target, float *loss);
void update_weights(float *weights, float loss);

#endif
