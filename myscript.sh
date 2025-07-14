#!/bin/bash

# Add user
add_user() {
    if id "$1" &>/dev/null; then
        echo "User '$1' exist."
    else
        sudo useradd "$1" && echo "User '$1' added successfully."
    fi
}

#Check service
check_service() {
    systemctl is-active --quiet "$1"
    if [ $? -eq 0 ]; then
        echo "Service is '$1' run."
    else
        echo "Service is '$1' not run or find."
    fi
}

# User backup
take_backup() {
    src="$1"
    dest="$2/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    if [ -d "$src" ]; then
        tar -czf "$dest" "$src" && echo "Backup is done: $dest"
    else
        echo "Source path did not find: $src"
    fi
}

# Help
show_help() {
    echo "Using:"
    echo "  $0 adduser <user_name>"
    echo "  $0 checkservice <service_name>"
    echo "  $0 backup <source_path> <backup_path>"
}

# Main flow
case "$1" in
    adduser)
        add_user "$2"
        ;;
    checkservice)
        check_service "$2"
        ;;
    backup)
        take_backup "$2" "$3"
        ;;
    *)
        show_help
        ;;
esac
