## HTTP(S) Interception via transparent proxy and custom CA 
### 📌 Project Overview
This project is a simulation of a DPI (Deep Packet Inspection) workflow. Additionally I have explored potential vulnerabilities and mitigation techniques.

### 🛠 Tools & Technologies
- Networking: iptables (NAT, traffic redirection to proxy), sysctl (IP forwarding), ip route, ip addr.
- Interception: mitmproxy.
- Other tools: netcat (for internal file transfer), curl (for initial testing).
- Environment: Linux VMs (Mint).

### How to use this repo
- scripts/ - bash/Python scripts to pre-configure VMs and intercept traffic.
- setup.md - step-by-step configuration.
- results.md - evidence of the interception and forged pages.
- extra.md - my notes on things I found interesting along the way

### Educational Purposes Only 
- This project is strictly for research and educational purposes. The techniques documented here are intended to highlight legitimate workflows, explore security vulnerabilities and demonstrate mitigation strategies

