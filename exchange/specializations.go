package exchange

type Specialization struct {
	name        string
	description string
	categoryID  string
	value       int
	target      RollTarget
}

func NewSpecialization(name string, description string, target RollTarget, categoryID string, value int) *Specialization {
	return &Specialization{
		name:        name,
		description: description,
		categoryID:  categoryID,
		value:       value,
		target:      target,
	}
}

func (t *Specialization) Name() string {
	return t.name
}

func (t *Specialization) Description() string {
	return t.description
}

func (t *Specialization) Apply(r *Roll, c *Company, e *Exchange) {
	if c.CategoryID == t.categoryID && r.Target() == t.target {
		r.WithModifier(t.name, t.value)
	}
}
