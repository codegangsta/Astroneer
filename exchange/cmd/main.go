package main

import (
	"fmt"

	"github.com/codegangsta/astroneering/exchange"
)

func main() {
	roll := exchange.NewRole(exchange.RollTargetExecution, 20).
		WithModifier("Cargo Specialist", 2).
		WithAdvantage().
		WithRequirement(14)
	fmt.Println(roll)
}
