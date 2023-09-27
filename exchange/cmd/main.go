package main

import (
	"fmt"

	"github.com/codegangsta/astroneering/exchange"
	"github.com/codegangsta/astroneering/exchange/traits"
)

func main() {
	e := exchange.New("Test Exchange")
	e.Categories = []*exchange.Category{
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
	e.Companies = []*exchange.Company{
		{
			Name:         "JerTech",
			Symbol:       "JERT",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				&traits.Leader{},
			},
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
			Traits: []exchange.Trait{
				&traits.Leader{},
			},
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
		{
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        29.34,
			PriceHistory: []float64{29.34},
			Units:        100000000,
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        19.86,
			PriceHistory: []float64{19.86},
			Units:        100000000,
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        12.34,
			PriceHistory: []float64{12.34},
			Units:        100000000,
		},
	}

	// 90 times
	for i := 1; i <= 90; i++ {
		e.Tick()
		fmt.Printf("\n=== Day %d ===\n", i)
		for _, company := range e.Companies {
			fmt.Println(company)
		}
	}
}
