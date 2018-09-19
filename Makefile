export PGPASSWORD=dummy

start-dbs:
	docker-compose up -d --build db elasticsearch 

start-logstash:
	docker-compose up --build logstash

start: start-dbs start-logstash

run-updates:
	PGPASSWORD=dummy psql -h localhost -p 5432 -U dummy  -d ddb -f ./src/scripts/update.sql

run-inserts:
	PGPASSWORD=dummy psql -h localhost -p 5432 -U dummy  -d ddb -f ./src/scripts/insert.sql

stop:
	docker-compose down --remove-orphans
