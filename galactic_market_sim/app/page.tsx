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
import { useState } from "react";

export default function Home() {
  const [i, setI] = useState<number>(0);

  const onClick = () => {
    setI(i + 1);
  };

  const companies: Company[] = [];
  const trends = {} as Trends;

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
