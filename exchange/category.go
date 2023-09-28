package exchange

type Category struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
	Demand      int    `json:"demand"`
}

func (c *Category) UpdateDemand(v int) {
	c.Demand = min(max(v, 1), 20)
}
