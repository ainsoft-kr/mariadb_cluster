# Global parameters
#
# Complete list of configuration options:
# https://mariadb.com/kb/en/mariadb-maxscale-24-mariadb-maxscale-configuration-guide/

# [maxscale]
# threads=auto

# Server definitions
#
# Set the address of the server to the network
# address of a MariaDB server.
#

[master]
type=server
address=${MASTER_IP_ADDRESS}
port=${MASTER_IP_PORT}
protocol=MariaDBBackend

[slave1]
type=server
address=${SLAVE1_IP_ADDRESS}
port=${SLAVE1_IP_PORT}
protocol=MariaDBBackend

[slave2]
type=server
address=${SLAVE2_IP_ADDRESS}
port=${SLAVE2_IP_PORT}
protocol=MariaDBBackend

# Monitor for the servers
# This will keep MaxScale aware of the state of the servers.
# MySQL Monitor documentation:
# https://github.com/mariadb-corporation/MaxScale/blob/2.3/Documentation/Monitors/MariaDB-Monitor.md

[MariaDB-Monitor]
type=monitor
module=mariadbmon
servers=master,slave1,slave2
disk_space_check_interval=1000
disk_space_threshold=/:85
detect_replication_lag=true
enforce_read_only_slaves=true
failcount=3
auto_failover=1
auto_rejoin=true
monitor_interval=300
user=root
password=${MARIADB_ROOT_PASSWORD}
backend_connect_timeout=3s
backend_write_timeout=3s
backend_read_timeout=3s
auto_failover=true
auto_rejoin=true
# replication_password=5349E1268CC4AF42B919A42C8E52D185
# replication_user=rpl_user


# [Galera-Monitor]
# type=monitor
# module=galeramon
# disable_master_failback=1
# servers=master,slave1,slave2
# user=root
# password=${MARIADB_ROOT_PASSWORD}
# monitor_interval=5000ms


# Service definitions
# Service Definition for a read-only service and a read/write splitting service.

# ReadConnRoute documentation:
# https://github.com/mariadb-corporation/MaxScale/blob/2.3/Documentation/Routers/ReadConnRoute.md

[Read-Only-Service]
type=service
router=readconnroute
servers=master,slave1,slave2
user=root
password=${MARIADB_ROOT_PASSWORD}
router_options=slave

# ReadWriteSplit documentation:
# https://github.com/mariadb-corporation/MaxScale/blob/2.3/Documentation/Routers/ReadWriteSplit.md

[Read-Write-Service]
type=service
router=readwritesplit
servers=master,slave1,slave2
user=root
password=${MARIADB_ROOT_PASSWORD}
master_failure_mode=fail_on_write

# [CLI-Service]
# type=service
# router=cli


# Listener definitions for the services
# Listeners represent the ports the services will listen on.

[Read-Only-Listener]
type=listener
service=Read-Only-Service
protocol=MariaDBClient
address=maxscale
port=4008

[Read-Write-Listener]
type=listener
service=Read-Write-Service
protocol=MariaDBClient
address=maxscale
port=4006

# [CLI-Listener]
# type=listener
# service=CLI-Service
# protocol=maxscaled
# port=4009
