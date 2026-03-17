### What is a transparent proxy?
"transparency" is defined by the perspective of the client application. If no explicit config on client app is required the proxy is considered transparent

### Browser's trust store
browsers don't rely on local trust stores, they have their own. For example so that older systems have the exact same list of trusted CAs as new ones

### regex ^my_word
^ means if line starts with my_word

### tee vs >>(>)
a simple redirect can't use sudo privileges but tee is a command so it can

### service workers
service worker can store and load cached pages. In my lab I had to delete a service worker for google.com so that cached page is deleted and won't be loaded. Apparently they also hold HSTS configs (which can disallow you to visit unencrypted website, or website with a certificate signed some other CA)

### shared folders in VM
shared folders didn't work on my machine by default. So I had to `mount` them manually (added `-t vboxsf` flag to specify the type of FS as VirtualBox shared folder)