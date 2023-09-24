import { Company, Trends } from "./company";
import { Roll, RollTarget } from "./roll";

class Exchange {
  constructor(
    public name: string,
    public companies: Company[],
    public categories: Trends
  ) {}

  tick() {
    this.forecastPhase();
    this.strategyPhase();
    this.executionPhase();
    this.analysisPhase();
  }

  trendPhase() {}

  // Each company chooses a category to invest in
  forecastPhase() {}

  // Each company chooses a strategy for the next phase
  strategyPhase() {}

  executionPhase() {
    this.companies.forEach((company) => {
      company.executionRoll = new Roll(RollTarget.Execution, 20);
      company.traits.forEach((trait) => trait.process(company.executionRoll));
    });
  }

  impactPhase() {
    this.companies.forEach((company) => {
      company.impactRoll = new Roll(RollTarget.Impact, 20);
      company.traits.forEach((trait) => trait.process(company.impactRoll));
    });
  }

  // Industry analysts make their predictions for each company,
  // and the companies stock prices are updated accordingly
  analysisPhase() {
    this.companies.forEach((company) => {});
  }
}

export default Exchange;
