From: Helmut Grohne <helmut@subdivi.de>
Date: Wed, 12 Mar 2008 01:14:32 +0000
Subject: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312011430.GA20751@alf.mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

(I'm posting from outside, so please CC me on a reply.)

Some time ago I updated my kernel to 2.6.23.14 (vanilla) from something
pre-20. My system has a w83627ehf chip (the chip is labeled like that)
and the support for this chip seemed to have improved.

However my cpu fan "occasionally" stops spinning. This happened three
times at the time of this writing. It seems to happen when the system is
completely idle. As a result the cpu heats up and maybe destroying or
damaging itself over time. This is BAD!

I therefore tried to play with the /sys/devices/platform/w83627ehf.*/
interface. Changing the files pwm2* "sometimes" has an barely
predictable effect on the cpu fan. I was for instance able to start the
fan again by writing 2 to pwm2_enable the last time it stopped. However
I cannot disable the fan now by writing 0 to pwm2 which sometimes worked
before. Most of my writing data to these files seems to get ignored.

The only thing I really need now is a stable cpu fan. Can I somehow lock
it to maximum speed or something similar? Can I somehow run w83627ehf
with reduced functionality (like no longer modifying the fan at all)?

Please help me debug this. Do you want any other information not found
below?

Helmut Grohne


root@# i2cdetect
...
  Installed I2C busses:
    i2c-0       smbus           SMBus Via Pro adapter at 5000
root@# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         
root@# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 01 01 ff 03 00 01 30 01 b1 01 01 3c 3c 01 01 
10: 01 ff 10 01 00 01 01 3c 43 07 00 00 57 00 00 c7 
20: 98 e4 cf cf ff c7 c7 26 ff 04 ff 01 00 01 df fd 
30: ef 5f b6 01 dc 01 01 01 ed 01 28 01 05 01 1f ff 
40: 01 ff a8 de ff ff 00 f0 2d ff 40 c1 10 15 01 a3 
50: 2c 00 00 01 00 50 00 ff ff ff ff ff ff ff ff ff 
60: 01 ff 40 01 01 01 3c ff 01 ff 01 ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
root@# cat sensor_fix.sh 
#!/bin/bash
# this script is now invoked every 5 minutes from cron to try and fix
# the fan automatically.

cd /sys/devices/platform/w83627ehf.* || exit 1

test $(<fan2_input) -le 2000 || exit 0

echo fan not spinning

while :; do
        echo "trying pwm2_enable 2"
        echo 2 > pwm2_enable
        sleep 1
        test $(<fan2_input) -le 2000 || exit 0

        echo "trying pwm2 255"
        echo 255 > pwm2
        sleep 1
        test $(<fan2_input) -le 2000 || exit 0

        echo "trying pwm2_enable 1"
        echo 1 > pwm2_enable
        sleep 1
        test $(<fan2_input) -le 2000 || exit 0

        echo "trying pwm2 255"
        echo 255 > pwm2
        sleep 1
        test $(<fan2_input) -le 2000 || exit 0

        echo "trying pwm2_target 1000"
        echo 1000 > pwm2_target
        sleep 1
        test $(<fan2_input) -le 2000 || exit 0
done
root@# exit
helmut@$ dmesg
...
w83627ehf: Found W83627EHG chip at 0x290
...
helmut@$ dpkg -k lm-sensors
...
ii  lm-sensors 1:3.0.1-2 utilities to read temperature/voltage/fan sensors
helmut@$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. K8T890 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8T890 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8T890 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8T890 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8T890 Host Bridge
00:00.5 PIC: VIA Technologies, Inc. K8T890 I/O APIC Interrupt Controller
00:00.7 Host bridge: VIA Technologies, Inc. K8T890 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
00:02.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.1 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.2 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.3 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
02:00.0 VGA compatible controller: nVidia Corporation NV44 [GeForce 6200 TurboCache(TM)] (rev a1)
05:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 19)
helmut@$ lsmod
...
w83627ehf              26184  0
ac                      6728  0 
cpufreq_userspace       5228  0
cpufreq_ondemand       10064  1
cpufreq_powersave       2368  0
powernow_k8            15584  1
freq_table              5520  3 cpufreq_stats,cpufreq_ondemand,powernow_k8
hwmon_vid               4160  1 w83627ehf
i2c_viapro             10584  0 
k8temp                  6848  0
hwmon                   4104  2 w83627ehf,k8temp
i2c_core               28800  1 i2c_viapro
thermal                18336  0 
processor              38952  2 powernow_k8,thermal
fan                     6216  0
...
helmut@$

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
