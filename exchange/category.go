package exchange

type Category struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
	Demand      int    `json:"demand"`
}

func (c *Category) UpdateDemand(v int) {
	c.Demand = min(max(v, 1), 1000)
}

type ByDemand []*Category

func (a ByDemand) Len() int           { return len(a) }
func (a ByDemand) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByDemand) Less(i, j int) bool { return a[i].Demand < a[j].Demand }
