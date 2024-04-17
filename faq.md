# IronChest Frequently Asked Questions (FAQ)

## What is IronChest?

IronChest is a Bash script designed to encrypt storage devices using LUKS (Linux Unified Key Setup) encryption. It provides a simple and secure way to protect your data by encrypting disks with strong encryption algorithms.

## How does IronChest work?

IronChest prompts the user to select the storage devices they want to encrypt. Then, it generates a random encryption key, prompts the user for encryption parameters such as cipher, key size, and hash algorithm, and finally encrypts the selected devices using LUKS encryption.

## What encryption parameters does IronChest support?

IronChest supports various encryption parameters, including the encryption cipher (default: aes-xts-plain64), key size in bits (default: 512), and hash algorithm (default: sha256). Users can customize these parameters during the encryption process.

## How secure is IronChest?

IronChest employs strong encryption algorithms provided by LUKS, ensuring high security for encrypted storage devices. It generates random encryption keys and supports customizable encryption parameters, enhancing security according to user preferences.

## Can IronChest encrypt multiple storage devices simultaneously?

Yes, IronChest allows users to select multiple storage devices for encryption. It encrypts each selected device individually, providing flexibility and convenience in securing multiple disks at once.

## How can I report issues or contribute to IronChest?

You can report issues, suggest improvements, or contribute to IronChest by opening a new issue or pull request on its GitHub repository: [IronChest GitHub Repository](https://github.com/Ismail-Benali/ironchest)

## Who can use IronChest?

IronChest is suitable for both beginners and experienced users who need to encrypt their storage devices securely. It provides a user-friendly interface for encryption while offering advanced customization options for encryption parameters.

## Does IronChest support additional features?

IronChest focuses primarily on disk encryption, but additional features such as automatic encryption of directories and integrity checks may be added in future updates based on user feedback and contributions.

## Can I trust IronChest with sensitive data?

IronChest is designed with security in mind and follows best practices for disk encryption. However, users should exercise caution and ensure they understand the implications of encrypting their storage devices. It's recommended to review the source code and encryption parameters before use.

## How do I uninstall IronChest?

To uninstall IronChest, simply delete the script file from your system. Additionally, make sure to securely erase any encrypted partitions or data before removing IronChest to prevent data loss.

