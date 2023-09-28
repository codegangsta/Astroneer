package exchange

import (
	"fmt"
	"math"
)

type Company struct {
	Name               string    `json:"name"`
	Symbol             string    `json:"symbol"`
	Price              float64   `json:"price"`
	PriceHistory       []float64 `json:"price_history"`
	ChangePercent      float64   `json:"change_percent"`
	ChangePercentToday float64   `json:"change_percent_today"`
	// TODO: Derive price from history?
	Units float64 `json:"units"`
	// TODO: some sort of serializable ref?
	CategoryID string  `json:"category_id"`
	Traits     []Trait `json:"traits"`

	executionRoll *Roll
	impactRoll    *Roll
	analysisRoll  *Roll
}

func (c *Company) UpdatePrice(changePercent float64) {
	c.Price = c.Price + (c.Price * changePercent / 100)
	c.Price = math.Round(c.Price*100) / 100
	c.PriceHistory = append(c.PriceHistory, c.Price)
	// cap price history at 90
	if len(c.PriceHistory) > 90 {
		c.PriceHistory = c.PriceHistory[len(c.PriceHistory)-90:]
	}

	// calculate change percent between the first and last price in the history
	new, old := c.PriceHistory[len(c.PriceHistory)-1], c.PriceHistory[0]
	c.ChangePercent = math.Round(((new-old)/old)*10000) / 100
	c.ChangePercentToday = changePercent
}

func (c *Company) ApplyTraits(r *Roll, e *Exchange) {
	for _, trait := range c.Traits {
		trait.Apply(r, c, e)
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
