### IronChest: Secure Storage Encryption Tool

IronChest is a powerful shell script tool designed to encrypt storage devices securely on Linux systems. It offers robust encryption using dynamic algorithms, ensuring the confidentiality and integrity of your data.

#### Features:

- **Strong Encryption**: Utilizes advanced encryption algorithms to protect your data effectively.
- **Dynamic Encryption**: Automatically selects encryption algorithms and parameters based on system capabilities for optimal security.
- **Automatic Encryption**: Encrypts all storage devices automatically, eliminating the need for manual intervention.
- **Flexible Configuration**: Customize encryption parameters and algorithms according to your preferences and requirements.
- **Email Notifications**: Receive email notifications for encryption status and activities, keeping you informed at all times.
- **Integrity Checks**: Performs integrity checks to ensure data security and prevent unauthorized access.
- **Passphrase Change**: Securely change encryption passphrases for enhanced protection.

#### Usage:

1. **Clone the repository**:

    ```bash
    git clone https://github.com/Ismail-Benali/ironchest.git
    ```

2. **Navigate to the directory**:

    ```bash
    cd ironchest
    ```

3. **Make the script executable**:

    ```bash
    chmod +x ironchest.sh
    ```

4. **Run the script**:

    ```bash
    ./ironchest.sh
    ```

Follow the prompts to encrypt your desired storage device.

#### Configuration:

Customize IronChest by modifying the encryption parameters in the script itself. Open `ironchest.sh` in a text editor and adjust the `cipher`, `key_size`, and `hash_alg` variables as needed.

#### Email Notifications:

To receive email notifications for encryption status and activities, set up your email credentials in the script and ensure that the `mail` command is installed on your system.

#### Contributing:

Contributions are welcome! If you have suggestions or find bugs, please open an [issue](https://github.com/Ismail-Benali/ironchest/issues) or submit a [pull request](https://github.com/Ismail-Benali/ironchest/pulls).

#### License:

This project is licensed under the [Apache License 2.0](LICENSE).

#### About:

IronChest is maintained by Ismail-Benali. For inquiries and support, contact ismail-benali@proton.me.

---

Feel free to replace the placeholders (e.g., "username", "Your Name", "your@email.com") with your actual information. This README provides users with comprehensive details about IronChest, including its features, usage instructions, configuration options, and contribution guidelines.
