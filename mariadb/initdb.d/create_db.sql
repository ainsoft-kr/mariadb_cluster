

# CREATE DATABASE IF NOT EXISTS `dev_db_1` COLLATE 'utf8_general_ci' ;
# GRANT ALL ON `dev_db_1`.* TO 'default'@'%' ;

# CREATE DATABASE IF NOT EXISTS `dev_db_2` COLLATE 'utf8_general_ci' ;
# GRANT ALL ON `dev_db_2`.* TO 'default'@'%' ;

# CREATE DATABASE IF NOT EXISTS `dev_db_3` COLLATE 'utf8_general_ci' ;
# GRANT ALL ON `dev_db_3`.* TO 'default'@'%' ;



# create databases
CREATE DATABASE IF NOT EXISTS article;
CREATE DATABASE IF NOT EXISTS farmer;
CREATE DATABASE IF NOT EXISTS transport;

GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%' IDENTIFIED BY 'mysql';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'localhost' IDENTIFIED BY 'mysql';

# create root user and grant rights
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';

GRANT CREATE, ALTER, INDEX, LOCK TABLES, REFERENCES, UPDATE, DELETE, DROP, SELECT, INSERT ON *.* TO 'user'@'%';

FLUSH PRIVILEGES;

