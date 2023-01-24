# Week 1 Homework - Docker and SQL

## Question 1. Knowing docker tags
```bash
docker build --help
```
### Answer: --iidfile string

## Question 2. Understanding docker first run
```bash
docker run -it --entrypoint=bash python:3.9
```
run inside docker bash
```bash
pip list
```
### Answer: 3

## Prepare Postgres
### Create Network
```bash
docker network create pg-network
```
### Run Postgres
```bash
docker run -it \
 -e POSTGRES_USER="root" \
 -e POSTGRES_PASSWORD="root" \
 -e POSTGRES_DB="ny_taxi" \
 -v C:/Users/kumar/Documents/GitHub/DE-Zoomcamp-2023/1_docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data \
 -p 5432:5432 \
 --network=pg-network \
 --name pg-database \
 postgres:13
```
### Run pgAdmin
```bash
docker run -it \
 -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
 -e PGADMIN_DEFAULT_PASSWORD="root" \
 -p 8081:80 \
 --network=pg-network \
 --name pgadmin \
 dpage/pgadmin4
```
### Set URL in env
```bash
URL=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-01.csv.gz
```
### Python Ingestion Script (optional)
```bash
python ingest_data.py \
--user=root \
--password=root \
--host=localhost \
--port=5433 \
--db=ny_taxi \
--table_name=yellow_taxi_trips \
--url=${URL}
```
### Build Docker Ingestion Script
```bash
docker build -t taxi_ingest:v001 .
```
### Run Docker Ingestion Script
```bash
docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pg-database \
    --port=5432 \
    --db=ny_taxi \
    --table_name=green_taxi_trips \
    --url=${URL}
```
### Get Zones Data
```bash
wget https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv
```
> Note: Use Jupyter Notebook [upload-data.ipynb]() for ingesting `taxi+_zone_lookup.csv` Data

## Question 3 - 6
> Run notebook [Postgres Homework.ipynb]()