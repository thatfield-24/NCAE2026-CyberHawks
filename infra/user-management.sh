#Thank you to team Hawaii https://github.com/Alphabaddie420xx/UHWO-NCAE-RESOURCES/blob/main/User-Management
#!/bin/bash

# Temporarily turn off bash history
set +o history

# Function to display the list of current users along with their shell
list_users() {
    echo "Current system users and their shells:"
    awk -F: '{print $1 " -> " $7}' /etc/passwd
}

# Function to add a new user
add_user() {
    read -p "Enter the username to add: " username
    sudo useradd "$username"
    sudo passwd "$username"
    echo "User $username has been added."
}

# Function to remove a user
remove_user() {
    read -p "Enter the username to remove: " username
    sudo userdel "$username"
    sudo rm -rf /home/"$username"  # Remove the user's home directory
    echo "User $username has been removed."
}

# Function to add sudo privileges to a user
add_sudo_privileges() {
    read -p "Enter the username to give sudo privileges: " username
    sudo usermod -aG sudo "$username"
    echo "User $username now has sudo privileges."
}

# Function to change the user's group
change_group() {
    read -p "Enter the username whose group you want to change: " username
    read -p "Enter the new primary group for $username: " new_group
    sudo usermod -g "$new_group" "$username"
    echo "User $username's primary group has been changed to $new_group."
}

# Main function
main() {
    while true; do
        echo "Choose an option:"
        echo "1. List current users"
        echo "2. Add a new user"
        echo "3. Remove an existing user"
        echo "4. Add sudo privileges to a user -- only if they need it as specified by scoring directions"
        echo "5. Change user's group"
        echo "6. Exit"
        read -p "Enter option (1-6): " option

        case $option in
            1)
                list_users
                ;;
            2)
                add_user
                ;;
            3)
                remove_user
                ;;
            4)
                add_sudo_privileges
                ;;
            5)
                change_group
                ;;
            6)
                echo "Exiting..."
                break
                ;;
            *)
                echo "Invalid option, please choose a number between 1 and 6. >:("
                ;;
        esac
    done
}

# Run the main function
main
