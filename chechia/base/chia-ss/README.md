Plot & Machine spec
===

# VM with NVME

`Standard_L8s_v2`
- 8	cpu 64 mem
- local 80 GB
- 1 x 1.92 TB NVME

spot max price = $0.15708 / hr = $114 /month

scale 10 instances

```
Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s    MB_read    MB_wrtn    MB_dscd
nvme0n1          65.43         2.81        50.99       698.16       7370     133768    1831419
sda              11.82         0.14         0.77         0.14        359       2032        361
sdb               0.26         0.01         0.00         0.00         26          0          0
```

# VM with tmp SSD

L4s
- 4	cpu 
- 32 mem
- local SSD 678 GiB	

spot max price = $0.03740 / hr = $27 /month

scale 30 instances
