"use client";
import { CompanySymbol } from "@/components/company-symbol";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Separator } from "@/components/ui/separator";
import { Category, Company, Trends } from "@/sim/company";
import Exchange from "@/sim/exchange";
import { RollTarget } from "@/sim/roll";
import { rollD } from "@/sim/util";
import { useState } from "react";

const trends: Trends = {
  [Category.HabsAndCockpits]: { score: rollD(20) },
  [Category.Weapons]: { score: rollD(20) },
  [Category.Engines]: { score: rollD(20) },
  [Category.Reactors]: { score: rollD(20) },
  [Category.GravDrives]: { score: rollD(20) },
  [Category.Cargo]: { score: rollD(20) },
  [Category.Shields]: { score: rollD(20) },
};

const jeremy = new Company(
  "Jeremy's Company",
  "JERM",
  19.86,
  100000000,
  Category.HabsAndCockpits
);
jeremy.traits = [
  {
    name: "Lasting Impact",
    description: "+2 to impact rolls",
    process: (roll) => {
      if (roll.target() === RollTarget.Impact) {
        roll.addModifier({ name: "Lasting Impact", value: 2 });
      }
    },
  },
];

const companies: Company[] = [
  jeremy,
  new Company(
    "Stroud Eklund",
    "STEK",
    29.34,
    100000000,
    Category.HabsAndCockpits
  ),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("HopeTech", "HPTC", 19.86, 100000000, Category.HabsAndCockpits),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
  new Company("Amun Dunn", "AMDN", 12.34, 100000000, Category.Shields),
];

const exchange = new Exchange("Trade Authority Exchange", companies, trends);
for (let i = 0; i < 240; i++) {
  exchange.tick();
}

export default function Home() {
  const [i, setI] = useState<number>(0);

  const onClick = () => {
    exchange.tick();
    setI(i + 1);
  };

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <Button onClick={onClick}>Next</Button>
      <div className="z-10 max-w-5xl w-full gap-3 grid grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle>Trade Authority Exchange</CardTitle>
            <CardDescription>
              This is a description for the Trade Authority Exchange
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex flex-col">
              <Separator></Separator>
              {companies.map((company) => (
                <div key={company.symbol}>
                  <CompanySymbol company={company} />
                  <Separator></Separator>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Market Demand</CardTitle>
            <CardDescription>
              This is a description for the Supply and Demand
            </CardDescription>
          </CardHeader>
          <CardContent className="flex flex-col gap-3">
            {Object.keys(trends).map((trend) => (
              <div key={trend}>
                <span>{trend}</span>
                <Progress value={trends[trend as Category].score * 5} />
              </div>
            ))}
          </CardContent>
          <CardContent></CardContent>
        </Card>
      </div>
    </main>
  );
}
