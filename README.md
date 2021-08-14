# Kafka Connect: Connector Configurations

Kafka Connect Source/Sink Connector configuration properties.

Kafka Connect is part of Apache Kafka, providing streaming integration between data stores and Kafka. Kafka Connect provids a very powerful way of handling integration requirements. Some key components include:

- Connectors: the JAR files that define how to integrate with the data store itself
- Converters: handling serialization and deserialization of data
- Transforms: optional in-flight manipulation of messages

SMT: [https://docs.confluent.io/platform/current/connect/transforms/overview.html#connect-transforms-supported](https://docs.confluent.io/platform/current/connect/transforms/overview.html#connect-transforms-supported)

There are various serialization formats with common ones as below:

- AvroConverter^ : io.confluent.connect.avro.AvroConverter
- ProtobufConverter^ : io.confluent.connect.protobuf.ProtobufConverter
- JsonSchemaConverter^: io.confluent.connect.json.JsonSchemaConverter
- JsonConverter : org.apache.kafka.connect.json.JsonConverter
- StringConverter : org.apache.kafka.connect.storage.StringConverter
- ByteArrayConverter : org.apache.kafka.connect.converters.ByteArrayConverter

^ use with Schema Registry

Kafka Connect includes two types of connectors:

- Source connector – Ingests entire databases and streams table updates to Kafka topics. A source connector can also collect metrics from all your application servers and store these in Kafka topics, making the data available for stream processing with low latency.
- Sink connector – Delivers data from Kafka topics into secondary indexes such as Elasticsearch, or batch systems such as Hadoop for offline analysis.

## Source Databases/Systems to Kafka Topic

- Oracle
- PostgreSQL
- MySQL
- MSSQL
- MongoDB
- File

## Kafka Topic to Target Databases/Sink Systems

- Oracle
- PostgresSQL
- MySQL
- MSSQL
- Elasticsearch
- MongoDB
- Redis
- File
