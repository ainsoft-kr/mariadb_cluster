
RESET MASTER;

SET GLOBAL max_connections=1000;
SET GLOBAL gtid_strict_mode=ON;

CREATE USER 'maxroot'@'127.0.0.1' IDENTIFIED BY 'max-password';
CREATE USER 'maxroot'@'%' IDENTIFIED BY 'max-password';

GRANT ALL ON *.* TO 'maxroot'@'127.0.0.1' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'maxroot'@'%' WITH GRANT OPTION;

CREATE DATABASE IF NOT EXISTS `khealth` COLLATE 'utf8_general_ci';
CREATE DATABASE IF NOT EXISTS `khealth_dev` COLLATE 'utf8_general_ci';
CREATE DATABASE IF NOT EXISTS `testdb` COLLATE 'utf8_general_ci';

GRANT ALL PRIVILEGES ON khealth.* TO 'khealth_db_user'@'%' IDENTIFIED BY 'khealth_db_password';
GRANT ALL PRIVILEGES ON khealth.* TO 'khealth_db_user'@'localhost' IDENTIFIED BY 'khealth_db_password';

GRANT ALL PRIVILEGES ON khealth_dev.* TO 'khealth_dev_user'@'%' IDENTIFIED BY 'khealth_dev_password';
GRANT ALL PRIVILEGES ON khealth_dev.* TO 'khealth_dev_user'@'localhost' IDENTIFIED BY 'khealth_dev_password';

GRANT ALL PRIVILEGES ON testdb.* TO 'testdb_user'@'%' IDENTIFIED BY 'test_password';
GRANT ALL PRIVILEGES ON testdb.* TO 'testdb_user'@'localhost' IDENTIFIED BY 'test_password';

-- flush privileges;
FLUSH PRIVILEGES;
