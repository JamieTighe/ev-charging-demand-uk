# Are UK public chargers keeping up with EV demand?

## Overview
Battery-electric vehicle (BEV) adoption is rising, but public charging provision is uneven across Great Britain.  
This project builds a reproducible pipeline to compare **public charging supply** with **privately-owned BEV demand** at **local authority** level, producing KPI views in PostgreSQL and interactive Tableau dashboards.

**Stack:** PostgreSQL (AWS RDS) + SQL + Python (Jupyter) + Tableau  
**Key output:** `la_supply_kpis` view (one row per local authority)

## Key Findings
- Great Britain has ~**586,972** privately owned BEVs and ~**62,302** public charge points, averaging ~**115** plugs per 1,000 private BEVs.  
- Coverage is highly uneven: London, Scotland, Wales and Northern Ireland sit at/above the benchmark, while several English regions lag behind.
- A priority group of local authorities combine **high BEV demand** with **below-average charging coverage**.
- Network quality matters: much of the network is still dominated by slower chargers and small sites, with rapid/ultra-rapid a minority.

## Recommendations
- Prioritise investment in local authorities with large privately owned BEV fleets but below-average plugs per BEV.
- Improve **quality**, not just quantity: increase rapid/ultra-rapid share and develop multi-plug hubs in under-served areas.

> Full methodology, limitations and detail are in `/docs/ev_charging_vs_demand_technical_report.pdf`.

## Data Sources
- **OpenChargeMap (OCM)**: public charging sites and plugs (supply)
- **DfT VEH9901**: privately kept BEV registrations by local authority (demand)
- **ONS Postcode Directory (ONSPD)**: postcode → local authority mapping

## Repo Structure
- `/sql/` schema, constraints, KPI views, QA queries
- `/notebooks/` API extraction, postcode cleaning, reverse geocoding, forecasting
- `/tableau/` Tableau packaged workbook + dashboard link
- `/docs/` technical report + slides
