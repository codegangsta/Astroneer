package main

import "github.com/codegangsta/astroneering/exchange"

func companies(e *exchange.Exchange) []*exchange.Company {
	return []*exchange.Company{
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
}
