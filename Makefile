DATA_LIST = master slave1 slave2

.PHONY: build

init:
	for name in $(DATA_LIST); do \
		if test -d ./mariadb/data/$$name; then \
			echo "The directory is already created! : $$name" ; \
		else \
			mkdir -p ./mariadb/data/$$name; \
			echo "The directory is not newly created : $$name" ; \
		fi ; \
	done

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
