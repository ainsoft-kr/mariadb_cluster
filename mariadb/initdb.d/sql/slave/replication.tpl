
RESET MASTER;

SET GLOBAL max_connections=1000;
SET GLOBAL gtid_strict_mode=ON;

CHANGE MASTER TO MASTER_HOST='master', MASTER_PORT=3306, MASTER_USER='root', MASTER_PASSWORD='${MARIADB_ROOT_PASSWORD}', MASTER_USE_GTID=slave_pos;

START SLAVE;


CREATE USER '${MASTER_USER}'@'127.0.0.1' IDENTIFIED BY '${MASTER_ROOT_PASSWORD}';
CREATE USER '${MASTER_USER}'@'%' IDENTIFIED BY '${MASTER_ROOT_PASSWORD}';

GRANT ALL ON *.* TO '${MASTER_USER}'@'127.0.0.1' WITH GRANT OPTION;
GRANT ALL ON *.* TO '${MASTER_USER}'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;