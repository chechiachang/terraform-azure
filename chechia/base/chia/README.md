chia
===

# Fdisk

```
sudo fdisk /dev/sdb
sudo fdisk /dev/sdc

sudo mkfs.ext4 /dev/sdb
sudo mkfs.ext4 /dev/sdc

sudo mkdir -p /chia/k34
sudo mkdir -p /chia/tmp

sudo vim /etc/fstab

sudo mount /chia/k34
sudo mount /chia/tmp

sudo chown chechia:chechia /chia/k34
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
chia plots add -d /chia/k34

THREAD=2
MEMORY=6000 # 6 GB
PLOT_NUMBER=18 # 2000/108.9

nohup chia plots create \
  -k 32 \
  -n ${PLOT_NUMBER} \
  -t /chia/tmp \
  -d /chia/k34 \
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
