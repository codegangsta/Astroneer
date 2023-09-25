"use client";
import { Category, Company, Trends } from "@/sim/company";
import Exchange from "@/sim/exchange";
import { rollD } from "@/sim/util";

const trends: Trends = {
  [Category.HabsAndCockpits]: { score: rollD(20) },
  [Category.Weapons]: { score: rollD(20) },
  [Category.Engines]: { score: rollD(20) },
  [Category.Reactors]: { score: rollD(20) },
  [Category.GravDrives]: { score: rollD(20) },
  [Category.Cargo]: { score: rollD(20) },
  [Category.Shields]: { score: rollD(20) },
};

const companies: Company[] = [
  new Company(
    "Stroud Eklund",
    "STEK",
    29.34,
    100000000,
    Category.HabsAndCockpits
  ),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
];

const exchange = new Exchange("Trade Authority Exchange", companies, trends);

export default function Home() {
  const onClick = () => {
    exchange.tick();
  };

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="z-10 max-w-5xl w-full items-center justify-between font-mono text-sm lg:flex">
        {companies.map((company) => (
          <div
            key={company.symbol}
            className="flex flex-col items-center justify-between"
          >
            {company.name} = {company.price}
          </div>
        ))}
      </div>
      <button onClick={() => exchange.tick()}>Next</button>
    </main>
  );
}
