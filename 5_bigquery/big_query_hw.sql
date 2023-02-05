-- Create a external table for for-hire vehicles for the year 2019
CREATE OR REPLACE EXTERNAL TABLE `data-engineering-369507.trips_data_all.fhv_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dtc_data_lake_data-engineering-369507/raw/fhv_tripdata/2019/fhv_tripdata_2019-*.parquet']
);

-- Q1 What is count for fhv vehicles data for year 2019
SELECT COUNT(*) FROM `data-engineering-369507.trips_data_all.fhv_tripdata`;

-- Q2 How many distinct dispatching_base_num we have in fhv for 2019
SELECT COUNT(DISTINCT(dispatching_base_num)) FROM `data-engineering-369507.trips_data_all.fhv_tripdata`;

-- Create a nonpartitioned table for for-hire vehicles for the year 2019
CREATE OR REPLACE TABLE `data-engineering-369507.trips_data_all.fhv_nonpartitioned_tripdata`
AS SELECT
  CAST(dispatching_base_num AS STRING) AS dispatching_base_num,
  CAST(pickup_datetime AS TIMESTAMP) AS pickup_datetime,
  CAST(dropOff_datetime AS TIMESTAMP) AS dropOff_datetime,
  CAST(PUlocationID AS FLOAT64) AS PUlocationID,
  CAST(DOlocationID AS FLOAT64) AS DOlocationID,
  -- CAST(SR_Flag AS INT64) AS SR_Flag,
  CAST(Affiliated_base_number AS STRING) AS Affiliated_base_number
FROM `data-engineering-369507.trips_data_all.fhv_tripdata`;

-- Q3 Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num
CREATE OR REPLACE TABLE `data-engineering-369507.trips_data_all.fhv_partitioned_tripdata`
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS (
  SELECT * FROM `data-engineering-369507.trips_data_all.fhv_tripdata`
);

SELECT count(*) FROM  `taxi-rides-ny.nytaxi.fhv_nonpartitioned_tripdata`
WHERE dropoff_datetime BETWEEN '2019-01-01' AND '2019-03-31'
  AND dispatching_base_num IN ('B00987', 'B02279', 'B02060');


SELECT count(*) FROM `taxi-rides-ny.nytaxi.fhv_partitioned_tripdata`
WHERE dropoff_datetime BETWEEN '2019-01-01' AND '2019-03-31'
  AND dispatching_base_num IN ('B00987', 'B02279', 'B02060');
