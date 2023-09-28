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

func (t *Leader) Apply(r *exchange.Roll, c *exchange.Company, e *exchange.Exchange) {
	if r.Target() == exchange.RollTargetImpact {
		r.WithAdvantage()
	}
}
