DATA_LIST = master slave1 slave2

.PHONY: init-data init-conf clear-data build

init: init-data init-conf clear-data

init-data:
	for name in $(DATA_LIST); do \
		if test -d ./mariadb/data/$$name; then \
			echo "The directory is already created! : $$name" ; \
		else \
			mkdir -p ./mariadb/data/$$name; \
			echo "The directory is not newly created : $$name" ; \
		fi ; \
	done

init-conf:
	if test -f ./mariadb/env; then \
		echo "The env file is existing!" ; \
	else \
		cp ./mariadb/env.sample ./mariadb/env ; \
		echo "The env file is created! set the value for variables" ; \
	fi ; \
	bash -c 'set -o allexport; source ./mariadb/env; envsubst < ./mariadb/initdb.d/sql/master/initdb.tpl > ./mariadb/initdb.d/sql/master/initdb.sql'
	bash -c 'set -o allexport; source ./mariadb/env; envsubst < ./mariadb/initdb.d/sql/slave/replication.tpl > ./mariadb/initdb.d/sql/slave/replication.sql'
	bash -c 'set -o allexport; source ./mariadb/env; envsubst < ./maxscale/maxscale.cnf.d/conf.tpl > ./maxscale/maxscale.cnf.d/jungto.cnf'

clear-data:
	for name in $(DATA_LIST); do \
		if test -d ./mariadb/data/$$name; then \
			rm -rf ./mariadb/data/$$name/*; \
			echo "The data is cleared! : $$name" ; \
		else \
			echo "The directory does not contain any data : $$name" ; \
		fi ; \
	done

build:
	docker compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml build

up:
	docker compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml up -d

down:
	docker compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml down

ps:
	docker compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml ps

rm:
	docker compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml rm

conf:
	docker compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml config

logs:
	docker-compose -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml logs $(name)
