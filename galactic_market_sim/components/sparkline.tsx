"use client";

import Chart from "react-apexcharts";

interface Props {
  series: {
    name: string;
    data: number[];
  };
  color?: string;
}

export function SparkLine({ series, color }: Props) {
  const average = series.data.reduce((a, b) => a + b, 0) / series.data.length;
  const options: ApexCharts.ApexOptions = {
    annotations: {
      yaxis: [
        {
          y: average,
          borderColor: color,
          strokeDashArray: 2,
        },
      ],
    },
    theme: {
      mode: "dark",
    },
    fill: {
      type: "gradient",
      gradient: {
        shade: "dark",
        opacityTo: 0,
      },
    },
    tooltip: {
      enabled: false,
    },
    chart: {
      background: "transparent",
      sparkline: { enabled: true },
    },
    stroke: {
      width: 1,
      curve: "straight",
    },
    colors: [color],
  };
  return (
    <div>
      <Chart
        type="area"
        width={100}
        height={36}
        options={options}
        series={[series]}
      />
    </div>
  );
}
