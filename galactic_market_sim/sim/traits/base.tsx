import { Roll } from "../roll";

export class Trait {
  constructor(private _name: string, private _description: string) {}

  name() {
    return this._name;
  }

  description() {
    return this._description;
  }

  process(roll: Roll) {
    throw new Error("Not implemented");
  }
}
