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

docker exec -it 2fa454942400 psql -U postgres

docker run --name postgres-db -p 5433:5432 -e POSTGRES_USER=airflow -e POSTGRES_PASSWORD=airflow -e POSTGRES_DB=airflow -d postgres