--Creates the ev_charging schema and all core tables for sites, plugs, postcode mapping, BEV counts, and local authority names.

CREATE SCHEMA ev_charging;
SET search_path TO ev_charging;

CREATE TABLE sites (
    site_id         BIGINT PRIMARY KEY,
    title           TEXT,
    latitude        DOUBLE PRECISION,
    longitude       DOUBLE PRECISION,
    operator        TEXT,
    usage_type      TEXT,
    reported_points INTEGER,
    pcds_clean      TEXT
);


CREATE TABLE plugs (
    connection_id    BIGINT PRIMARY KEY,
    site_id          BIGINT      NOT NULL,
    connection_type  TEXT,
    level            TEXT,
    current_type     TEXT,
    power_kw         NUMERIC,
    quantity         INTEGER     NOT NULL,
    status           TEXT,
    power_band       TEXT
);


CREATE TABLE postcode_la (
    pcds_clean  TEXT PRIMARY KEY,
    lad25cd     TEXT
);


CREATE TABLE veh9901_bev (
    lad25cd      TEXT PRIMARY KEY,
    bev_vehicles INTEGER
);


CREATE TABLE la_names (
    lad25cd      TEXT PRIMARY KEY,
    la_name      TEXT,
    region_name  TEXT,
    ula_name     TEXT,
    lla_name     TEXT
);
