package exchange

import (
	"fmt"
	"math"
)

type Company struct {
	Name          string
	Symbol        string
	Price         float64
	PriceHistory  []float64
	ChangePercent float64
	// TODO: Derive price from history?
	Units float64
	// TODO: some sort of serializable ref?
	CategoryID string
	Traits     []Trait

	executionRoll *Roll
	impactRoll    *Roll
	analysisRoll  *Roll
}

func (c *Company) UpdatePrice(changePercent float64) {
	c.ChangePercent = changePercent
	c.Price = c.Price + (c.Price * changePercent / 100)
	c.Price = math.Round(c.Price*100) / 100
	c.PriceHistory = append(c.PriceHistory, c.Price)
}

func (c *Company) ApplyTraits(r *Roll) {
	for _, trait := range c.Traits {
		trait.Apply(r)
	}
}

func (c *Company) Category(e *Exchange) *Category {
	for _, category := range e.Categories {
		if category.ID == c.CategoryID {
			return category
		}
	}
	return nil
}

func (c *Company) String() string {
	result := fmt.Sprintf("%s $%.2f (%.2f%%)", c.Symbol, c.Price, c.ChangePercent)
	// result += "\n\t" + c.executionRoll.String()
	// result += "\n\t" + c.impactRoll.String()
	// result += "\n\t" + c.analysisRoll.String()
	return result
}
