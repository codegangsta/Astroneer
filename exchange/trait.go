package exchange

type Trait interface {
	Name() string
	Description() string
	Apply(*Roll, *Company, *Exchange)
}
