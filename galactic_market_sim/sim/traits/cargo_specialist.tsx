import { Category, Company } from "../company";
import { Roll, RollTarget } from "../roll";
import { Trait } from "./base";

class CargoSpecialist extends Trait {
  constructor(private _company: Company) {
    super("Cargo Specialist", "+1 to execution rolls for cargo forecasts");
  }

  process(roll: Roll) {
    if (
      roll.target() === RollTarget.Execution &&
      this._company.forecast == Category.Cargo
    ) {
      roll.addModifier({ name: this.name(), value: 1 });
    }
  }
}
