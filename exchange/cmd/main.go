package main

import (
	"fmt"

	"github.com/codegangsta/astroneering/exchange"
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
			Name:         "Stroud Eklund",
			Symbol:       "STEK",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("habs_and_cockpits", 3),
			},
		},
		{
			Name:         "HopeTech",
			Symbol:       "HPTC",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("cargo", 1),
				e.Specialization("engines", 1),
				e.Specialization("reactors", 1),
			},
		},
		{
			Name:         "Amun Dunn",
			Symbol:       "AMDN",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("reactors", 3),
			},
		},
		{
			Name:         "Ballistic Solutions Inc.",
			Symbol:       "BSI",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("weapons", 3),
			},
		},
		{
			Name:         "Deep Core",
			Symbol:       "DEEP",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("cargo", 1),
				e.Specialization("grav_drives", 2),
			},
		},
		{
			Name:         "Deimos",
			Symbol:       "DEIMOS",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("shields", 3),
			},
		},
		{
			Name:         "Dogstar",
			Symbol:       "DOGSTR",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("shields", 1),
				e.Specialization("cargo", 1),
				e.Specialization("reactors", 1),
			},
		},
		{
			Name:         "Horizon Defense",
			Symbol:       "HORIZN",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("weapons", 3),
			},
		},
		{
			Name:         "Light Scythe",
			Symbol:       "SCYTHE",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("weapons", 3),
			},
		},
		{
			Name:         "Nautilus",
			Symbol:       "NAUTLS",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("shields", 3),
			},
		},
		{
			Name:         "Panoptes",
			Symbol:       "PANOPTS",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("engines", 3),
			},
		},
		{
			Name:         "Nova Galactic",
			Symbol:       "NOVA",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("habs_and_cockpits", 3),
			},
		},
		{
			Name:         "Protectorate Systems",
			Symbol:       "PROSYS",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("cargo", 3),
			},
		},
		{
			Name:         "Reladyne",
			Symbol:       "RLDYNE",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("engines", 2),
				e.Specialization("grav_drives", 1),
			},
		},
		{
			Name:         "Sextant Shield Systems",
			Symbol:       "SXTNT",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("shields", 3),
			},
		},
		{
			Name:         "Shinigami",
			Symbol:       "SHINI",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("weapons", 3),
			},
		},
		{
			Name:         "Slayton Aerospace",
			Symbol:       "SLAYTN",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("grav_drives", 3),
			},
		},
		{
			Name:         "Taiyo Astroneering",
			Symbol:       "TAIYO",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("habs_and_cockpits", 3),
			},
		},
		{
			Name:         "Xiang",
			Symbol:       "XIANG",
			Price:        20.00,
			PriceHistory: []float64{20.00},
			Units:        100000000,
			Traits: []exchange.Trait{
				e.Specialization("reactors", 3),
			},
		},
	}
	/*
			List of companies:

		Stroud Eklund – Specialises in structures and aesthetics, both inside and outside
		HopeTech – A great all-round manufacturer, with solid parts in every category
			Amun Dunn – Specialises in reactors
		Ballistic Solutions Inc. – Specialises in Ballistic weapons and fuel tanks
		Deep Core – Specialises in cargo holds and grav drives
		Deimos – Specialises in creating ships parts with highly defensive ship parts
		Dogstar – Specialises in shields, cargo holds, and reactors
		Horizon Defense – Specialises in Ballistic and Energy weapons
		Light Scythe – Specialises in Energy weapons
		Nautilus – Specialises in shields and fuel tanks
		Panoptes – Specialises in engines
		Nova Galactic – Specialises in habs, landing gear, and structures
		Protectorate Systems – Specialises in cargo holds
		Reladyne – Specialises in engines and grav drives
		Sextant Shield Systems – Specialises in shielded cargo holds
		Shinigami – Specialises in Energy weapons
		Slayton Aerospace – Specialises in grav drives
		Taiyo Astroneering – Specialises in cockpits and habs
		Xiang – Specialises in reactors
	*/

	// 90 times
	for i := 1; i <= 900; i++ {
		e.Tick()
		fmt.Printf("\n=== Day %d ===\n", i)
		for _, company := range e.Companies {
			fmt.Println(company)
		}
	}
}
