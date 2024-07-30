from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 5, 19),
    'email_on_failure': False,
    'email_on_retry': False,
}

dag = DAG(
    '11dbt_models',
    default_args=default_args,
    description='DAG для запуска моделей dbt',
    schedule_interval=timedelta(minutes=1),
)

# Список моделей
models = [
    'hub_Projects.sql',
    'lnk_Projects.sql',
    'sat_Projects.sql'
]
dbt_snapshot = BashOperator(
    task_id='dbt_snapshot',
    bash_command='cd /Users/my_project && dbt snapshot',
    dag=dag
)

tasks = {}
for model in models:
    task_id = model.lower().replace('.sql', '')
    tasks[task_id] = BashOperator(
        task_id=task_id,
        bash_command=f'cd /Users/air/my_project && dbt run --select {model}',
        dag=dag
    )

for task in tasks.values():
    dbt_snapshot >> task
