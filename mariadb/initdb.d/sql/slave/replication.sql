
RESET MASTER;

SET GLOBAL max_connections=1000;
SET GLOBAL gtid_strict_mode=ON;

CHANGE MASTER TO MASTER_HOST='master', MASTER_PORT=3306, MASTER_USER='root', MASTER_PASSWORD='^qT%XAR%Vzv6gI7V', MASTER_USE_GTID=slave_pos;

START SLAVE;
