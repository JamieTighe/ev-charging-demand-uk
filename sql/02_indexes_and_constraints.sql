--Adds the indexes and foreign key constraints that enforce relationships between sites, plugs, postcodes, BEV counts, and local authorities.

CREATE INDEX IF NOT EXISTS idx_sites_pcds_clean
    ON sites(pcds_clean);

CREATE INDEX IF NOT EXISTS idx_plugs_site_id
    ON plugs(site_id);

CREATE UNIQUE INDEX IF NOT EXISTS idx_postcode_la_pcds_clean
    ON postcode_la(pcds_clean);

CREATE UNIQUE INDEX IF NOT EXISTS idx_la_names_lad25cd
    ON la_names(lad25cd);

ALTER TABLE plugs
    ADD CONSTRAINT fk_plugs_site
    FOREIGN KEY (site_id)
    REFERENCES sites(site_id)
    ON DELETE CASCADE;

ALTER TABLE sites
 	ADD CONSTRAINT fk_sites_postcode
 	FOREIGN KEY (pcds_clean)
 	REFERENCES postcode_la(pcds_clean)
 	NOT VALID;

ALTER TABLE veh9901_bev
    ADD CONSTRAINT fk_veh9901_bev_lad
    FOREIGN KEY (lad25cd)
    REFERENCES la_names(lad25cd);

ALTER TABLE postcode_la
    ADD CONSTRAINT fk_postcode_la_lad
    FOREIGN KEY (lad25cd)
    REFERENCES la_names(lad25cd);
