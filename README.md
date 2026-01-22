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

> Full methodology, limitations and detail are in `/docs/technical_report.pdf`.

## Data Sources
- **OpenChargeMap (OCM)**: public charging sites and plugs (supply)
- **DfT VEH9901**: privately kept BEV registrations by local authority (demand)
- **ONS Postcode Directory (ONSPD)**: postcode → local authority mapping

## Method (Pipeline)
1. **Extract OCM** via API, build `sites` (1 row/site) and `plugs` (1 row/plug).
2. **Clean + standardise postcodes** (`pcds_clean`) and join to ONSPD (`postcode_la`) for LAD mapping.
3. Handle **unmatched postcodes** using a reverse-geocoding workflow (Google Maps API) and re-map where possible.
4. Prepare **BEV demand** from VEH9901 to `veh9901_bev` (privately kept BEVs only).
5. Create `la_supply_kpis` view combining demand + supply metrics:
   - sites, plugs, plugs per 1,000 private BEVs
   - accessibility/operator fields and power-band summaries (where available)
6. Connect Tableau to PostgreSQL and publish dashboards for exploration.

## Repo Structure
- `/sql/` schema, constraints, KPI views, QA queries
- `/notebooks/` API extraction, postcode cleaning, reverse geocoding, forecasting
- `/data/` processed inputs used to load PostgreSQL (raw data optional)
- `/tableau/` Tableau packaged workbook + dashboard link
- `/docs/` technical report + slides (PDF exports)
- `/assets/` screenshots for quick viewing
- `/outputs/` optional exported KPI samples

