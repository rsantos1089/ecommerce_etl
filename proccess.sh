#install pandas library
pip install pandas==2.2.3

#install python test library
pip install pytest==8.3.4

#pull postgres images
#docker pull postgres:13
#docker run --name postgres-db -p 5432:5432 -e POSTGRES_PASSWORD=admin123 -d postgres

#pull airflow images from docker-compose https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html
cd airflow
docker build . --tag extending-airflow:latest
docker-compose up -d
