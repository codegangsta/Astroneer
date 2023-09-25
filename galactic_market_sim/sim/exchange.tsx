import { Company, Trends } from "./company";
import { Roll, RollTarget } from "./roll";

class Exchange {
  // Game variables, consider moving to an interface
  public trendPositiveNormal: number = 2;
  public trendNegativeNormal: number = -2;
  public trendPositiveCritical: number = 6;
  public trendNegativeCritical: number = -6;

  constructor(
    public name: string,
    public companies: Company[],
    public categories: Trends
  ) {}

  tick() {
    this.forecastPhase();
    this.strategyPhase();
    this.executionPhase();
    this.impactPhase();
    this.analysisPhase();
  }

  trendPhase() {}

  // Each company chooses a category to invest in
  forecastPhase() {
    this.companies.forEach((company) => {});
  }

  // Each company chooses a strategy for the next phase
  strategyPhase() {}

  executionPhase() {
    this.companies.forEach((company) => {
      company.executionRoll = new Roll(RollTarget.Execution, 20, 11);
      company.traits.forEach((trait) => trait.process(company.executionRoll));
      company.log(company.executionRoll.toString());
    });
  }

  impactPhase() {
    this.companies.forEach((company) => {
      company.impactRoll = new Roll(RollTarget.Impact, 20);
      company.traits.forEach((trait) => trait.process(company.impactRoll));
      company.log(company.impactRoll.toString());
    });
  }

  // Industry analysts make their predictions for each company,
  // and the companies stock prices are updated accordingly
  analysisPhase() {
    this.companies.forEach((company) => {
      if (company.executionRoll.isCriticalSuccess()) {
        this.categories[company.forecast].score += this.trendNegativeCritical;
      }
    });
  }
}

export default Exchange;
