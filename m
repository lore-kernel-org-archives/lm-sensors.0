From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Feb 2006 08:43:11 +0000
Subject: [lm-sensors] Ticket
Message-Id: <lHTCArYO.1140424991.1226810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2dedd0680602192048m4639ac6awb9a720207a9d3de1@mail.gmail.com>
In-Reply-To: <2dedd0680602192048m4639ac6awb9a720207a9d3de1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Istvan,

On 2006-02-20, Kis Istvan Csaba wrote:
> *[root at cl-86-125-141-8 lm_sensors-2.10.0]# uname -r
> 2.6.12-1.1381_FC3
>
> [root at cl-86-125-141-8 lm_sensors-2.10.0]# lsmod | grep i2c
> i2c_dev                10945  0
> i2c_sensor           3393    2 eeprom,it87
> i2c_isa                 2241    0
> i2c_viapro            8017    0
> i2c_core               21313  6
> eeprom,i2c_dev,it87,i2c_sensor,i2c_isa,i2c_viapro
>
> [root at cl-86-125-141-8 lm_sensors-2.10.0]# cat /etc/fstab
> # This file is edited by fstab-sync - see 'man fstab-sync' for details
> LABEL=/                 /                       ext3    defaults        1 1
> none                    /dev/pts                devpts  gid=5,modeb0  0 0
> none                    /dev/shm                tmpfs   defaults        0 0
> none                    /proc                   proc    defaults        0 0
> none                    /sys                    sysfs   defaults        0 0
> /dev/hda6               swap                    swap    defaults        0 0
> /dev/hdb                /media/cdrecorder       auto
> pamconsole,exec,noauto,fscontext=system_u:object_r:removable_t,managed 0 0
>
> [root at cl-86-125-141-8 lm_sensors-2.10.0]# sensors -s
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
>
>
> Please help me! :)

Please provide the output of:

sensors -v (to make sure you are not linking with an old library)

sensors-detect (after unloading the eeprom and it87 modules)

ls -l /sys/bus/i2c/*

ls -l /sys/class/hwmon/*

Anything in the logs when you loaded the it87 module?

Does the decode-dimms.pl script output anything?

Thanks,
--
Jean Delvare

