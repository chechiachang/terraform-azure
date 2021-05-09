# First attempt result

```
Plot size is: 32
Buffer size is: 6000MiB
Using 128 buckets
Using 2 threads of stripe size 65536

Starting phase 1/4: Forward Propagation into tmp files... Thu May  6 17:51:23 2021
Computing table 1
F1 complete, time: 777.96 seconds. CPU (48.71%) Thu May  6 18:04:21 2021
Computing table 2
Forward propagation table time: 5271.467 seconds. CPU (51.540%) Thu May  6 19:32:14 2021
Computing table 3
Forward propagation table time: 8786.366 seconds. CPU (34.810%) Thu May  6 21:58:40 2021
Computing table 4
Forward propagation table time: 11119.327 seconds. CPU (33.210%) Fri May  7 01:03:59 2021
Computing table 5
Forward propagation table time: 12359.129 seconds. CPU (30.360%) Fri May  7 04:29:58 2021
Computing table 6
Forward propagation table time: 10621.326 seconds. CPU (32.920%) Fri May  7 07:27:00 2021
Computing table 7
Forward propagation table time: 8382.417 seconds. CPU (32.690%) Fri May  7 09:46:42 2021
Time for phase 1 = 57319.310 seconds. CPU (34.610%) Fri May  7 09:46:42 2021

Starting phase 2/4: Backpropagation into tmp files... Fri May  7 09:46:42 2021
Backpropagating on table 7
scanned table 7
scanned time =  1961.134 seconds. CPU (3.310%) Fri May  7 10:19:24 2021
sorting table 7
Backpropagating on table 6
scanned table 6
scanned time =  990.144 seconds. CPU (21.130%) Fri May  7 11:25:58 2021
sorting table 6
sort time =  1717.741 seconds. CPU (38.110%) Fri May  7 11:54:35 2021
Backpropagating on table 5
scanned table 5
scanned time =  994.491 seconds. CPU (21.820%) Fri May  7 12:11:20 2021
sorting table 5
sort time =  1711.168 seconds. CPU (36.800%) Fri May  7 12:39:51 2021
Backpropagating on table 4
scanned table 4
scanned time =  1019.100 seconds. CPU (19.860%) Fri May  7 12:56:53 2021
sorting table 4
sort time =  1641.459 seconds. CPU (37.410%) Fri May  7 13:24:14 2021
Backpropagating on table 3
scanned table 3
scanned time =  956.449 seconds. CPU (22.210%) Fri May  7 13:40:12 2021
sorting table 3
sort time =  1678.091 seconds. CPU (37.030%) Fri May  7 14:08:11 2021
Backpropagating on table 2
scanned table 2
scanned time =  1009.928 seconds. CPU (19.910%) Fri May  7 14:25:02 2021
sorting table 2
sort time =  1731.389 seconds. CPU (35.400%) Fri May  7 14:53:54 2021
table 1 new size: 3425239448
Time for phase 2 = 18432.592 seconds. CPU (24.130%) Fri May  7 14:53:55 2021
Wrote: 268

Starting phase 3/4: Compression from tmp files into "/chia/tmp/plot-k32-2021-05-06-17-51-af9e2c8f456a7b91e8fc1cd23dd8f19cc180cbe7c0eb96778df387c25cdbb81e.plot.2.tmp" ... Fri May  7 14:53:55 2021
Compressing tables 1 and 2
Total compress table time: 7274.267 seconds. CPU (19.110%) Fri May  7 16:55:09 2021
Compressing tables 2 and 3
Total compress table time: 8615.798 seconds. CPU (18.820%) Fri May  7 19:18:45 2021
Compressing tables 3 and 4
Total compress table time: 8758.996 seconds. CPU (17.740%) Fri May  7 21:44:44 2021
Compressing tables 4 and 5
Total compress table time: 8628.411 seconds. CPU (18.170%) Sat May  8 00:08:32 2021
Compressing tables 5 and 6
Total compress table time: 9883.311 seconds. CPU (16.640%) Sat May  8 02:53:16 2021
Compressing tables 6 and 7
Total compress table time: 9240.788 seconds. CPU (15.930%) Sat May  8 05:27:17 2021
Time for phase 3 = 52401.585 seconds. CPU (17.650%) Sat May  8 05:27:17 2021

Starting phase 4/4: Write Checkpoint tables into "/chia/tmp/plot-k32-2021-05-06-17-51-af9e2c8f456a7b91e8fc1cd23dd8f19cc180cbe7c0eb96778df387c25cdbb81e.plot.2.tmp" ... Sat May  8 05:27:17 2021
        Starting to write C1 and C3 tables
        Finished writing C1 and C3 tables
        Writing C2 table
        Finished writing C2 table
        Final table pointers:
        P1: 0x10c
        P2: 0x3748e4eca
        P3: 0x6b6181aa8
        P4: 0x9fe0be1fc
        P5: 0xd564a4a90
        P6: 0x10da7c341a
        P7: 0x14ebd381c9
        C1: 0x190c8d84c9
        C2: 0x190ca7c051
        C3: 0x190ca7c101
Time for phase 4 = 3442.592 seconds. CPU (17.790%) Sat May  8 06:24:39 2021
Approximate working space used (without final file): 269.424 GiB
Final File size: 101.399 GiB
```
