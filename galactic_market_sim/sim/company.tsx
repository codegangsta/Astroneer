import { Roll, RollTarget } from "./roll";
import { Trait } from "./traits/base";

export class Company {
  public traits: Trait[] = [];
  public executionRoll: Roll = new Roll(RollTarget.None, 20);
  public impactRoll: Roll = new Roll(RollTarget.None, 20);
  public analysisRoll: Roll = new Roll(RollTarget.None, 20);
  public changePercent: number = 0;
  public priceHistory: number[] = [];

  constructor(
    public name: string,
    public symbol: string,
    public price: number,
    public units: number,
    public forecast: Category
  ) {
    this.priceHistory.push(price);
  }

  changePrice(percent: number) {
    this.changePercent = percent;
    const changeValue = (this.price * percent) / 100;
    this.price += changeValue;

    // max array length to 24
    this.priceHistory.push(this.price);
    if (this.priceHistory.length > 24) {
      this.priceHistory.shift();
    }
  }

  log(...messages: any) {
    console.log(`[${this.name}]`, ...messages);
  }
}

export enum Category {
  HabsAndCockpits = "Habs and Cockpits",
  Weapons = "Weapons",
  Engines = "Engines",
  Reactors = "Reactors",
  GravDrives = "Grav Drives",
  Cargo = "Cargo",
  Shields = "Shields",
}

export interface Trend {
  score: number;
}

export type Trends = Record<Category, Trend>;
