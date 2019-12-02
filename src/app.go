package main

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"fmt"
	"os"
	"strconv"
)


type Response struct {
	// Response is the response type
	Status string `json:"message,omitempty"`
}

func Get(w http.ResponseWriter, _ *http.Request) {
	// Get method always returns "hello world"
	b := Response{Status: "hello world"}
	json.NewEncoder(w).Encode(b)
}

func ValidatePortNumber(p string) int {
	// throw an 
	port, err := strconv.Atoi(p);
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
	return port
}

func main() {
	// Get port number, check if valid
	port := fmt.Sprintf(":%v",ValidatePortNumber(os.Args[1]))

	// start the server
	router := mux.NewRouter()
	router.HandleFunc("/", Get).Methods("GET")
	log.Fatal(http.ListenAndServe(port, router))
}