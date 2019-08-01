#!/bin/bash
#
# SCA Data mover Challenge FIO tests
#
# andrew@nscc.sg
#

     mkdir FIO
     cd FIO

     block_dev=$PWD/10G
     echo $block_dev
     sleep 10

     echo "Test 1
-----------------------------------------------------------------------------------------------------------------------------"
     echo "Full write pass"
     echo "fio --name=writefile --size=10G --filesize=10G
--filename=$block_dev --bs=1M --nrfiles=1 --direct=1 --sync=0
--randrepeat=0 --rw=write --refill_buffers --end_fsync=1 --iodepth=
200 --ioengine=libaio"

     fio --name=writefile --size=10G --filesize=10G \
       --filename=$block_dev --bs=1M --nrfiles=1 \
       --direct=1 --sync=0 --randrepeat=0 --rw=write --refill_buffers \
       --end_fsync=1 \
       --iodepth=200 --ioengine=libaio
     echo
"------------------------------------------------------------------------------------------------------------------------------------"

     echo "Test 2
-----------------------------------------------------------------------------------------------------------------------------"
     echo "Rand read"
     echo "fio --time_based --name=benchmark --size=10G --runtime=30
--filename=$block_dev --ioengine=libaio --randrepeat=0 --iodepth=128
--direct=1 --invalidate=1 --verify=0 --verify_fat
al=0 --numjobs=4 --rw=randread --blocksize=4k --group_reporting"

     fio --time_based --name=benchmark --size=10G --runtime=30 \
       --filename=$block_dev --ioengine=libaio --randrepeat=0 \
       --iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 \
       --numjobs=4 --rw=randread --blocksize=4k --group_reporting
     echo
"------------------------------------------------------------------------------------------------------------------------------------"

     echo "Test 3
-----------------------------------------------------------------------------------------------------------------------------"
     echo "Rand write"
     echo "fio --time_based --name=benchmark --size=10G --runtime=30
--filename=$block_dev --ioengine=libaio --randrepeat=0 --iodepth=128
--direct=1 --invalidate=1 --verify=0 --verify_fat
al=0 --numjobs=4 --rw=randwrite --blocksize=4k --group_reporting"

     fio --time_based --name=benchmark --size=10G --runtime=30 \
       --filename=$block_dev --ioengine=libaio --randrepeat=0 \
       --iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 \
       --numjobs=4 --rw=randwrite --blocksize=4k --group_reporting
     echo
"------------------------------------------------------------------------------------------------------------------------------------"

     echo "Test 4
-----------------------------------------------------------------------------------------------------------------------------"
     echo "16 KB random write"
     echo "fio --name fio_test_file --direct=1 --rw=randwrite --bs=4k
--size=1G --numjobs=16 --time_based --runtime=180 --group_reporting"

     fio --name fio_test_file --direct=1 --rw=randwrite --bs=4k \
       --size=1G --numjobs=16 --time_based --runtime=180 --group_reporting
     echo
"------------------------------------------------------------------------------------------------------------------------------------"

     echo "Test 5
-----------------------------------------------------------------------------------------------------------------------------"
     echo "16 KB random read"
     echo "fio --name fio_test_file --direct=1 --rw=randread --bs=4k
--size=1G --numjobs=16 --time_based --runtime=180 --group_reporting"

     fio --name fio_test_file --direct=1 --rw=randread --bs=4k --size=1G \
       --numjobs=16 --time_based --runtime=180 --group_reporting
     echo
"------------------------------------------------------------------------------------------------------------------------------------"

     echo "Test 6
-----------------------------------------------------------------------------------------------------------------------------"
     echo "Random Write Test using libaio and direct flag"
     echo "fio --name=randwrite --ioengine=libaio --iodepth=16
--rw=randwrite --bs=4k --direct=1 --size=1G --numjobs=8 --runtime=240
--group_reporting"

     fio --name=randwrite --ioengine=libaio --iodepth=16 --rw=randwrite \
       --bs=4k --direct=1 --size=1G --numjobs=8 --runtime=240 --group_reporting
     echo
"------------------------------------------------------------------------------------------------------------------------------------"

     echo "Test 7
-----------------------------------------------------------------------------------------------------------------------------"
     echo "Random Read Test using libaio and direct flag"
     echo "fio --name=randread --ioengine=libaio --iodepth=16
--rw=randread --bs=4k --direct=1 --size=1G --numjobs=8 --runtime=240
--group_reporting"

     fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread \
       --bs=4k --direct=1 --size=1G --numjobs=8 --runtime=240 --group_reporting
     echo
"------------------------------------------------------------------------------------------------------------------------------------"
