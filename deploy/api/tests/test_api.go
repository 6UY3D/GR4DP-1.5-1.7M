package main

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestPredict(t *testing.T) {
	input := Input{Data: []float32{1.0, 0.0}, Type: "puzzle"}
	body, _ := json.Marshal(input)
	req, err := http.NewRequest("POST", "/predict", bytes.NewBuffer(body))
	if err != nil {
		t.Fatal(err)
	}
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(predictHandler)
	handler.ServeHTTP(rr, req)
	if rr.Code != http.StatusOK {
		t.Errorf("Expected status 200, got %d", rr.Code)
	}
	var resp Response
	if err := json.NewDecoder(rr.Body).Decode(&resp); err != nil {
		t.Fatal(err)
	}
	if len(resp.RootHash) != 64 {
		t.Error("Invalid hash length")
	}
}
