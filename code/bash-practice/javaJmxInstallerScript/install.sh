#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Function to detect the Linux distribution
get_linux_distribution() {
    if [ -f "/etc/os-release" ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f "/etc/redhat-release" ]; then
        echo "rhel"
    fi
}

# Install OpenJDK based on Linux distribution
install_openjdk() {
    local distribution=$(get_linux_distribution)

    case "$distribution" in
        "ubuntu" | "debian")
            apt-get update
            apt-get install -y openjdk-11-jdk
            ;;
        "fedora" | "centos" | "rhel")
            yum install -y java-11-openjdk-devel
            ;;
        "opensuse" | "sles")
            zypper install -y java-11-openjdk-devel
            ;;
        *)
            echo "Unsupported distribution: $distribution"
            exit 1
            ;;
    esac
}

# Check if JDK is installed
if ! command -v java &>/dev/null; then
    echo "Java Development Kit (JDK) is not installed. Installing JDK..."
    install_openjdk
    echo "JDK installed successfully."
fi

# Check if JMX is available
if command -v jconsole &>/dev/null; then
    echo "Java JMX is already installed."
else
    echo "Java JMX is not installed. Please try to install JDK manually."
fi

