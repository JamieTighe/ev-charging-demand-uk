--Identifies charging sites whose postcodes don’t map to any local authority, exports them for reverse-geocoding in Python/Google Maps, applies corrected postcodes back into the database, and then rechecks any remaining unmapped sites.

SET search_path TO ev_charging;

CREATE VIEW ev_charging.sites_unmapped_postcodes AS
SELECT
    s.site_id,
    s.title,
    s.latitude,
    s.longitude,
    s.pcds_clean AS current_pcds_clean
FROM ev_charging.sites s
LEFT JOIN ev_charging.postcode_la pl
    ON s.pcds_clean = pl.pcds_clean
WHERE
    s.pcds_clean IS NULL
    OR pl.pcds_clean IS NULL;


SELECT COUNT(*) FROM ev_charging.sites_unmapped_postcodes;
SELECT * FROM ev_charging.sites_unmapped_postcodes;



CREATE TABLE site_postcode_fixes (
    site_id        BIGINT PRIMARY KEY,
    old_pcds_clean TEXT,
    new_pcds_clean TEXT
);

SELECT * FROM ev_charging.site_postcode_fixes LIMIT 10;

SELECT COUNT(*) FROM ev_charging.site_postcode_fixes;


UPDATE sites s
SET pcds_clean = f.new_pcds_clean
FROM site_postcode_fixes f
WHERE s.site_id = f.site_id
  AND f.new_pcds_clean IS NOT NULL;

SELECT COUNT(*) AS unmapped_sites_after_fix
FROM ev_charging.sites_unmapped_postcodes;


SELECT *
FROM ev_charging.sites_unmapped_postcodes;


SELECT COUNT(*) FROM ev_charging.sites_unmapped_postcodes;

SELECT *
FROM ev_charging.la_supply_kpis
ORDER BY plugs_per_1k_bevs DESC
LIMIT 10;