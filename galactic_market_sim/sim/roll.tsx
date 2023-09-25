import { rollD } from "./util";

export enum RollTarget {
  None = "None",
  Execution = "Execution",
  Impact = "Impact",
}

export enum RollType {
  Normal = "Normal",
  Advantage = "Advantage",
  Disadvantage = "Disadvantage",
}

export interface RollModifier {
  name: string;
  value: number;
}

export class Roll {
  private _original: number;
  private _modifiers: RollModifier[] = [];
  private _type: RollType = RollType.Normal;

  constructor(
    private _target: RollTarget,
    private _sides: number,
    private _requirement: number = 0
  ) {
    this._original = rollD(_sides);
  }

  // Rerolls this roll as an advantage roll
  advantage() {
    this._type = RollType.Advantage;
    this._original = Math.max(rollD(this._sides), rollD(this._sides));
  }

  // Rerolls this roll as a disadvantage roll
  disadvantage() {
    this._type = RollType.Disadvantage;
    this._original = Math.min(rollD(this._sides), rollD(this._sides));
  }

  isSuccess() {
    return this.modified() >= this._requirement;
  }

  isFailure() {
    return this.modified() < this._requirement;
  }

  isCriticalSuccess() {
    return this._original === this._sides;
  }

  isCriticalFailure() {
    return this._original === 1;
  }

  // Rerolls this roll as a normal roll
  normal() {
    this._type = RollType.Normal;
    this._original = rollD(this._sides);
  }

  original() {
    return this._original;
  }

  target() {
    return this._target;
  }

  type() {
    return this._type;
  }

  modified() {
    return this._modifiers.reduce(
      (acc, mod) => acc + mod.value,
      this._original
    );
  }

  addModifier(modifier: RollModifier) {
    this._modifiers.push(modifier);
  }

  toString() {
    var base = `Rolled ${this.modified()}`;

    if (this._type === RollType.Advantage) {
      base += " (Advantage)";
    } else if (this._type === RollType.Disadvantage) {
      base += " (Disadvantage)";
    }

    if (this._requirement > 0) {
      if (this.isCriticalSuccess()) {
        base += " (Critical Success)";
      } else if (this.isSuccess()) {
        base += " (Success)";
      } else if (this.isCriticalFailure()) {
        base += " (Critical Failure)";
      } else if (this.isFailure()) {
        base += " (Failure)";
      }
    }

    // modifiers
    if (this._modifiers.length > 0) {
      base += "\n";
      base += this._modifiers
        .map((mod) => `${mod.name} ${mod.value > 0 ? "+" : ""}${mod.value}`)
        .join(", ");
    }

    return base;
  }
}
