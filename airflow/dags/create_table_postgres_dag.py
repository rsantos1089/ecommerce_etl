from airflow.models import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.operators.python import PythonOperator
from airflow.operators.dummy import DummyOperator
from datetime import datetime
import pandas as pd
from sqlalchemy import create_engine


def write_raw_data(path,schema, table_name):
    df = pd.read_csv(path, sep=',')

    postgres_conn_id = 'postgres'
    engine = create_engine('postgresql+psycopg2://postgres:postgres@postgres:5432/airflow')
    df.to_sql(table_name, schema=schema,con=engine, if_exists='replace', index=False)

with DAG('create_table_postgres_dag',
         schedule_interval='@daily',
         start_date=datetime(2025,1,1),
         catchup=False) as dag:

    start = DummyOperator(task_id='start')

    create_tables_model = SQLExecuteQueryOperator(
        task_id='create_tables_model',
        conn_id='postgres',
        sql='sql/create_tables.sql'
    )

    create_tables_raw_products = PythonOperator(
        task_id = 'create_tables_raw_products',
        python_callable=write_raw_data,
        op_kwargs={'path': '/opt/airflow/dags/data/products.csv','schema': 'raw','table_name': 'products'},
        provide_context=True
    )

    create_tables_raw_orders = PythonOperator(
        task_id='create_tables_raw_orders',
        python_callable=write_raw_data,
        op_kwargs={'path': '/opt/airflow/dags/data/orders.csv','schema': 'raw','table_name': 'orders'},
        provide_context=True
    )

    create_tables_raw_order_items = PythonOperator(
        task_id='create_tables_raw_order_items',
        python_callable=write_raw_data,
        op_kwargs={'path': '/opt/airflow/dags/data/order_items.csv','schema': 'raw', 'table_name': 'order_items'},
        provide_context=True
    )

    end = DummyOperator(task_id='end')


    start >> create_tables_model >> [create_tables_raw_products,create_tables_raw_orders,create_tables_raw_order_items] >> end