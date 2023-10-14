package main

import "github.com/codegangsta/astroneering/exchange"

const CategoryScale = 1000

func categories() []*exchange.Category {
	return []*exchange.Category{
		{
			ID:     "habs_and_cockpits",
			Name:   "Habs and Cockpits",
			Demand: 500,
		},
		{
			ID:     "weapons",
			Name:   "Weapons",
			Demand: 500,
		},
		{
			ID:     "engines",
			Name:   "Engines",
			Demand: 500,
		},
		{
			ID:     "reactors",
			Name:   "Reactors",
			Demand: 500,
		},
		{
			ID:     "grav_drives",
			Name:   "Grav Drives",
			Demand: 500,
		},
		{
			ID:     "cargo",
			Name:   "Cargo",
			Demand: 500,
		},
		{
			ID:     "shields",
			Name:   "Shields",
			Demand: 500,
		},
	}
}
