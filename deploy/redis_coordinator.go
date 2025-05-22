package main

import (
	"context"
	"fmt"
	"github.com/go-redis/redis/v8"
)

func coordinateExperts(expertIDs []int, inputHash string) error {
	client := redis.NewClient(&redis.Options{Addr: "localhost:6379"})
	defer client.Close()
	for _, id := range expertIDs {
		err := client.Publish(context.Background(), "expert_queue", fmt.Sprintf("%d:%s", id, inputHash)).Err()
		if err != nil {
			return err
		}
	}
	return nil
}

func main() {
	// Example usage
	coordinateExperts([]int{1, 2, 3}, "sample-hash")
}
