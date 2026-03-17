how does bootloader find kernel (eps. in case of dual boot)
does bootloader use the same keys to verify kernel

# Updated experiments
3.  encrypted disk -> no CRUD but wipe/ encrypt (once again) data
    disable the ability to enter bootloader with F12
    protect BIOS with password to prevent an attacker from changin aforementioned setting
notes: secure boot - prevent an attacker from tempering with kernel files

# Future Plans
- do entire series of experiments concerning physical security and later logical too. Like a comprehensive deep dive into the world of security
- what is PXE network boot or whatever that is
- test PXE boots and describe how they work and why it is also a threat vector and should be disabled

# Notes (include on GitHub)
- diagrams and logs?
- what's up with TPM+PIN?
- include small ethical note
- add some scripts to automate mounting, unlocking the disk etc. Maybe even show how a simple scrypt can corrupt entire fs, not corrupt it but steal, package it and send somewhere (only /home directory for efficiency). Automatically look for bitlocker partition and ask for key to mount it automatically 
- what is dirty bit and why is it called so
- mention power-on password and difference between hard disk password vs encryption - plain text but can't dd or encrypt literally vs encrypted data but can dd or encrypt
- mention that encrypting home directory still means that system-wide files can be changed
- mention that perofrming CRUD operations on system-wide files also implies 
that attacker can change password configs and boot your system without needing a password. 
Basically an attacker has full access to your system
- secure boot can prevent potential changes in kernel or bootloader since those can be modified even if disk is encrypted, those aren't. Ensure secure boot is in place
- create a file where I quickly document everything I learnt like (device mapper, Secure Boot, how to identify partitions from another OS...) to showcase that I understand the concepts

# Key Findings (include on GitHub)
- Linux Mint doesn't use LVM by default
- Full disk encryption isn't really full disk encryption - UEFI/BIOS still need to detect bootloader,
and they have no awareness of any encryption
- overwrite empty disk space option (when encrypting the disk) - deleted files aren't erased from disk, 
they are just marked as available space so technically you can still see them. + attacker can't tell how much free space is used since everything is a mess (not mess + random zeroes)
- during installation write down is recomended. But it is usually a bad practice
- notes on secure boot - 
1. processor has microscopic hash burnt into it 
2. processor uses that hash to verify if BIOS is legit
3. BIOS finds bootloader and veririfies if it was signed by a private key (BIOS has a database of Public Keys preloaded in its NVRAM)
4. if bootloader is legit - it then checks if Kernel is legit
5. Kernel proceeds normal operation
- formatting is just creating a new filesystem (mkfs is formatting). As a byproduct it erases data (although some might be left)
- when you shutdown Windows, it doesn't actually shutdown. Instead, it saves the state of the kernel and loaded drivers into a file. The feature is called Fast Startup. To boot from zero - load drivers, start srevices, slow setup.


#### CV 
Option 3 (Ultra-concise, single bullet point): - MAYBE ADD SOME MORE

    System Hardening: Simulated physical vector attacks via Live USB bypasses to demonstrate OS-level authentication flaws, subsequently implementing BIOS passwords, Secure Boot, disabled USB booting, and Full Disk Encryption to neutralize hardware-level threats.














# Core:
try it out on:
- VMs (different OS'es)
- on real (my) machine (USB live boot as a threat actor)
- on dual boot system?
- between two different users on one OS. When wouldn't it work?
what to try to do:
- erase all data
- modify data
- access data
other things to do:
- can access hidden files?

# Conducted Experiments
- VMs erase data with dd and opening in read write | learn when it is possible to open in rw
- VMs modify data with opening in read write | learn when it is possible to open in rw
- simulate USB flash-drive attack in VMs with live boots and external disks

# Experiments to do:
on encrypted disk:
- check if on encrypted fs you can still add files or erase all data with RW access to disk
- make it work like ransomware - encrypt all data, keep the key; erase data (encrypt + delete the key); erase data with dd
on unencrypted disk:
- try with dual boot
- try with USB stick and live boot on real devices (make back ups before doing it just in case)

# Extra:
- explore mitigation techniques
- explore default behaviour on popular systems
- explore what most often you'd see in practice
- document default behavior on different Operating Systems
- prepare bash script to not run all commands manually
- can you do something similar on phone?
- remove all permissions from copied data so that I don't have to write all commands with sudo
- raw disk access to copy, erase data (dd command)
- check if there are any traces left (logs or anything at all). Why/ Why Not
- when doing it on Live USB stick, try using a light-weight OS (with only a terminal present, no GUI) to boot quickly?

# Mitigation Techniques:
- disk encryption

# Project Layout:

disk-access-security-lab/
│
├── README.md
│
├── docs/
│   ├── threat-model.md
│   ├── security-principles.md
│   ├── assumptions-and-scope.md
│   └── glossary.md
│
├── lab-design/
│   ├── architecture-overview.md
│   ├── vm-topology.md
│   └── experiment-variants.md
│
├── experiments/
│   ├── unencrypted-storage/
│   │   ├── objective.md
│   │   ├── expected-results.md
│   │   └── observations.md
│   │
│   └── encrypted-storage/
│       ├── objective.md
│       ├── expected-results.md
│       └── observations.md
│
├── results/
│   ├── comparison-table.md
│   └── conclusions.md
│
├── risks-and-mitigations/
│   ├── confidentiality.md
│   ├── integrity.md
│   ├── availability.md
│   └── backups.md
│
├── ethical-notes/
│   └── responsible-use.md
│
├── diagrams/
│   ├── disk-vs-os-boundary.png
│   ├── vm-disk-sharing.png
│   └── encryption-boundary.png
│
└── LICENSE
