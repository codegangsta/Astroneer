package traits

import "github.com/codegangsta/astroneering/exchange"

type Leader struct {
}

func (t *Leader) Name() string {
	return "Leader"
}

func (t *Leader) Description() string {
	return "This company's leader is a visionary. +X to impact rolls."
}

func (t *Leader) Apply(r *exchange.Roll) {
	if r.Target() == exchange.RollTargetImpact {
		// r.WithModifier("Leader", 1)
		r.WithAdvantage()
	}
}

type Leader2 struct {
}

func (t *Leader2) Name() string {
	return "Leader2"
}

func (t *Leader2) Description() string {
	return "This company's leader is a visionary. +X to impact rolls."
}

func (t *Leader2) Apply(r *exchange.Roll) {
	if r.Target() == exchange.RollTargetImpact {
		r.WithModifier("Leader", 3)
	}
}
