#!/bin/bash

# IronChest Script

echo '
 _____                _____ _               _   
|_   _|              /  __ \ |             | |  
  | | _ __ ___  _ __ | /  \/ |__   ___  ___| |_ 
  | || '__/ _ \| '_ \| |   | '_ \ / _ \/ __| __|
 _| || | | (_) | | | | \__/\ | | |  __/\__ \ |_ 
 \___/_|  \___/|_| |_|\____/_| |_|\___||___/\__|
                                                
                                                
'

# Function to generate a random encryption key
generate_encryption_key() {
    head -c 32 /dev/urandom | base64
}

# Function to change the encryption passphrase
change_passphrase() {
    # Prompt the user for the current passphrase
    read -sp "Enter the current passphrase: " current_passphrase
    echo

    # Open the encrypted partition with the current passphrase
    sudo cryptsetup luksOpen "$device" my_encrypted_partition <<< "$current_passphrase" 2>/dev/null

    # Check if the passphrase is correct
    if [ $? -ne 0 ]; then
        echo "Incorrect passphrase!"
        exit 1
    fi

    # Prompt the user for the new passphrase
    read -sp "Enter the new passphrase: " new_passphrase
    echo

    # Change the passphrase
    echo -e "$current_passphrase\n$new_passphrase" | sudo cryptsetup luksChangeKey "$device" - <<< "$current_passphrase"

    # Check if passphrase change was successful
    if [ $? -ne 0 ]; then
        echo "Failed to change the passphrase."
        exit 1
    fi

    echo "Passphrase changed successfully."
}

# Function to encrypt all directories automatically
encrypt_all_directories() {
    # Get a list of all directories on the disk
    all_directories=$(ls -d */)

    # Encrypt each directory
    for dir in ${all_directories[@]}; do
        echo "Encrypting directory: $dir"
        sudo cryptsetup --verbose --cipher "$cipher" --key-size "$key_size" --hash "$hash_alg" \
            luksFormat "$dir/$dir.luks" <<< "$encryption_key" 2>/dev/null
        sudo cryptsetup luksOpen "$dir/$dir.luks" "$dir" <<< "$encryption_key" 2>/dev/null
        sudo mkfs.ext4 /dev/mapper/"$dir"
        sudo mount /dev/mapper/"$dir" "$dir"
    done
}

# Function to check disk integrity
check_disk_integrity() {
    # Unmount the encrypted partition if it's currently mounted
    if mountpoint -q /mnt/encrypted; then
        sudo umount /mnt/encrypted
    fi

    # Open the encrypted partition
    sudo cryptsetup luksOpen "$device" my_encrypted_partition

    # Check disk integrity
    sudo fsck -fy -R -A /dev/mapper/my_encrypted_partition

    # Close the encrypted partition
    sudo cryptsetup luksClose my_encrypted_partition
}

# Install cryptsetup if not already installed
sudo apt-get install -y cryptsetup

# Prompt the user for the device path
read -p "Enter the device path (e.g., /dev/sdb): " device

# Check if the device exists
if [ ! -e "$device" ]; then
    echo "Device not found!"
    exit 1
fi

# Get the disk size in gigabytes
disk_size_gb=$(($(sudo blockdev --getsize64 "$device") / 1024 / 1024 / 1024))

# Check if the disk size is at least 4GB
if (( disk_size_gb < 4 )); then
    echo "Disk size is too small. Encryption requires at least 4GB of free space."
    exit 1
fi

# Prompt the user for the encryption parameters
read -p "Enter the encryption cipher (default: aes-xts-plain64): " cipher
cipher=${cipher:-aes-xts-plain64}

read -p "Enter the encryption key size in bits (default: 512): " key_size
key_size=${key_size:-512}

read -p "Enter the encryption hash algorithm (default: sha256): " hash_alg
hash_alg=${hash_alg:-sha256}

# Generate a random encryption key
encryption_key=$(generate_encryption_key)

# Create a new LUKS encrypted partition
sudo cryptsetup luksFormat --type luks1 --cipher "$cipher" --key-size "$key_size" --hash "$hash_alg" "$device"

# Check if the LUKS header was successfully created
if [ $? -ne 0 ]; then
    echo "Failed to create LUKS header. Encryption parameters may not be supported."
    exit 1
fi

# Open the encrypted partition
sudo cryptsetup luksOpen "$device" my_encrypted_partition <<< "$encryption_key"

# Format the encrypted partition with a filesystem (e.g., ext4)
sudo mkfs.ext4 /dev/mapper/my_encrypted_partition

# Mount the encrypted partition
sudo mkdir -p /mnt/encrypted
sudo mount /dev/mapper/my_encrypted_partition /mnt/encrypted

# Encrypt all directories automatically
encrypt_all_directories

# Check disk integrity
check_disk_integrity

# Backup encryption metadata
sudo cryptsetup luksHeaderBackup "$device" --header-backup-file /mnt/encrypted/luks_header_backup.bin

# Log the encryption process
logger -t "Disk Encryption" "Encryption completed successfully for device $device with cipher $cipher, key size $key_size bits, and hash algorithm $hash_alg."

echo "Encryption completed successfully!"

# Clean up temporary files
sudo rm /mnt/encrypted/luks_header_backup.bin

echo "Script execution completed."
