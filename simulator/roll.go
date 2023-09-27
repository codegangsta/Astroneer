package simulator

import (
	"fmt"
	"math/rand"
)

type RollTarget string

const (
	RollTargetNone      RollTarget = "none"
	RollTargetExecution RollTarget = "execution"
	RollTargetImpact    RollTarget = "impact"
	RollTargetAnalysis  RollTarget = "analysis"
)

type RollKind string

const (
	RollKindNormal       RollKind = "normal"
	RollKindAdvantage    RollKind = "advantage"
	RollKindDisadvantage RollKind = "disadvantage"
)

type rollModifier struct {
	description string
	value       int
}

func (r *rollModifier) String() string {
	sign := ""
	if r.value > 0 {
		sign = "+"
	}
	return fmt.Sprintf("%s%d (%s)", sign, r.value, r.description)
}

type Roll struct {
	target      RollTarget
	kind        RollKind
	sides       uint
	original    uint
	requirement uint
	modifiers   []rollModifier
}

func NewRole(target RollTarget, sides uint) *Roll {
	return (&Roll{
		target: target,
		kind:   RollKindNormal,
		sides:  sides,
	}).Roll()
}

func (r *Roll) Roll() *Roll {
	r.original = rollDice(r.sides)
	return r
}

func (r *Roll) WithRequirement(requirement uint) *Roll {
	r.requirement = requirement
	return r
}

func (r *Roll) WithAdvantage() *Roll {
	r.kind = RollKindAdvantage
	r.original = max(r.original, rollDice(r.sides))
	return r
}

func (r *Roll) WithDisadvantage() *Roll {
	r.kind = RollKindDisadvantage
	r.original = min(r.original, rollDice(r.sides))
	return r
}

func (r *Roll) WithModifier(description string, value int) *Roll {
	r.modifiers = append(r.modifiers, rollModifier{
		description: description,
		value:       value,
	})
	return r
}

func (r *Roll) Modified() uint {
	modified := r.original
	for _, modifier := range r.modifiers {
		modified += uint(modifier.value)
	}
	return modified
}

func (r *Roll) Target() RollTarget {
	return r.target
}

func (r *Roll) Kind() RollKind {
	return r.kind
}

func (r *Roll) String() string {
	// Return the string representation of the roll
	result := fmt.Sprintf("[%s] Roll for %s: %d", r.kind, r.target, r.Modified())
	if r.requirement > 0 {
		result += fmt.Sprintf(" / %d", r.requirement)
		if r.isCriticalSuccess() {
			result += " (critical success)"
		} else if r.isCriticalFailure() {
			result += " (critical failure)"
		} else if r.isSuccess() {
			result += " (success)"
		} else {
			result += " (failure)"
		}
	}
	if len(r.modifiers) > 0 {
		result += fmt.Sprintf("\n\t %d (Base)", r.original)
		for _, modifier := range r.modifiers {
			result += "\n\t" + modifier.String()
		}
	}

	return result
}

func (r *Roll) isSuccess() bool {
	return r.Modified() >= r.requirement
}

func (r *Roll) isFailure() bool {
	return r.Modified() < r.requirement
}

func (r *Roll) isCriticalSuccess() bool {
	return r.original == r.sides
}

func (r *Roll) isCriticalFailure() bool {
	return r.original == 1
}

func rollDice(sides uint) uint {
	return uint(1 + rand.Intn(int(sides)))
}
