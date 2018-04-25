package main

import (
	"fmt"
	"time"
)

// MAP-REDUCE

// Parte MAP
func sliceBread() {
	fmt.Println("Slice the bun horizontally")
}

func spreadMayo() {
	fmt.Println("Spread mayonaise on the bread")
}

func grill() {
	fmt.Println("Grill the patty")
}

func cutTomatoes() {
	fmt.Println("Slice the tomatoes")
}

// Parte REDUCE
func putItTogether() {
	fmt.Println("Add the tomato to the lower slice of the bun")
	fmt.Println("Put the patty on top of the tomato")
	fmt.Println("Put the remaining bun on top")
}

func makeABigMac() {

	go sliceBread()
	go spreadMayo()
	go grill()
	go cutTomatoes()
	go putItTogether()
}
func main() {

	makeABigMac()
	time.Sleep(1 * time.Second)
}
