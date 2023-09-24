import { Roll } from "./roll";

interface Trait {
  name: string;

  process(roll: Roll): void;
}

export default Trait;
