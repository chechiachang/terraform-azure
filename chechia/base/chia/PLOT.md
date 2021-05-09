Plot & Machine spec
===

# Decide VM spec

### Base on first attmpt

- machine 2 cpu 8G mem
- StandardSSD 2T (50 Mbps)
- StandardHDD 2T
- 30-36 hr for 1 plot

### Better setting

According to references
- https://www.chia.net/2021/02/22/plotting-basics.html
- [Github wiki: plot](https://github.com/Chia-Network/chia-blockchain/wiki/k-sizes#i5-4690k-debian-10-desktop)
- Asuumption: it should be ok to use single, but the last stage will have to wait

### Better plot machine / setting should be

- k 32 4000 mem 2 thread

Plot machine
- D2v4 (2 cpu 8 mem) $81.81
- premiumSSD 512GB (150 Mbps) $73.22 * 7
- StandardHDD 2T $81.92
  - for final file (2T / 108.9 GB = 19 plots)
- $600

Farmer machine
- D2v4 (2 cpu 8 mem) $81.81
- S40 (HDD 2048 GB ) $81.92 * 8 = 655.36
  - 152 plots
- $750

### Every month

Famrer machine X 2 = 304 plot
- https://chiacalculator.com/
  - Expected time to win 21 days
- [CoinMarketCap](https://coinmarketcap.com/zh-tw/currencies/chia-network/)
  - 1 XCH about 1300

##### Total
- $600 for 1 plot machine
- $1500 for 2 farmer machine
- earn 1 XCH ($1300)

---

# PremiumSSD Raid

Target: Temp Space 256.6 GB

    Storage Type  Size  M IOPS  Mbps  Price
    Premium SSD   128   500     100   $19.17
X 3                     1500    300   $57.51

Output
```
      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    51.60       935.6k        21.2M        41.6M       2.8G      65.1G     128.0G sdb
     1.14         4.8k         6.1k         0.0k      14.7M      18.7M       0.0k sdc
     2.17         3.4k      1005.2k        41.6M      10.3M       3.0G     128.0G sdd
     1.53         4.2k       666.7k        41.6M      13.0M       2.0G     128.0G sde

Starting phase 1/4: Forward Propagation into tmp files... Sun May  9 04:45:54 2021
Computing table 1
F1 complete, time: 371.177 seconds. CPU (93.08%) Sun May  9 04:52:06 2021
Computing table 2
```

### lvcreate -i 3

```
      tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
    44.27       351.4k         4.4M         2.0M     691.6M       8.7G       4.0G sdc
    43.94       199.3k         4.4M         2.0M     392.2M       8.7G       4.0G sdd
    43.17         3.7k         4.4M         2.0M       7.4M       8.7G       4.0G sde

Starting phase 1/4: Forward Propagation into tmp files... Sun May  9 08:05:09 2021
Computing table 1
F1 complete, time: 370.845 seconds. CPU (95.74%) Sun May  9 08:11:20 2021
Computing table 2
```

# (Invalid) tiny raid 0

    Storage Type  Size  M IOPS  Mbps  Price
    Premium SSD   8     100     25    $1.2
X 36                    3600    900   $43.2

Max number of disk per cpu is 2
