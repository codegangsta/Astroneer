package main

import (
	"fmt"

	"github.com/codegangsta/astroneering/simulator"
)

func main() {
	roll := simulator.NewRole(simulator.RollTargetExecution, 20).
		WithModifier("Cargo Specialist", 2).
		WithAdvantage().
		WithRequirement(14)
	fmt.Println(roll)
}
