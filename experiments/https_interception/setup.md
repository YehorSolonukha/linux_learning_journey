### Technologies used
- CLI tools: sysctl, ip addr, ip route, iptables

### Setup
#### Stage1 - Normal traffic forwarding
VM1:
- only internal access (VM2)
- default gateway points to VM2 (this session only):
```
sudo ip route add default via <vm2_ip> dev <vm1_int>
```

VM2 - internal + public access
- enable forwarding (this session only)
```
sudo sysctl -w net.ipv4.ip_forward=1
```
- enable nat (so that our private VM1 ip is translated into public facing VM2 ip)
POSTROUTING is used when traffic is about to leave interface
MASQUERADE is used when public facing ip was given via DHCP and isn't static
```
sudo iptables -t nat -A POSTROUTING -o <vm2_public_facing_ip> -j MASQUERADE
```

#### Stage2 - Intercepting HTTP and HTTPS traffic with mitmproxy
VM1
- add proxy's certificate into trust store
```
# copy the certificate onto vm1 from vm2 via netcat
nc -l 1234 > ~/cert.pem 
# ctrl+C after successful copy and copy the cert into trust store
sudo cp ~/cert.pem /usr/local/share/ca-certificates/mitmproxy.crt
```
- add proxy's certificate into browser's trust store

VM2:
- start mitmproxy:
```
mitmproxy --mode transparent --showhost
```
- copy the mitmxproxy certicicate onto vm1 via netcat
```
nc <vm1_ip> 1234 < ~/.mitmproxy/mitmproxy-ca-cert.pem
```

#### Stage3 - Content manipulation
VM1:
- if legitimate google.com was visited previously and 'hacked' page isn't shown:
    1. enter `about:serviceworkers` into the address bar (in case you're using Firefox)
    2. find entry that corresponds to google.com 
    3. unregister
    4. restart

VM2:
- create a python script (/scripts/redirect.py) to fake response from server
- start the proxy with the following command to include the script (make sure the path to the script is correct):
```
mitmproxy --mode transparent --showhost -s redirect.py
```
