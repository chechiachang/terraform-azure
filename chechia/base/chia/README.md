chia
===

# Fdisk

lvm raid 0 for tmp
```
VG_NAME=chia-tmp
declare -a BLK_NAMES=(/dev/sdc /dev/sdd /dev/sde)

sudo vgcreate ${VG_NAME} ${BLK_NAMES[@]}
sudo lvm vgs

LV_NAME=tmp-1

sudo lvcreate --type raid0 -i 3 -l 100%FREE -n ${LV_NAME} ${VG_NAME} ${BLK_NAMES[@]}
sudo mkfs.ext4 /dev/${VG_NAME}/${LV_NAME}
```

fdisk final disk
```
sudo fdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb
sudo mkdir -p /chia/k32
```

```
sudo vim /etc/fstab
#/dev/chia-tmp/tmp-1 /chia/tmp ext4
#/dev/sdc /chia/k32 ext4

sudo mount /chia/k32
sudo mount /chia/tmp

sudo chown chechia:chechia /chia/k32
sudo chown chechia:chechia /chia/tmp
```

# Install

https://github.com/Chia-Network/chia-blockchain/wiki/INSTALL#ubuntudebian

```
sudo apt-get update
sudo apt-get upgrade -y

# Install Git
sudo apt install git -y

# Checkout the source and install
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain

sh install.sh

. ./activate
```

# Init

```
chia init

chia keys generate
```

### k32

```
chia plots add -d /chia/k32

THREAD=4
MEMORY=4000 # 4 GB
PLOT_NUMBER=18 # 2000/108.9

nohup chia plots create \
  -k 32 \
  -n ${PLOT_NUMBER} \
  -t /chia/tmp \
  -d /chia/final \
  -r ${THREAD} \
  -b ${MEMORY} > k32.log 2>&1 &
```

### k34 (not tested)

```
chia plots add -d /chia/k34

THREAD=2
MEMORY=6000 # 6 GB
PLOT_NUMBER=3

nohup chia plots create \
  -k 34 \
  -n ${PLOT_NUMBER} \
  -t /chia/tmp \
  -d /chia/k34 \
  -r ${THREAD} \
  -b ${MEMORY} > k34.log 2>&1 &
```

# Monitor

```
chia plots check
htop
```
