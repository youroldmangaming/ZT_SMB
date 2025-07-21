To connect to the samba share in linux
'''
#!/bin/bash
sudo umount -l /mnt/shared 2>/dev/null || true
sudo mkdir -p /mnt/shared
sudo mount -t cifs //192.168.192.186/shared /mnt/shared -o guest,vers=3.0
'''

To connect to the samba share from MacOS
'''
sudo mkdir -p /Volumes/ztshare
# Mount the share
sudo mount_smbfs '//guest@192.168.192.186/shared' /Volumes/ztshare
''''

