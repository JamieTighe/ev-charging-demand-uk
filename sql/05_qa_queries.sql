--QA queries

SELECT 'sites'        AS table_name, COUNT(*) AS rows FROM ev_charging.sites
UNION ALL
SELECT 'plugs',                     COUNT(*) FROM ev_charging.plugs
UNION ALL
SELECT 'postcode_la',               COUNT(*) FROM ev_charging.postcode_la
UNION ALL
SELECT 'la_names',                  COUNT(*) FROM ev_charging.la_names
UNION ALL
SELECT 'veh9901_bev',               COUNT(*) FROM ev_charging.veh9901_bev;


SELECT * FROM ev_charging.sites LIMIT 10;
SELECT * FROM ev_charging.plugs LIMIT 10;
SELECT * FROM ev_charging.postcode_la LIMIT 10;
SELECT * FROM ev_charging.veh9901_bev LIMIT 10;
SELECT * FROM ev_charging.la_names LIMIT 10;


SELECT v.lad25cd
FROM ev_charging.veh9901_bev v
LEFT JOIN ev_charging.la_names ln USING (lad25cd)
WHERE ln.lad25cd IS NULL
ORDER BY v.lad25cd;


SELECT pl.lad25cd, COUNT(*) AS num_postcodes
FROM ev_charging.postcode_la pl
LEFT JOIN ev_charging.la_names ln USING (lad25cd)
WHERE ln.lad25cd IS NULL
GROUP BY pl.lad25cd
ORDER BY num_postcodes DESC;




SELECT *
FROM ev_charging.la_supply_kpis
WHERE plugs_per_1k_bevs IS NOT NULL
ORDER BY plugs_per_1k_bevs DESC
LIMIT 10;


SELECT *
FROM ev_charging.la_supply_kpis
WHERE plugs_per_1k_bevs IS NOT NULL
ORDER BY plugs_per_1k_bevs ASC
LIMIT 10;


SELECT
    power_band,
    SUM(quantity) AS total_plugs
FROM ev_charging.plugs
GROUP BY power_band
ORDER BY total_plugs DESC;


SELECT
    s.operator,
    SUM(p.quantity) AS total_plugs
FROM ev_charging.sites s
JOIN ev_charging.plugs p ON p.site_id = s.site_id
GROUP BY s.operator
ORDER BY total_plugs DESC
LIMIT 10;

