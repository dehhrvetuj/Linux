#https://askubuntu.com/questions/29284/how-do-i-mount-shared-folders-in-ubuntu-using-vmware-tools/1051620#1051620?newreg=bb92dd2a388343ec88df176013c6e1cd

#Most other answers are outdated. For Ubuntu 18.04 (or recent Debian distros), try:

sudo vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000

#If the hgfs directory doesn't exist, try:

sudo vmhgfs-fuse .host:/ /mnt/ -o allow_other -o uid=1000

#You may have use a specific folder instead of .host:/. In that case you can find out the share's name with vmware-hgfsclient. For example:

$ vmware-hgfsclient
my-shared-folder
$ sudo vmhgfs-fuse .host:/my-shared-folder /mnt/hgfs/ -o allow_other -o uid=1000

#If you want them mounted on startup, update /etc/fstab with the following:

# Use shared folders between VMWare guest and host
.host:/    /mnt/hgfs/    fuse.vmhgfs-fuse    defaults,allow_other,uid=1000     0    0
#I choose to mount them on demand and have them ignored by sudo mount -a and the such with the noauto option, because I noticed the shares have an impact on VM performance.

#Requirements
#Software requirements may require installing the following tools beforehand:

sudo apt-get install open-vm-tools open-vm-tools-desktop

#Others have claimed the following are required:

sudo apt-get install build-essential module-assistant \
  linux-headers-virtual linux-image-virtual && dpkg-reconfigure open-vm-tools
  
 
 #This also gives you quick access to the folder from your Ubuntu desktop. Enter this into terminal:
 ln -s /mnt/hgfs/shared-directory ~/Desktop/Name-of-the-folder  
