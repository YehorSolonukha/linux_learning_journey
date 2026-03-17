## Gaining access to unencrypted disk (VM)

### Objectives:
- Demonstrate that physical access (simulated via VMs) allows an attacker to bypass host OS authentication and perform CRUD operations on unencrypted file system.

### Results
- Outcome: Unauthorized CRUD operations can be successfully performed.
- Conclusion: OS-level login credentials provide zero protection against an attacker with physical access to an unencrypted drive.

### Environment
- Hypervisor: VirtualBox
- Target: Linux Mint VM (Unencrypted ext4 filesystem)
- Attacker: Linux Mint VM.

### Execution Steps:
Target Setup
1. Install Linux Mint on the Target VM without encrypting the home directory.
2. Boot the Target VM, open the terminal, and create a test artifact:
```
mkdir ~/TEST_DIR && echo "CONFIDENTIAL_DATA" > ~/TEST_DIR/TEST_FILE
```
3. Power off the Target VM.

Attacker Setup
1. Install Linux Mint on the Attacker VM. Power it off upon completion.
2. In VirtualBox Settings for the Attacker VM -> Storage, attach the Target VM's .vdi (virtual disk) file as a secondary SATA drive.
3. Boot the Attacker VM.

CRUD operations
1. Identify the attached Target drive and its ext4 partition (partition containing ext4 filesystem without a mountpoint is most likely our target):
```
lsblk -f
```
2. Mount target partition (assuming sdb3 is target partition)
```
sudo mount /dev/sdb3 /mnt
```
3. Perform CRUD operations
- read and copy data:
```
mkdir /home/TARGET_DIR
cat /mnt/home/<target_username>/TEST_DIR/TEST_FILE | sudo tee home/TARGET_DIR/TARGET_FILE
```
- change original data
```
echo "ATTACKER'S DATA" > /home/<target_username>/TEST_DIR/TEST_FILE
```
- delete data
```
mkdir /home/<target_username>/ATTACKER_DIR
cp /home/<target_username>/TEST_DIR/TEST_FILE /home/<target_username>/ATTACKER_DIR/TEST_FILE 
rm -rf /home/<target_username>/TEST_DIR
```
- add new files
```
echo "NEW_ATTACKER_DATA" > /home/<target_username>/ATTACKER_DIR/NEW_ATTACKER_FILE
```

Verification
1. Power off the Attacker VM
2. detach the Target's .vdi disk from the settings (Storage)
3. Reboot Target VM to observe changes
