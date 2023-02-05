## Data Warehouse and BigQuery
[Slides](https://docs.google.com/presentation/d/1a3ZoBAXFk8-EhUsd7rAZd-5p_HpltkzSeujjRGB2TAI/edit?usp=sharing)  
[Big Query basic SQL](big_query.sql)

### Data Warehouse
[Data Warehouse and BigQuery](https://youtu.be/jrHljAoD6nM)

### Partitoning and clustering
[Partioning and Clustering](https://youtu.be/jrHljAoD6nM?t=726)  
[Partioning vs Clustering](https://youtu.be/-CqXf7vhhDs)  

### Best practices
[BigQuery Best Practices](https://youtu.be/k81mLJVX08w)  

### Internals of BigQuery
[Internals of Big Query](https://youtu.be/eduHi1inM4s)  

### Advance
#### ML
[BigQuery Machine Learning](https://youtu.be/B-WtpB0PuG4)  
[SQL for ML in BigQuery](big_query_ml.sql)

**Important links**
- [BigQuery ML Tutorials](https://cloud.google.com/bigquery-ml/docs/tutorials)
- [BigQuery ML Reference Parameter](https://cloud.google.com/bigquery-ml/docs/analytics-reference-patterns)
- [Hyper Parameter tuning](https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-create-glm)
- [Feature preprocessing](https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-preprocess-overview)

##### Deploying ML model
[BigQuery Machine Learning Deployment](https://youtu.be/BjARzEWaznU)  
[Steps to extract and deploy model with docker](extract_model.md)  


### [Workshop](airflow.md)

- [Integrating Bigquery with Airflow (+ Week 2 Review) - Video](https://www.youtube.com/watch?v=lAxAhHNeGww&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=31)

- Setup:
  Copy over the `airflow` directory (i.e. the Dockerized setup) from `week_2_data_ingestion`:
  ```
  cp ../week_2_data_ingestion/airflow airflow
  ```
  Also, empty the `logs` directory, if you find it necessary.

- DAG: [gcs_to_bq_dag.py](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/week_3_data_warehouse/airflow/dags/gcs_to_bq_dag.py)


### [Homework](homework.md)


## Community notes

Did you take notes? You can share them here.

* [Notes by Alvaro Navas](https://github.com/ziritrion/dataeng-zoomcamp/blob/main/notes/3_data_warehouse.md)
* [Isaac Kargar's blog post](https://kargarisaac.github.io/blog/data%20engineering/jupyter/2022/01/30/data-engineering-w3.html)
* Add your notes here (above this line)
