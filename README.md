# IronChest

IronChest is a bash script that encrypts storage devices using LUKS encryption with customizable parameters. It provides an easy-to-use interface to encrypt storage devices securely.

![IronChest Logo](ironchest_logo.png)

## Features

- Encrypts storage devices using LUKS encryption.
- Customizable encryption parameters (cipher, key size, hash algorithm).
- Automatically encrypts all directories on the disk.
- Checks disk integrity after encryption.
- Backs up encryption metadata for recovery.
- Logs the encryption process for auditing.

## Requirements

- Linux environment
- `cryptsetup` package installed

## Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/Ismail-Benali/ironchest.git
    ```

2. Navigate to the `ironchest` directory:

    ```bash
    cd ironchest
    ```

3. Run the script:

    ```bash
    ./ironchest.sh
    ```

4. Follow the prompts to specify the device path and encryption parameters.

## Usage

- Run the script and follow the prompts to encrypt your storage device.
- Make sure to run the script with sudo privileges for administrative tasks.

## Example

```bash
./ironchest.sh
```

## Frequently Asked Questions (FAQ)

For answers to common questions about IronChest, please refer to the [FAQ](faq.md).
