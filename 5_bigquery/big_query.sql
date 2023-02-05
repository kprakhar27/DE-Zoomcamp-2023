-- query public available table
SELECT station_id, name FROM
    bigquery-public-data.new_york_citibike.citibike_stations
LIMIT 100;

-- create extrenal table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `data-engineering-369507.trips_data_all.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dtc_data_lake_data-engineering-369507/raw/yellow_tripdata/2019/yellow_tripdata_2019-*.parquet','gs://dtc_data_lake_data-engineering-369507/raw/yellow_tripdata/2020/yellow_tripdata_2020-*.parquet']
);

-- check yellow trip data
SELECT * except(airport_fee) FROM `data-engineering-369507.trips_data_all.external_yellow_tripdata` limit 10;

-- create a non partitioned table from external table
CREATE OR REPLACE TABLE `data-engineering-369507.trips_data_all.yellow_tripdata_non_partitioned` AS
SELECT * except(airport_fee) FROM `data-engineering-369507.trips_data_all.external_yellow_tripdata`;

-- create a partitioned table from external table
CREATE OR REPLACE TABLE `data-engineering-369507.trips_data_all.yellow_tripdata_partitioned`
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * except(airport_fee) FROM `data-engineering-369507.trips_data_all.external_yellow_tripdata`;

-- impact of partition
-- scanning 1.63GB of data
SELECT DISTINCT(VendorID)
FROM `data-engineering-369507.trips_data_all.yellow_tripdata_non_partitioned`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Scanning ~106.37 MB of DATA
SELECT DISTINCT(VendorID)
FROM `data-engineering-369507.trips_data_all.yellow_tripdata_partitioned`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Let's look into the partitons
SELECT table_name, partition_id, total_rows
FROM `trips_data_all.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_partitioned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE `data-engineering-369507.trips_data_all.yellow_tripdata_partitioned_clustered`
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * except(airport_fee) FROM `data-engineering-369507.trips_data_all.external_yellow_tripdata`;

-- Query scans 1.07 GB
SELECT count(*) as trips
FROM `data-engineering-369507.trips_data_all.yellow_tripdata_partitioned`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;

-- Query scans 870.51 MB
SELECT count(*) as trips
FROM `data-engineering-369507.trips_data_all.yellow_tripdata_partitioned_clustered`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;
