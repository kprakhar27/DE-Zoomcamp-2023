python Spark_SQL_Args.py --input_green=data/pq/green/2020/*/ --input_yellow=data/pq/yellow/2020/*/ --output=data/report-2020

URL="spark://KUMAR-PRAKHAR.:7077"

spark-submit \
    --master="${URL}" \
    Spark_SQL_Args.py \
        --input_green=data/pq/green/2021/*/ \
        --input_yellow=data/pq/yellow/2021/*/ \
        --output=data/report-2021