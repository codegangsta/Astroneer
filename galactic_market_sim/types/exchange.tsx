export interface Exchange {
  name: string;
  day: string;
  companies: Company[];
  categories: Category[];
}

export interface Company {
  category_id: string;
  name: string;
  symbol: string;
  price: number;
  units: number;
  change_percent: number;
  price_history: number[];
  traits: Trait[];
}

export interface Category {
  id: string;
  name: string;
  description: string;
  demand: number;
}

export interface Trait {
  name: string;
  description: string;
}
