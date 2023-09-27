package simulator

type Company struct {
	Name         string
	Symbol       string
	Price        float64
	PriceHistory []float64
	Units        uint64
	// TODO: some sort of serializable ref?
	Category string
	Traits   []Trait

	executionRoll *Roll
	impactRoll    *Roll
	analysisRoll  *Roll
}

func (c *Company) UpdatePrice(changePercent float64) {
	c.Price = c.Price * changePercent / 100
	c.PriceHistory = append(c.PriceHistory, c.Price)
}

func (c *Company) GetCategory(e *Exchange) *Category {
	for _, category := range e.Categories {
		if category.Name == c.Category {
			return &category
		}
	}
	return nil
}
