from airflow.models import DAG
from datetime import datetime
import pandas as pd
from sqlalchemy import create_engine


def read_data_csv(path,table_name):
    df = pd.read_csv(path,sep=',')

    postgres_conn_id = 'postgres'
    engine = create_engine('postgresql+psycopg2://postgres:postgres@postgres:5432/airflow')
    df.to_sql(table_name,con=engine,if_exists='replace',index=False)


with DAG('populate_data_dag',
         schedule_interval='@daily',
         start_date=datetime(2025,1,1),
         catchup=False) as dag:

    x
