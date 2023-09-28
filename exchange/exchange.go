package exchange

import (
	"fmt"
	"math"
	"math/rand"
)

// Game constants
const (
	// How much successful price calculations are multiplied by
	SUCCESS_MULTIPLIER = 1
	// How much failed price calculations are multiplied by
	FAILURE_MULTIPLIER = -0.9
	// How much demand is multiplied by when calculating price changes
	DEMAND_MULTIPLIER = 0.15

	// The dice to roll in the case of a critical success
	CRIT_DICE = 6
)

var quarterlyPhases = []func(*Exchange) error{
	(*Exchange).forecastPhase,
	(*Exchange).strategyPhase,
}

var dailyPhases = []func(*Exchange) error{
	(*Exchange).executionPhase,
	(*Exchange).impactPhase,
	(*Exchange).analysisPhase,
}

type Exchange struct {
	Name string `json:"name"`
	Day  int    `json:"day"`

	Companies  []*Company  `json:"companies"`
	Categories []*Category `json:"categories"`
}

func New(name string) *Exchange {
	return &Exchange{
		Name: name,
	}
}

func (e *Exchange) TickQuarter() error {
	for _, phase := range quarterlyPhases {
		if err := phase(e); err != nil {
			return err
		}
	}

	// tick for 90 days
	for i := 1; i <= 90; i++ {
		if err := e.TickDay(); err != nil {
			return err
		}
	}

	return nil
}

func (e *Exchange) TickDay() error {
	e.Day++
	for _, phase := range dailyPhases {
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
		company.ApplyTraits(company.executionRoll, e)
	}
	return nil
}

func (e *Exchange) impactPhase() error {
	for _, company := range e.Companies {
		company.impactRoll = NewRoll(RollTargetImpact, 20)
	}

	for _, company := range e.Companies {
		company.ApplyTraits(company.impactRoll, e)
	}
	return nil
}

func (e *Exchange) analysisPhase() error {
	for _, company := range e.Companies {
		company.analysisRoll = NewRoll(RollTargetAnalysis, 20)
	}

	for _, company := range e.Companies {
		company.ApplyTraits(company.analysisRoll, e)
	}

	// Calculate price changes
	for _, company := range e.Companies {
		isNegative := company.executionRoll.isFailure()
		demandMultiplier := float64(company.Category(e).Demand) * DEMAND_MULTIPLIER
		var priceChangePercent float64

		if company.executionRoll.isCriticalSuccess() {
			company.impactRoll.WithModifier("Critical Success", rollDice(CRIT_DICE))
		}

		if company.executionRoll.isCriticalFailure() {
			company.impactRoll.WithModifier("Critical Failure", rollDice(CRIT_DICE))
		}

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

func (e *Exchange) Category(id string) *Category {
	for _, category := range e.Categories {
		if category.ID == id {
			return category
		}
	}
	return nil
}

func (e *Exchange) Specialization(categoryID string, value uint) Trait {
	category := e.Category(categoryID)

	return NewSpecialization(
		fmt.Sprintf("%s Specialist", category.Name),
		fmt.Sprintf("+%d to Execution rolls in the '%s' category", value, category.Name),
		RollTargetExecution,
		category.ID,
		int(value),
	)
}
