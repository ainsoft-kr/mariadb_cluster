# Global parameters
#
# Complete list of configuration options:
# https://mariadb.com/kb/en/mariadb-maxscale-24-mariadb-maxscale-configuration-guide/

[maxscale]
threads=auto

# Server definitions
#
# Set the address of the server to the network
# address of a MariaDB server.
#

[master]
type=server
address=${MASTER_IP_ADDRESS}
port=4001
protocol=MariaDBBackend

[slave1]
type=server
address=${SLAVE1_IP_ADDRESS}
port=4002
protocol=MariaDBBackend

[slave2]
type=server
address=${SLAVE2_IP_ADDRESS}
port=4003
protocol=MariaDBBackend

# Monitor for the servers
# This will keep MaxScale aware of the state of the servers.
# MySQL Monitor documentation:
# https://github.com/mariadb-corporation/MaxScale/blob/2.3/Documentation/Monitors/MariaDB-Monitor.md

[MariaDB-Monitor]
type=monitor
module=mariadbmon
servers=master,slave1,slave2
user=${MASTER_USER}
password=${MASTER_ROOT_PASSWORD}
failcount=3
backend_connect_timeout=3
backend_write_timeout=3
backend_read_timeout=3
auto_failover=true
auto_rejoin=true
enforce_read_only_slaves=1

# Service definitions
# Service Definition for a read-only service and a read/write splitting service.

[Galera-Monitor]
type=monitor
module=galeramon
disable_master_failback=1
servers=master,slave1,slave2
user=${MASTER_USER}
password=${MASTER_ROOT_PASSWORD}
monitor_interval=5000

# ReadConnRoute documentation:
# https://github.com/mariadb-corporation/MaxScale/blob/2.3/Documentation/Routers/ReadConnRoute.md

[Read-Only-Service]
type=service
router=readconnroute
servers=master,slave1,slave2
user=${MASTER_USER}
password=${MASTER_ROOT_PASSWORD}
router_options=slave

# ReadWriteSplit documentation:
# https://github.com/mariadb-corporation/MaxScale/blob/2.3/Documentation/Routers/ReadWriteSplit.md

[Read-Write-Service]
type=service
router=readwritesplit
servers=master,slave1,slave2
user=${MASTER_USER}
password=${MASTER_ROOT_PASSWORD}
master_failure_mode=fail_on_write

[CLI-Service]
type=service
router=cli


# Listener definitions for the services
# Listeners represent the ports the services will listen on.

[Read-Only-Listener]
type=listener
service=Read-Only-Service
protocol=MariaDBClient
# protocol=MariaDBBackend
port=4008

[Read-Write-Listener]
type=listener
service=Read-Write-Service
protocol=MariaDBClient
# protocol=MariaDBBackend
port=4006

[CLI-Listener]
type=listener
service=CLI-Service
protocol=maxscaled
port=4009
