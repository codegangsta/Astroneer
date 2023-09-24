import { Roll, RollTarget } from "./roll";
import Trait from "./trait";

export class Company {
  public traits: Trait[] = [];
  public executionRoll: Roll = new Roll(RollTarget.None, 20);
  public impactRoll: Roll = new Roll(RollTarget.None, 20);

  constructor(
    public name: string,
    public symbol: string,
    public price: number,
    public units: number,
    public forecast: Category
  ) {}
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
