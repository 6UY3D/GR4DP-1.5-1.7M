package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

// #include "../core/network.h"
// void forward_pass(float*, float*, unsigned char*);
import "C"

type Input struct {
	Data []float32 `json:"data"`
	Type string    `json:"type"`
}

type Response struct {
	Prediction []float32 `json:"prediction"`
	RootHash   string    `json:"root_hash"`
}

func predictHandler(w http.ResponseWriter, r *http.Request) {
	var input Input
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}
	output := make([]float32, C.OUTPUT_DIM)
	rootHash := make([]byte, 32)
	C.forward_pass((*C.float)(&input.Data[0]), (*C.float)(&output[0]), (*C.uchar)(&rootHash[0]))
	resp := Response{
		Prediction: output,
		RootHash:   fmt.Sprintf("%x", rootHash),
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func main() {
	http.HandleFunc("/predict", predictHandler)
	fmt.Println("API server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Println("Server failed:", err)
	}
}
