## 🛡️ Objective
This document outlines a multi-layered defense strategy designed to neutralize the "Physical Access" threat model.

## 🧱 Layer 1: Data Confidentiality (FDE)

### Defensive Goal
- To ensure that if the physical storage media is stolen or accessed via an external OS, the data remains cryptographically inaccessible.
- Limitation: FDE protects data confidentiality but does not inherently protect data integrity. An attacker can still format the drive or perform a "denial of service" by encrypting the already-encrypted blocks.

### Technique
- Linux: Installation using LUKS (Linux Unified Key Setup) on LVM (Logical Volume Manager).
- Windows: Implementation of BitLocker (AES-256).
- macOS: Activation of FileVault 2.

---
## 🔐 Layer 2: Firmware & Bootloader Hardening

### Defensive Goal
- To prevent an attacker from bypassing the primary OS by booting into a rogue environment (Live USB, PXE, or alternative bootloaders). This effectively "seals" the hardware.

### Technique
1. Establish a Supervisor Password: Prevents unauthorized modification of BIOS/UEFI settings.
2. Disable USB Boot and Network (PXE) Boot; Set the Internal Storage (SSD/HDD) as the primary and only boot device.
3. Hard Disk Password (HDP): Enable a hardware-level password to lock the drive controller, preventing data wiping or "re-encryption" attacks.
4. (Optionally) Enable a Power-On password so only authorized users can access the machine


## 🛡️ Layer 3: System Integrity (Secure Boot)

### Defensive Goal
- To prevent "Evil Maid" attacks where an attacker modifies the unencrypted parts of the boot process to plant persistent malware or keyloggers that capture the FDE decryption key.

### Technique
- Enable EFI and Secure Boot in BIOS Settings to examine each component in Boot Sequence (BIOS/UEFI, Bootloader, Kernel) for its authenticity