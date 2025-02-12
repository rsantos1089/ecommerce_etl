import pandas as pd

df_products = pd.read_csv('airflow/dags/data/products.csv', sep=',')
df_orders = pd.read_csv('airflow/dags/data/orders.csv', sep=',')
df_order_items = pd.read_csv('airflow/dags/data/order_items.csv', sep=',')
print(df_orders)