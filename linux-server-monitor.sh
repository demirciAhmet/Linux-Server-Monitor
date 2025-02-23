#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
ROOT_DIR=$(dirname "$(dirname "$SCRIPT_DIR")")

. "$ROOT_DIR/common-script.sh"
. "$(dirname "$SCRIPT_DIR")/utility_functions.sh"

os_version() {
  clear
  echo "OS Version:"
  lsb_release -d 2>/dev/null || echo "Information not available"
  echo
}

uptime_info() {
  clear
  echo "Uptime:"
  uptime -p
  echo
}

load_average() {
  clear
  echo "Load Average:"
  uptime | awk -F'load average:' '{print $2}'
  echo
}

logged_in_users() {
  clear
  echo "Logged In Users:"
  who
  echo
}

failed_login_attempts() {
  clear
  echo "Failed Login Attempts:"
  grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l || echo "Log information not available"
  echo
}

cpu_usage() {
  clear
  echo "CPU Usage:"
  top -bn1 | grep "%Cpu" | awk '{print "User: "$2"% System: "$4"% Idle: "$8"%"}'
  echo
}

memory_usage() {
  clear
  echo "Memory Usage:"
  free -m | awk 'NR==2{printf "Used: %sMB Used: %sMB (%.2f%% used)\n", $2, $3, $3*100/$2}'
  echo
}

disk_usage() {
  clear
  echo "Disk Usage:"
  df -h --total | awk '/total/{printf "Total: %s Used: %s (%.2f%% used)\n", $2, $3, $5}'
  echo
}

top_cpu_processes() {
  clear
  echo "Top 5 Processes by CPU Usage:"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
  echo
}

top_memory_processes() {
  clear
  echo "Top 5 Processes by Memory Usage:"
  ps -eo pid,comm,%mem --sort=-%mem | head -n 6
  echo
}

show_performance_menu() {
    clear
    printf "%b\n" "${CYAN}=== Server Information ===${RC}"
    printf "%b\n" "1. OS Version"
    printf "%b\n" "2. Uptime"
    printf "%b\n" "3. Load Average"
    printf "%b\n" "4. Logged In Users"
    printf "%b\n" "5. Failed Login Attempts"
    printf "%b\n" "${CYAN}=== Server Performance ===${RC}"
    printf "%b\n" "6. CPU Usage"
    printf "%b\n" "7. Memory Usage"
    printf "%b\n" "8. Disk Usage"
    printf "%b\n" "9. Top CPU Processes"
    printf "%b\n" "10. Top Memory Processes"
    printf "%b\n" "11. Exit"
    printf "%b" "${YELLOW}Enter your choice: ${RC}"
}

main_loop() {
    # Define colors
    CYAN='\033[0;36m'
    YELLOW='\033[1;33m'
    RC='\033[0m' # Reset color

    while true; do
        show_performance_menu
        read -r choice

        case $choice in
            1)
                os_version
                ;;
            2)
                uptime_info
                ;;
            3)
                load_average
                ;;
            4)
                logged_in_users
                ;;
            5)
                failed_login_attempts
                ;;
            6)
                cpu_usage
                ;;
            7)
                memory_usage
                ;;
            8)
                disk_usage
                ;;
            9)
                top_cpu_processes
                ;;
            10)
                top_memory_processes
                ;;
            11)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo -e "\nInvalid option. Please try again."
                ;;
        esac

        echo -e "\nPress Enter to continue..."
        read -r
    done
}

# Call the main loop function at the end of your script
main_loop