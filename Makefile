DATA_LIST = master slave1 slave2

.PHONY: create-network init-data init-dev-conf clear-data build

init: init-data init-prod-conf clear-data create-network

init-dev: init-data init-dev-conf clear-data create-network

init-data:
	for name in $(DATA_LIST); do \
		if test -d ./mariadb/data/$$name; then \
			echo "The directory is already created! : $$name" ; \
		else \
			mkdir -p ./mariadb/data/$$name; \
			echo "The directory is not newly created : $$name" ; \
		fi ; \
	done

init-dev-conf:
	bash -c 'set -o allexport; source ./env/mariadb/dev_env; envsubst < ./mariadb/initdb.d/sql/master/initdb.tpl > ./mariadb/initdb.d/sql/master/initdb.sql'
	bash -c 'set -o allexport; source ./env/mariadb/dev_env; envsubst < ./mariadb/initdb.d/sql/slave/replication.tpl > ./mariadb/initdb.d/sql/slave/replication.sql'
	bash -c 'set -o allexport; source ./env/mariadb/dev_env; envsubst < ./maxscale/maxscale.cnf.d/conf.tpl > ./maxscale/maxscale.cnf.d/jungto.cnf'

init-prod-conf:
	bash -c 'set -o allexport; source ./env/mariadb/prod_env; envsubst < ./mariadb/initdb.d/sql/master/initdb.tpl > ./mariadb/initdb.d/sql/master/initdb.sql'
	bash -c 'set -o allexport; source ./env/mariadb/prod_env; envsubst < ./mariadb/initdb.d/sql/slave/replication.tpl > ./mariadb/initdb.d/sql/slave/replication.sql'
	bash -c 'set -o allexport; source ./env/mariadb/prod_env; envsubst < ./maxscale/maxscale.cnf.d/conf.tpl > ./maxscale/maxscale.cnf.d/jungto.cnf'

clear-data:
	for name in $(DATA_LIST); do \
		if test -d ./mariadb/data/$$name; then \
			rm -rf ./mariadb/data/$$name/*; \
			echo "The data is cleared! : $$name" ; \
		else \
			echo "The directory does not contain any data : $$name" ; \
		fi ; \
	done

create-network:
	docker network create jts-network

build:
	docker compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml build

up:
	docker compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml up -d

down:
	docker compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml down

ps:
	docker compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml ps

rm:
	docker compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml rm

conf:
	docker compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml config

logs:
	docker-compose --env-file ./env/docker/prod_env -f ./mariadb/docker-compose.prod.yml -f ./maxscale/docker-compose.prod.yml logs $(name)


dev-build:
	docker compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml build

dev-up:
	docker compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml up -d

dev-down:
	docker compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml down

dev-ps:
	docker compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml ps

dev-rm:
	docker compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml rm

dev-conf:
	docker compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml config

dev-logs:
	docker-compose --env-file ./env/docker/dev_env -f ./mariadb/docker-compose.yml -f ./maxscale/docker-compose.yml logs $(name)
