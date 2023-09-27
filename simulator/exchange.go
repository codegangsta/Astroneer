package simulator

import "math/rand"

var phases = []func(*Exchange) error{
	(*Exchange).forecastPhase,
	(*Exchange).strategyPhase,
	(*Exchange).executionPhase,
	(*Exchange).impactPhase,
	(*Exchange).analysisPhase,
}

type Exchange struct {
	Name string

	Companies  []Company
	Categories []Category
}

func (e *Exchange) tick() error {
	for _, phase := range phases {
		if err := phase(e); err != nil {
			return err
		}
	}
	return nil
}

func (e *Exchange) forecastPhase() error {
	// each company picks a random category
	for _, company := range e.Companies {
		company.Category = e.Categories[rand.Intn(len(e.Categories))].Name
	}

	return nil
}

func (e *Exchange) strategyPhase() error {
	// TODO: implement
	// Each company picks a random strategy
	return nil
}

func (e *Exchange) executionPhase() error {
	return nil
}

func (e *Exchange) impactPhase() error {
	return nil
}

func (e *Exchange) analysisPhase() error {
	return nil
}
