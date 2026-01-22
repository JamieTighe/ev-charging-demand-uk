--Defines the main local-authority-level KPI view combining BEV demand with site and plug supply and calculating plugs per 1,000 BEVs.

SET search_path TO ev_charging;

CREATE VIEW la_supply_kpis AS
SELECT
    ln.lad25cd,
    ln.la_name,
    ln.region_name,
    ln.ula_name,
    ln.lla_name,
    v.bev_vehicles,
    COUNT(DISTINCT s.site_id) AS sites,
    COALESCE(SUM(p.quantity), 0) AS plugs,
    CASE
        WHEN v.bev_vehicles IS NOT NULL AND v.bev_vehicles > 0
            THEN ROUND((COALESCE(SUM(p.quantity),0)::NUMERIC * 1000)
                       / v.bev_vehicles, 2)
        ELSE NULL
    END AS plugs_per_1k_bevs
FROM la_names ln
LEFT JOIN veh9901_bev v
    ON v.lad25cd = ln.lad25cd
LEFT JOIN postcode_la pl
    ON pl.lad25cd = ln.lad25cd
LEFT JOIN sites s
    ON s.pcds_clean = pl.pcds_clean
LEFT JOIN plugs p
    ON p.site_id = s.site_id
GROUP BY
    ln.lad25cd,
    ln.la_name,
    ln.region_name,
    ln.ula_name,
    ln.lla_name,
    v.bev_vehicles;