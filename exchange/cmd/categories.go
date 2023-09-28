package main

import "github.com/codegangsta/astroneering/exchange"

func categories() []*exchange.Category {
	return []*exchange.Category{
		{
			ID:     "habs_and_cockpits",
			Name:   "Habs and Cockpits",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
		{
			ID:     "weapons",
			Name:   "Weapons",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
		{
			ID:     "engines",
			Name:   "Engines",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
		{
			ID:     "reactors",
			Name:   "Reactors",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
		{
			ID:     "grav_drives",
			Name:   "Grav Drives",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
		{
			ID:     "cargo",
			Name:   "Cargo",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
		{
			ID:     "shields",
			Name:   "Shields",
			Demand: exchange.NewRoll(exchange.RollTargetNone, 20).Modified(),
		},
	}
}
