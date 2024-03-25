from pyspark.sql import SparkSession
import pandas as pd

def create_session():
    #creates spark session
    spark = SparkSession.builder.appName('spark-app').getOrCreate()
    return spark

def load_data(spark):
    # Read the Excel file into a Pandas DataFrame
    pandas_df = pd.read_excel('trip_yellow_taxi.xlsx')
    pandas_df = pandas_df.dropna(how='all')

    # Convert the Pandas DataFrame to a PySpark DataFrame
    spark_df = spark.createDataFrame(pandas_df)
    spark_df.show(5)
    
    #Registering Temp View
    spark_df.createOrReplaceTempView("trips_data")
    #Applying SQL query to extract result
    transform_df = spark.sql("select * from trips_data where passenger_count>2")
#     pandas_df.filter(pandas_df['passenger_count']>2.0)
    print(f"Number of rows in SQL query: {transform_df.count()}")
    
def main():
    spark_sess = create_session()
    load_data(spark_sess)

main()


#spark-submit --deploy-mode client --master "local[2]" --py-files "/Users/miguelhermar/Desktop/Study Material/PySpark/spark-test.py" spark-test.py