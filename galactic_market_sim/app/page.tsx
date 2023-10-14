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
import { useCallback, useEffect, useState } from "react";
import { NatsConnection, connect, StringCodec } from "nats.ws";
import { Exchange } from "@/types/exchange";

const sc = StringCodec();

export default function Home() {
  const [i, setI] = useState<number>(0);
  const [conn, setConn] = useState<NatsConnection>();
  const [exchange, setExchange] = useState<Exchange>();

  useEffect(() => {
    connect({ servers: ["ws://localhost:7422"] })
      .then(setConn)
      .catch(console.error);
  }, []);

  useEffect(() => {
    if (!conn) return;
    conn.request("astroneering.get_exchange", "").then((msg) => {
      const exchange = JSON.parse(sc.decode(msg.data));
      console.log(exchange);
      setExchange(exchange);
    });
  }, [conn]);

  const advanceQuarter = useCallback(() => {
    if (!conn) return;
    conn.request("astroneering.next_quarter", "").then((msg) => {
      const exchange = JSON.parse(sc.decode(msg.data));
      setExchange(exchange);
    });
  }, [conn]);

  const advanceDay = useCallback(() => {
    if (!conn) return;
    conn.request("astroneering.next_day", "").then((msg) => {
      const exchange = JSON.parse(sc.decode(msg.data));
      setExchange(exchange);
    });
  }, [conn]);

  if (!exchange) return null;

  const { companies, categories } = exchange;

  if (!companies || !categories) return null;

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24 gap-8">
      <div className="flex flex-row gap-3 items-center w-full">
        <span className="text-2xl font-semibold text-gray-100">
          Day {exchange.day}
        </span>
        <span className="flex-grow"></span>
        <Button onClick={advanceQuarter}>Next Quarter</Button>
        <Button onClick={advanceDay}>Next Day</Button>
      </div>
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
            {categories.map((category) => (
              <div key={category.id}>
                <span>{category.name}</span>
                <Progress value={category.demand / 10} />
              </div>
            ))}
          </CardContent>
          <CardContent></CardContent>
        </Card>
      </div>
    </main>
  );
}
