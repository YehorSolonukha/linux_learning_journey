# System Hardening

## 📌 Project Overview
This repository serves as a technical breakdown of system vulnerabilities when physical access is granted to an unauthorized party. The goal was to simulate an "Attacker with Physical Access" scenario, moving from a standard, "out-of-the-box" configuration to a hardened environment.

## 🛠 Tools & Technologies
- Environment & Boot Media: Hiren’s BootCD PE, Linux Live Boot
- Working with disks and filesystems: lsblk, mount, dd, DISKPART (hiren's)
- Encryption & Security: cryptsetup, BitLocker (manage-bde)

## 🧪 Experimental Roadmap
The lab is structured into three distinct phases:

1. **"out-of-the-box" System**
- Under default settings, the system operates with an unencrypted disk. This experiment demonstrates how an attacker with a simple Live USB or physical access to the storage media can bypass OS-level credentials entirely.
- Vector: Utilizing /dev/device files to mount target's filesystem essentially gaining full administrative control over it
- Key Finding: Default operating system configuration provides zero protection against an attacker with physical access

2. **Full Disk Encryption**
- FDE protects data confidentiality. While this mitigates data theft, it uncovers a secondary risk: the availability and integrity of the hardware.
- Demonstration: Even with encrypted data, an attacker can still perform a "denial of service" on the hardware by erasing partitions or re-encrypting the drive
- Mitigation: Introduction of Hard Disk Passwords to lock the drive controller itself, preventing unauthorized write/erase commands at the firmware level. Essentially you can't 'talk' to the drive without a password
3. **Full System Hardening**
- The final phase focuses on securing the pre-boot environment to ensure the "Gatekeeper" remains uncompromised. This transforms the machine into a hardened endpoint where the hardware refuses to execute unauthorized code.
- Implementation:
    - Establishing a BIOS/UEFI Supervisor Password to lock configuration settings.
    - Disabling unauthorized boot sources (USB, PXE Network Boot).
    - Enforcing Secure Boot to ensure only signed, trusted bootloaders can execute.
    - (optionally) Setting a power-on password - any time you start the machine it'll ask for a password
- Outcome: The system is effectively "sealed," requiring authentication before any non-standard boot activity can occur.


### Educational Purposes Only 
- This project is strictly for research and educational purposes. The techniques documented here are intended to highlight security vulnerabilities and demonstrate hardening best practices. Unauthorized access to computer systems is illegal; always perform these experiments on hardware you own or have explicit permission to audit.