package exchange

type Category struct {
	ID          string
	Name        string
	Description string
	Demand      int
}

func (c *Category) UpdateDemand(v int) {
	c.Demand = min(max(v, 1), 20)
}
