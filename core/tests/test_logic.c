#include "network.h"

void test_logic_module() {
    float premise[2] = {1.0, 1.0};
    float conclusion[1];
    uint8_t hash[32];
    logic_module(premise, conclusion, hash);
    if (conclusion[0] != 1.0) {
        printf("Logic test failed: expected 1.0, got %f\n", conclusion[0]);
        exit(1);
    }
    printf("Logic test passed\n");
}

int main() {
    test_logic_module();
    return 0;
}
