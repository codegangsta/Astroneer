package exchange

import (
	"math"
	"math/rand"
)

// Game constants
const (
	// How much successful price calculations are multiplied by
	SUCCESS_MULTIPLIER = 1
	// How much failed price calculations are multiplied by
	FAILURE_MULTIPLIER = -0.85
	// How much demand is multiplied by when calculating price changes
	DEMAND_MULTIPLIER = 0.33
)

var phases = []func(*Exchange) error{
	(*Exchange).forecastPhase,
	(*Exchange).strategyPhase,
	(*Exchange).executionPhase,
	(*Exchange).impactPhase,
	(*Exchange).analysisPhase,
}

type Exchange struct {
	Name string

	Companies  []*Company
	Categories []*Category
}

func New(name string) *Exchange {
	return &Exchange{
		Name: name,
	}
}

func (e *Exchange) Tick() error {
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
		company.CategoryID = e.Categories[rand.Intn(len(e.Categories))].ID
	}

	return nil
}

func (e *Exchange) strategyPhase() error {
	// TODO: implement
	// Each company picks a random strategy
	return nil
}

func (e *Exchange) executionPhase() error {
	for _, company := range e.Companies {
		demand := company.Category(e).Demand
		factor := math.Round(float64(demand) / 2)
		if demand <= 10 {
			factor = factor * -1
		}
		factor = max(factor, 1)

		requirement := 10 + factor

		company.executionRoll = NewRoll(RollTargetExecution, 20).
			WithRequirement(int(requirement))
	}

	for _, company := range e.Companies {
		company.ApplyTraits(company.executionRoll)
	}
	return nil
}

func (e *Exchange) impactPhase() error {
	for _, company := range e.Companies {
		company.impactRoll = NewRoll(RollTargetImpact, 20)
	}

	for _, company := range e.Companies {
		company.ApplyTraits(company.impactRoll)
	}
	return nil
}

func (e *Exchange) analysisPhase() error {
	for _, company := range e.Companies {
		company.analysisRoll = NewRoll(RollTargetAnalysis, 20)
	}

	for _, company := range e.Companies {
		company.ApplyTraits(company.analysisRoll)
	}

	// Calculate price changes
	for _, company := range e.Companies {
		isNegative := company.executionRoll.isFailure()
		demandMultiplier := float64(company.Category(e).Demand) * DEMAND_MULTIPLIER
		var priceChangePercent float64

		if isNegative {
			priceChangePercent =
				float64(company.impactRoll.ModifiedInverse()) *
					float64(company.analysisRoll.ModifiedInverse()) *
					demandMultiplier / 100 * FAILURE_MULTIPLIER
		} else {
			priceChangePercent =
				float64(company.impactRoll.Modified()) *
					float64(company.analysisRoll.Modified()) *
					demandMultiplier / 100 * SUCCESS_MULTIPLIER
		}
		company.UpdatePrice(priceChangePercent)
	}

	for _, company := range e.Companies {
		category := company.Category(e)
		if company.executionRoll.isCriticalSuccess() {
			category.UpdateDemand(category.Demand + 3)
		} else if company.executionRoll.isCriticalFailure() {
			category.UpdateDemand(category.Demand - 3)
		} else if company.executionRoll.isSuccess() {
			category.UpdateDemand(category.Demand + 1)
		} else {
			category.UpdateDemand(category.Demand - 1)
		}
	}

	return nil
}
