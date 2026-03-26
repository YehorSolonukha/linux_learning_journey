## Gaining access to real unencrypted disk via live USB Boot

### Objectives:
- Demonstrate that booting a Live OS from a USB drive grants full CRUD privileges over an unencrypted host disk, bypassing all host OS authentication.

### Results
- Outcome: Full administrative access to the host's files was achieved without ever entering a Windows password.
- Conclusion: OS-level login credentials provide zero protection against an attacker with physical access to an unencrypted drive.The hardware will trust any OS it is told to boot unless further measures are taken.

### Environment
- Target: A physical PC or laptop with an encrypted disk (in my case - Windows 11 Lenovo laptop with BitLocker).
- Attacker: Linux Mint .iso (or Ubuntu/Kali...) flashed to the USB.

### Execution Steps:
Attacker Setup
1. Install Linux Mint .iso (or Ubuntu/Kali)
2. Use a flashing tool like BalenaEtcher to write the .iso to the USB drive. This makes the USB bootable.

Gaining Access 
1. Insert the Live USB into the Target laptop while it is powered off
(might be better to restart main system rather than shutting it down to ensure read-write permissions work properly)
2. Power on the laptop and immediately tap the Function key to enter the Boot Menu (typically F12).
3. Select the USB drive as the primary boot device.
4. Once the Linux Mint "Live" desktop loads, open the terminal.

CRUD Operations
1. Identify the Target Partition (should have no mounpoints, might have label SYSTEM next to it, usually ntfs type):
```
lsblk -f
```
2. Mount the Partition:
```
sudo mount /dev/<target_partition> /mnt
```
3. Navigate to directory and perform CRUD operations (CRUD ops. not included):
```
cd /mnt
```

Verification
1. Unmount the drive: 
```
sudo umount /mnt
```
2. Shut down the Live OS and remove the USB.
3. Boot back into Windows 11 to observe that files have been moved, modified, or deleted...