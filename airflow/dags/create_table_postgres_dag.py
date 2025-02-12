from airflow.models import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime

with DAG('my_postgres_dag',
         schedule_interval='@daily',
         start_date=datetime(2025,1,1),
         catchup=False) as dag:

    create_tables = SQLExecuteQueryOperator(
        task_id = 'create_tables',
        conn_id= 'postgres',
        sql='sql/create_tables.sql'
    )

    create_tables