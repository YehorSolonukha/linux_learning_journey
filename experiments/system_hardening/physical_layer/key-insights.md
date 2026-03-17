## 🧠 Lab Key Insights & Technical Discoveries

### 1. How Decryption Actually Works
- Unlocking the disk doesn't actually decrypt the files on the physical disk
- a mapper is created under /dev/mappers which essentially grabs encrypted data from disk and decrypts it in RAM

### 2. FDE doesn't encrypt Full Disk
- each OS installation has three parts (located on 3 separate partitions):
    - kernel
    - bootloader
    - root filesystem
- of those only root fs is encrypted 
- which means that an attacker can temper with kernel files or bootloader. Which highlights the importance of enabling Secure Boot to prevent any tempering 


### 3. Windows "Fast Startup"
- in windows shut down isn't actually a shut down
- it saves current state of kernel onto hard drive
- because of that mounting main windows disk can't be accomplished by default 
- also it may cause some drivers to not work properly if you boot into Linux after a shut down (in case of dual-boot systems)

### 4. How Secure Boot works
1. processor has microscopic hash burnt into it 
2. processor uses that hash to verify if BIOS is legit
3. BIOS finds bootloader and verifies if it was signed by a private key (BIOS has a database of Public Keys preloaded in its NVRAM)
4. if bootloader is legit - it then checks if Kernel is legit
5. Kernel proceeds normal operation

### 5. Overwriting Empty Space: Forensic Camouflage

When encrypting a drive, there's an option - "overwrite empty space". Which serves two purposes: 
- make entire disk look like noise, so how much data can't be found
- prevent recovery of old deleted data which is still present on disk

### 6. How to not lose your system
If BIOS isn't protected with a password an attacker can:
- set a power-on password effectively locking the machine entirely
- set a password on disk -> disk isn't accessible, it will refuse to talk
- set BIOS password so you can't access the settings yourself