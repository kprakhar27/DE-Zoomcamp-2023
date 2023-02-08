-- Create a external table for for-hire vehicles for the year 2019
CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-2023-375817.trips_data_all.fhv_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dtc_data_lake_de-zoomcamp-2023-375817/raw/fhv_tripdata/2019/fhv_tripdata_2019-*.parquet']
);

-- Q1 What is the count for fhv vehicle records for year 2019?
SELECT COUNT(*) FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_tripdata`;

-- Create a nonpartitioned table for for-hire vehicles for the year 2019
CREATE OR REPLACE TABLE `de-zoomcamp-2023-375817.trips_data_all.fhv_nonpartitioned_tripdata`
AS SELECT * FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_tripdata`;

-- Q2 How many distinct Affiliated_base_number we have in fhv for 2019?
SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_tripdata`;

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_nonpartitioned_tripdata`;

-- Q3 How many records have both a blank (null) PUlocationID and DOlocationID in the entire dataset?
SELECT COUNT(*) FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_tripdata`
WHERE `PUlocationID`is NULL AND `DOlocationID`is NULL;

-- Q4 What is the best strategy to optimize the table if query always filter by pickup_datetime and order by affiliated_base_number?
CREATE OR REPLACE TABLE `de-zoomcamp-2023-375817.trips_data_all.fhv_partitioned_tripdata`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY Affiliated_base_number AS (
  SELECT * FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_tripdata`
);

-- Q5 Write a query to retrieve the distinct affiliated_base_number between pickup_datetime 03/01/2019 and 03/31/2019 (inclusive)
SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM  `de-zoomcamp-2023-375817.trips_data_all.fhv_nonpartitioned_tripdata`
WHERE pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31';

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `de-zoomcamp-2023-375817.trips_data_all.fhv_partitioned_tripdata`
WHERE pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31';