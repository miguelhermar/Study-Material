from pyspark.sql import SparkSession

def create_session():
    #creates spark session
    spark = SparkSession.builder.appName('spark-app').getOrCreate()
    return spark

def load_data(spark):
    df = spark.read.format("csv").option("header",True).option("inferSchema",True).load("trip_yellow_taxi.csv")

    df.createOrReplaceTempView("taxi_data")
    spark.sql("select * from taxi_data where RatecodeID=4").show(5)
    groupby = spark.sql("select payment_type, count(*) as payment_type_count from taxi_data group by payment_type ")
    groupby.show()
    
    print(f"Number of rows in GroupBy SQL query: {groupby.count()}")


def main():
    spark_sess = create_session()
    load_data(spark_sess)

main()


#spark-submit --deploy-mode client --master "local[2]" --py-files "/Users/miguelhermar/Desktop/Study Material/PySpark/taxi-exercise.py" taxi-exercise.py