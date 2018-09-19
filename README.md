# Sync data from Postgres to an ElasticSearch instance using Logstash

This is a prove of concept, it propagates
updates and new records in a postgres sql table to
an ElasticSearch instance.

The rational for this approach is to decouple the
access/search layer (ES) from the write database layer (Postgres) in a 
microservice environemnt.

That is: 
1. all the ops should be executed against the postgres db.
2. All the search operation should be executed against the ElasticSearch instance.

With the current settings, logstash will check the db every minute for record updates or new inserts 
in the `store.films` table on Postgres.

You can change these settings by editing `src\sync-es.conf`

## Requirements

Docker and Docker-compose 


## Run the services

Clone the project in a folder of your choice and execute the command:

```
make start
```

The command above will start the following containers:

1. postgres database with DDL executed from the ./sql/001.sql folder. Database
is available at `localhost:5432`, or within the docker network at `db:5432`
2. an empty ElasticSearch, available at `localhost:9200`, or within the docker network at `elasticsearch:9200`
3. an container running logstash. Logstash will check the db for updates. If updates are found, records are upserted in ElasticSearch.


## Test the results

Update and add some records to Postgres
```
make run-updates
make run-inserts
```
Wait 5 minutes then issue:

```
curl localhost:9200/store/_search?pretty
```

You should now have 8 udpated documents.