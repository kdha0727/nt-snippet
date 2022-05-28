# Computer name
echo -e '* Computer Name :' > ~/COM_Info.txt
hostname >> ~/COM_Info.txt

# Installed OS name
echo -e '\n* Installed OS :' >> ~/COM_Info.txt
cat /etc/issue >> ~/COM_Info.txt

# Mainboard name
echo -e '* Mainboard name :' >> ~/COM_Info.txt
sudo dmidecode | grep Name | sort | uniq >> ~/COM_Info.txt # 메인보드 명

# CPU Processor
echo -e '\n* CPU Processor :' >> ~/COM_Info.txt
echo -e ' -CPU Model name' >> ~/COM_Info.txt
cat /proc/cpuinfo | grep "model name" | sort |uniq >> ~/COM_Info.txt # Model name
echo -e ' -Number of cores' >> ~/COM_Info.txt
cat /proc/cpuinfo | grep processor | wc -l >> ~/COM_Info.txt # Number of CPU cores
echo -e ' -Number of logical cores' >> ~/COM_Info.txt
cat /proc/cpuinfo |grep processor -c  >> ~/COM_Info.txt # Number of logical cores
echo -e ' -Number of physical cores' >> ~/COM_Info.txt
grep "physical id" /proc/cpuinfo | sort -u | wc -l >> ~/COM_Info.txt #Number of Physical cores
echo -e ' -Number of physical cores by each CPU' >> ~/COM_Info.txt
grep "cpu cores" /proc/cpuinfo | tail -1 |>> ~/COM_Info.txt # Physical core # by each CPU

# Memory
echo -e '\n* Memory :' >> ~/COM_Info.txt
echo -e ' -Total memory(kb)' >> ~/COM_Info.txt
cat /proc/meminfo | grep 'MemTotal' >> ~/COM_Info.txt # Total memory 'kb'
echo -e ' -Total memory(Gb)' >> ~/COM_Info.txt
free -g| grep ^Mem | awk '{print $1 $2}' >> ~/COM_Info.txt # Total memory 'Gb'
echo -e ' -Memory info' >> ~/COM_Info.txt
sudo dmidecode -t 17 |egrep 'Memory|Size|Part Number|Configured Clock Speed' |sort |uniq >> ~/COM_Info.txt # Meomry Size, Part #, Clock speed


# Harddisk
echo -e '\n* Harddisk :' >> ~/COM_Info.txt
echo -e ' -HDD Model list' >> ~/COM_Info.txt
cat /proc/scsi/scsi | grep Model >> ~/COM_Info.txt # HDD model list
echo -e ' -HDD size list' >> ~/COM_Info.txt
cat fdisk -l|grep 'Disk /dev/' >> ~/COM_Info.txt # HDD size

# VGA
echo -e '\n* VGA card :' >> ~/COM_Info.txt
lspci | grep -i VGA >> ~/COM_Info.txt # VGA
echo -e ' -Nvidia card name' >> ~/COM_Info.txt
nvidia-smi --query | fgrep 'Product Name' >> ~/COM_Info.txt # Nvidia card name

# Ethernet
echo -e '\n* Ethernet port :' >> ~/COM_Info.txt
lspci | grep Ethernet >> COM_Info.txt
