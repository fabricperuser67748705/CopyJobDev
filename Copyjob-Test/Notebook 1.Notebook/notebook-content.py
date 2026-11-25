# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "883836dd-0acc-4e68-a801-99dbd1e026d8",
# META       "default_lakehouse_name": "datafactory_lakehouse",
# META       "default_lakehouse_workspace_id": "1afc3984-afc2-4943-b631-dfa1f74f1f2e",
# META       "known_lakehouses": [
# META         {
# META           "id": "883836dd-0acc-4e68-a801-99dbd1e026d8"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Mapping of parquet files to table names
file_table_mapping = {
    "Files/part-00000-29741df6-8120-43d8-87b9-cde998ce283d-c000.snappy.parquet": "green_tripdata_2020",
    "Files/part-00000-8601e1f7-764e-4adb-908e-55bb04c295bf-c000.snappy.parquet": "green_tripdata_2021",
    "Files/part-00000-90045a1e-33b0-441f-a499-ad290b5d7c1f-c000.snappy.parquet": "green_tripdata_2019",
    "Files/part-00000-907cea6d-0f54-4639-9a14-042dc04185ef-c000.snappy.parquet": "green_tripdata_2017",
    "Files/part-00000-93b796dc-08a7-425c-a8a7-f91632812ae9-c000.snappy.parquet": "green_tripdata_2022",
    "Files/part-00000-d0796a0d-acb6-427f-a974-ccad81f964da-c000.snappy.parquet": "green_tripdata_2018"
}

# Loop through all mappings
for file_path, table_name in file_table_mapping.items():
    print(f"Loading {file_path} -> {table_name}")

    # Read parquet file
    df = spark.read.parquet(file_path)

    # Write as Delta Lakehouse table
    df.write.format("delta") \
        .mode("overwrite") \
        .saveAsTable(table_name)

    print(f"Created table: {table_name}")

print("All parquet files loaded successfully.")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
