### Linux Server Health Monitoring Script

A lightweight Bash script for monitoring system performance and gathering essential server information in real-time.

#### Features

* Real-time system metrics monitoring (CPU, Memory, Disk usage)
* Security monitoring (Failed login attempts, Active user sessions)
* System information display (OS version, Uptime, Load average)
* Interactive color-coded menu interface
* Modular design with separate functions for each metric
* Error handling and graceful fallbacks

#### Prerequisites

* Linux-based operating system
* Bash shell
* Basic system utilities (top, ps, free, df, grep)

#### Installation

```bash
git clone https://github.com/demirciahmet/linux-server-monitor.git
cd linux-server-monitor
chmod +x server_monitor.sh
./server_monitor.sh
```