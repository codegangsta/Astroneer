import { Roll } from "../roll";

export interface Trait {
  name: string;
  description: string;

  process: (roll: Roll) => void;
}
