"use client";

import { Company } from "@/sim/company";
import { Badge } from "./ui/badge";
import { cn } from "@/lib/utils";
import { SparkLine } from "./sparkline";

interface Props {
  company: Company;
}

export function CompanySymbol({ company }: Props) {
  return (
    <div className="flex flex-row py-4 gap-3">
      <div className="flex flex-col grow">
        <span className="font-semibold text-gray-100">{company.symbol}</span>
        <span className="text-sm text-gray-400">{company.name}</span>
      </div>
      <div className="flex items-center">
        <SparkLine
          series={{ name: company.symbol, data: company.priceHistory }}
          color={company.changePercent > 0 ? "#22C55E" : "#EF4444"}
        />
      </div>
      <div className="flex flex-col text-right min-w-[80px]">
        <div className="text-gray-100">{company.price.toFixed(2)}</div>
        <div>
          <Badge
            variant="secondary"
            className={cn(
              company.changePercent > 0 ? "bg-green-600" : "bg-red-600"
            )}
          >
            <div className="text-center w-full">
              {company.changePercent.toFixed(2)}%
            </div>
          </Badge>
        </div>
      </div>
    </div>
  );
}
