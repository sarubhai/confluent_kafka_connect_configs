DEMO 1: (Oracle) ^Takes 10 mins for change capture from source to reflect
================
# Connect to Oracle Source
# SELECT * FROM ORCL_USER.CONSULTANTS;
# Incremental Data
file='1b_src-orcl-jdbc-incr-consultants.json'
cname='src-orcl-jdbc-incr-consultants'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .

# Connect to Oracle Source
# SELECT * FROM ORCL_USER.CONSULTANTS;
# CDC Data
file='1c_src-orcl-oracle-cdc-consultants.json'
cname='src-orcl-oracle-cdc-consultants'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .


# INSERT INTO ORCL_USER.CONSULTANTS (FIRST_NAME, LAST_NAME, EMAIL, RATE, STATUS) VALUES ('Saurav', 'Mitra', 'saurav.mitra@ashnik.com', 5000.00, 'perm');
# INSERT INTO ORCL_USER.CONSULTANTS (FIRST_NAME, LAST_NAME, EMAIL, RATE, STATUS) VALUES ('Tim', 'Smith', 'tim.smith@freelance.com', 3500.70, 'contract');
# INSERT INTO ORCL_USER.CONSULTANTS (FIRST_NAME, LAST_NAME, EMAIL, RATE, STATUS) VALUES ('Shane', 'Wilson', 'shane.wilson@freelance.com', 5000.00, 'perm');
# INSERT INTO ORCL_USER.CONSULTANTS (FIRST_NAME, LAST_NAME, EMAIL, RATE, STATUS) VALUES ('John', 'Sinha', 'john.sinha@freelance.com', 9000.00, 'contract');
# COMMIT;
# UPDATE ORCL_USER.CONSULTANTS SET RATE=6100.25 WHERE EMAIL='saurav.mitra@ashnik.com';
# COMMIT;
# DELETE FROM ORCL_USER.CONSULTANTS WHERE EMAIL='tim.smith@freelance.com';
# COMMIT;



# Connect to Oracle Target
# SELECT * FROM ORCL_USER.CONSULTANTS;
file='9_1b_tgt-orcl-jdbc-upsert-consultants.json'
cname='tgt-orcl-jdbc-upsert-consultants'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .

# SELECT * from ORCL_USER.CONSULTANTS1;
file='9_1c_tgt-orcl-jdbc-upsert-consultants1.json'
cname='tgt-orcl-jdbc-upsert-consultants1'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .



DEMO 2: (PostgreSQL)
====================
# Connect to Postgres Source
# SELECT * FROM public.consultants;
file='2c_src-pg-debezium-cdc-consultants.json'
cname='src-pg-debezium-cdc-consultants'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .
# INSERT INTO consultants(first_name, last_name, email, rate, status) VALUES ('Saurav', 'Mitra', 'saurav.karate@gmail.com', 5000.00, 'perm');
# INSERT INTO consultants(first_name, last_name, email, rate, status) VALUES ('Tim', 'Smith', 'tim.smith@freelance.com', 3500.70, 'contract');
# INSERT INTO consultants(first_name, last_name, email, rate, status) VALUES ('Shane', 'Wilson', 'shane.wilson@freelance.com', 5000.00, 'perm');
# INSERT INTO consultants(first_name, last_name, email, rate, status) VALUES ('John', 'Sinha', 'john.sinha@freelance.com', 9000.00, 'contract');
# UPDATE consultants SET rate=6100.25 WHERE email='saurav.karate@gmail.com';
# DELETE FROM consultants WHERE email='tim.smith@freelance.com';


# Connect to Postgres Target
# SELECT * FROM public.consultants1;
file='9_2c_tgt-pg-jdbc-upsert-consultants1.json'
cname='tgt-pg-jdbc-upsert-consultants1'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .


# Check Kibana DevTools (http://10.0.1.100:5601/app/dev_tools#/console)
# GET _cat/indices
# GET consultants/_search
# GET consultants/_doc/11
# GET consultants/_doc/12
file='9_2c_tgt-elk-elastic-upsert-consultants.json'
cname='tgt-elk-elastic-upsert-consultants'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .



DEMO 3: (MySQL)
===============
# Connect to MySQL
# SELECT * FROM product order by 1 desc;
file='3c_src-mysql-debezium-cdc-product.json'
cname='src-mysql-debezium-cdc-product'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .
# INSERT INTO product(code,category,make,model,year,color,price,currency,update_date,create_date) VALUES ('101-101','High','Ferrari','F1',2021,'Red',500000,'USD',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
# INSERT INTO product(code,category,make,model,year,color,price,currency,update_date,create_date) VALUES ('101-102','High','Ferrari','F2',2021,'Yellow',400000,'USD',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
# UPDATE product SET color='Black' WHERE code='101-101';
# DELETE FROM product WHERE code='101-101';


# Connect to Postgres Target
# SELECT * FROM public.product order by 1 desc;
file='9_3c_tgt-pg-jdbc-upsert-product.json'
cname='tgt-pg-jdbc-product'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .


# Connect to MongoDB
# mongo 127.0.0.1:27017/admin -u root -p ${db_password}
# show dbs
# use sales
# show collections
# db.product.count()
# db.product.find()
# db.product.find({code:"101-101"})

file='9_3c_tgt-mongo-mongo-upsert-product.json'
cname='tgt-mongo-mongo-upsert-product'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .


# Connect to Redis
# redis-cli -h 127.0.0.1 -p 6379 -a ${db_password} -n 1 FLUSHDB
# info keyspace
# redis-cli -h 127.0.0.1 -p 6379 -a ${db_password} -n 1
# keys *
# get "1"
# get "10"
# exit
file='9_3c_tgt-redis-redis-upsert-product.json'
cname='tgt-redis-redis-upsert-product'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .



DEMO 4: (MSSQL)
===============
# Connect to MSSQL Server
# SELECT * FROM SalesLT.Customer ORDER BY 1 DESC;
file='4c_src-mssql-debezium-cdc-customer.json'
cname='src-mssql-debezium-cdc-customer'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .
# INSERT INTO SalesLT.Customer(NameStyle,Title,FirstName,LastName,CompanyName,EmailAddress,Phone,PasswordHash,PasswordSalt) VALUE (0,'Mr.','Saurav','Mitra','Ashnik','saurav.karate@gmail.com','9238-7464','Qhl2fJL7w=','1KjXYs4=');
# UPDATE SalesLT.Customer SET Phone='101-101-1234' WHERE FirstName='Saurav';
# DELETE FROM SalesLT.Customer WHERE FirstName='Saurav';


# Connect to Postgres Target
# SELECT * FROM public.customer1 ORDER BY 1 DESC;
file='9_4c_tgt-pg-jdbc-upsert-customer1.json'
cname='tgt-pg-jdbc-upsert-customer1'
curl -k -s -X PUT -H "Content-Type: application/json" -d @${file} https://10.0.1.40:8083/connectors/${cname}/config | jq .



DEMO 5: (Twitter)
=================
# 1. Check Kafka Producer Code
# 2. Check Messages & Schema in tweets Topic

# Create Stream
CREATE STREAM stream_tweets (
  user_location STRING,
  user_followers_count INT,
  created_at STRING,
  tweet_text STRING
)
WITH (
  KAFKA_TOPIC='tweets',
  VALUE_FORMAT='JSON',
  TIMESTAMP='created_at',
  TIMESTAMP_FORMAT='yyyy-MM-dd HH:mm:ssz'
);

# Check Streaming Messages
SELECT * FROM stream_tweets EMIT CHANGES;

# No. of tweets by location with 60 Sec Tumbling Window
SELECT 
user_location,
COUNT(*) AS tweets
FROM stream_tweets
WINDOW TUMBLING (SIZE 60 SECOND)
GROUP BY user_location
HAVING COUNT(*) > 2
EMIT CHANGES;

# No. of influencer tweets by location with 600 Sec Session Window
SELECT 
user_location,
COUNT(*) AS tweets
FROM stream_tweets
WINDOW SESSION (600 SECONDS)
WHERE user_followers_count > 1000
GROUP BY user_location
HAVING COUNT(*) > 2
EMIT CHANGES;



ETL:
====
CREATE STREAM CDCORACLE_CONSULTANTS (ID DECIMAL(64,0), FIRST_NAME VARCHAR, LAST_NAME VARCHAR, EMAIL VARCHAR, RATE DOUBLE, STATUS VARCHAR, OP_TYPE VARCHAR) WITH ( kafka_topic='ORCL-CDC-ORCLPDB1-CONSULTANTS', PARTITIONS=1, REPLICAS=1, value_format='AVRO');

SELECT * FROM CDCORACLE_CONSULTANTS EMIT CHANGES;

CREATE STREAM WRITEOP_CONSULTANTS AS SELECT ID, FIRST_NAME, LAST_NAME, EMAIL, RATE, STATUS FROM CDCORACLE_CONSULTANTS WHERE OP_TYPE!='D' EMIT CHANGES;

SELECT * FROM WRITEOP_CONSULTANTS EMIT CHANGES;

CREATE STREAM DELETEOP_CONSULTANTS AS SELECT ID, FIRST_NAME, LAST_NAME, EMAIL, RATE, STATUS FROM CDCORACLE_CONSULTANTS WHERE OP_TYPE='D' EMIT CHANGES;

SELECT * FROM DELETEOP_CONSULTANTS EMIT CHANGES;


Misc:
SELECT ID, FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES_STREAM_DBZ_SRC EMIT CHANGES;
SELECT AFTER->ID AS ID, AFTER->FIRST_NAME AS FIRST_NAME, AFTER->LAST_NAME AS LAST_NAME, AFTER->EMAIL AS NEW_EMAIL FROM EMPLOYEES_STREAM_DBZ_SRC EMIT CHANGES;
SELECT OP, AFTER->ID, BEFORE->EMAIL AS EMAIL_BEFORE, AFTER->EMAIL AS EMAIL_AFTER FROM EMPLOYEES_STREAM_DBZ_SRC EMIT CHANGES;
SELECT TIMESTAMPTOSTRING(ROWTIME, 'yyyy-MM-dd HH:mm:ss Z'), OP, ROWTIME - SOURCE->TS_MS AS LAG_MS FROM EMPLOYEES_STREAM_DBZ_SRC EMIT CHANGES;
SELECT TIMESTAMPTOSTRING(ROWTIME, 'yyyy-MM-dd HH:mm:ss Z'), ROWTIME - UPDATE_TS AS LAG_MS FROM EMPLOYEES_STREAM_DBZ_SRC EMIT CHANGES;
