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

  constructor(private _target: RollTarget, private _sides: number) {
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
    return `${this._original} + ${this._modifiers
      .map((mod) => `${mod.value} (${mod.name})`)
      .join(" + ")} = ${this.modified()}`;
  }
}
