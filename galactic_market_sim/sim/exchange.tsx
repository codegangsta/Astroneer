import { Company, Trends } from "./company";
import { Roll, RollTarget } from "./roll";

class Exchange {
  // Game variables, consider moving to an interface
  public trendPositiveNormal: number = 1;
  public trendNegativeNormal: number = -1;
  public trendPositiveCritical: number = 5;
  public trendNegativeCritical: number = -3;

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
    // Each company rolls
    this.companies.forEach((company) => {
      const trend = this.categories[company.forecast];
      const requirement = 10 + Math.round((trend.score - 10) / 2);

      company.executionRoll = new Roll(RollTarget.Execution, 20, requirement);
    });

    // Each company modifies their roll (or others) based on their traits
    this.companies.forEach((company) => {
      company.traits.forEach((trait) => trait.process(company.executionRoll));
    });
  }

  impactPhase() {
    // Each company rolls
    this.companies.forEach((company) => {
      company.impactRoll = new Roll(RollTarget.Impact, 20);
    });

    // Each company modifies their roll (or others) based on their traits
    this.companies.forEach((company) => {
      company.traits.forEach((trait) => trait.process(company.impactRoll));
    });
  }

  // Industry analysts make their predictions for each company,
  // and the companies stock prices are updated accordingly
  analysisPhase() {
    this.companies.forEach((company) => {
      company.analysisRoll = new Roll(RollTarget.Analysis, 20);
    });

    // Each company modifies their roll (or others) based on their traits
    this.companies.forEach((company) => {
      company.traits.forEach((trait) => trait.process(company.analysisRoll));
    });

    // Calculate the price change for each company
    this.companies.forEach((company) => {
      const trend = this.categories[company.forecast];

      const isNegative = company.executionRoll.isFailure();

      var priceChangePercent =
        ((company.impactRoll.modified(isNegative) *
          company.analysisRoll.modified(isNegative) *
          10) / //todo: rework trend score
          100) *
        (isNegative ? -0.75 : 1);

      if (isNegative) {
        priceChangePercent = Math.max(priceChangePercent, -17);
      }

      company.changePrice(priceChangePercent);

      console.log(`[${company.name}] Price change:`, priceChangePercent + "%");
      console.log("\t", `Forecast: ${company.forecast} (${trend.score})`);
      console.log("\t", company.executionRoll.toString());
      console.log("\t", company.impactRoll.toString());
      console.log("\t", company.analysisRoll.toString());
      console.log("\t", company.price);

      // change trends
      if (company.executionRoll.isCriticalSuccess()) {
        trend.score += this.trendPositiveCritical;
      } else if (company.executionRoll.isSuccess()) {
        trend.score += this.trendPositiveNormal;
      } else if (company.executionRoll.isCriticalFailure()) {
        trend.score += this.trendNegativeCritical;
      } else if (company.executionRoll.isFailure()) {
        trend.score += this.trendNegativeNormal;
      }
    });
  }
}

export default Exchange;
