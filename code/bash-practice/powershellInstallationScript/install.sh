
#!/bin/bash


# Check if the user has root privileges using sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with root privileges. Use 'sudo' to execute it."
    exit 1
fi


# Function to install PowerShell for different package managers
install_powershell() {
    # Detect the Linux distribution and its package manager
    if [ -x "$(command -v apt)" ]; then
        echo "Detected Debian/Ubuntu-based/Kali-linux/Parrot-OS system. Installing PowerShell using APT..."
        apt update
        apt install -y powershell
    elif [ -x "$(command -v yum)" ]; then
        echo "Detected Red Hat 7/CentOS/Fedora-based system. Installing PowerShell using YUM..."
	yum update
        yum install -y powershell
    elif [ -x "$(command -v dnf)" ]; then
        echo "Detected Red Hat 8/CentOS/Fedora 22+ system. Installing PowerShell using DNF..."
	dnf update
        dnf install -y powershell
    elif [ -x "$(command -v zypper)" ]; then
        echo "Detected openSUSE/SLES-based system. Installing PowerShell using Zypper..."
	zypper update
        zypper install -y powershell
    else
        echo "Unsupported Linux distribution or package manager. Please install PowerShell manually."
        exit 1
    fi
}

# Main script
echo "Starting PowerShell installation..."
install_powershell
echo "PowerShell installation completed."

# Check if any additional packages are required to run PowerShell on the current distribution
echo "Checking if additional packages are required..."
if [ -x "$(command -v pwsh)" ]; then
    pwsh -c "Write-Host 'PowerShell is installed and working properly.'"
else
    echo "PowerShell is not installed or there is an issue with the installation."
fi

