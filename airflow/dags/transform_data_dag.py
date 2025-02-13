from airflow.models import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime
from airflow.operators.dummy import DummyOperator

with DAG('transform_data_dag',
         schedule_interval='@daily',
         start_date=datetime(2025,1,1),
         catchup=False) as dag:

    start = DummyOperator(task_id='start')

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dags/dbt/postgres_project && dbt run'
    )

    end = DummyOperator(task_id='end')

    start >> dbt_run >> end


