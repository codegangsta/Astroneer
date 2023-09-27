import { Roll, RollTarget } from "../roll";
import { Trait } from "./base";

export class LastingImpact extends Trait {
  process(roll: Roll) {
    if (roll.target() == RollTarget.Impact) {
      roll.advantage();
    }
  }
}
