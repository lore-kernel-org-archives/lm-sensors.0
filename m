From: kress@hal.saar.de (Michael Kress)
Date: Sun, 08 Oct 2006 10:25:08 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <4528D204.6090601@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:
>> [root at matrix PC87427]# modprobe -v pc87427
>> insmod /lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87427.ko
>> FATAL: Error inserting pc87427
>> (/lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87427.ko): Invalid
>> module format
>> Have you got an idea what's going wrong?
>>
>>     
>
> I'm having similar problem with another tester for another driver
> off-list. It's usually a matter of adding some flag at compilation
> time. Any hint in the logs (dmesg or /var/log/messages)? Is this a
> 64-bit system?
>   
Salut Jean,

thanks a lot for the hint, I didn't see the syslog - it seems to work
well now:
Oct  8 11:59:50 matrix kernel: overflow in relocation type 10 val
ffffffff881b6ec8
Oct  8 11:59:50 matrix kernel: `pc87427' likely not compiled with
-mcmodel=kernel

so I added -mcmodel=kernel to the Makefile's CFLAGS, which made the
modprobe working.

for i in /sys/class/hwmon/hwmon0/device/fan[1-8]_*; do echo $i; cat $i; done
[root at matrix PC87427]# /sys/class/hwmon/hwmon0/device/fan1_alarm
0
/sys/class/hwmon/hwmon0/device/fan1_fault
0
/sys/class/hwmon/hwmon0/device/fan1_input
3668
/sys/class/hwmon/hwmon0/device/fan1_min
712
/sys/class/hwmon/hwmon0/device/fan2_alarm
0
/sys/class/hwmon/hwmon0/device/fan2_fault
0
/sys/class/hwmon/hwmon0/device/fan2_input
3383
/sys/class/hwmon/hwmon0/device/fan2_min
712
/sys/class/hwmon/hwmon0/device/fan3_alarm
0
/sys/class/hwmon/hwmon0/device/fan3_fault
0
/sys/class/hwmon/hwmon0/device/fan3_input
3391
/sys/class/hwmon/hwmon0/device/fan3_min
712
/sys/class/hwmon/hwmon0/device/fan4_alarm
0
/sys/class/hwmon/hwmon0/device/fan4_fault
0
/sys/class/hwmon/hwmon0/device/fan4_input
3366
/sys/class/hwmon/hwmon0/device/fan4_min
712
/sys/class/hwmon/hwmon0/device/fan5_alarm
0
/sys/class/hwmon/hwmon0/device/fan5_fault
1
/sys/class/hwmon/hwmon0/device/fan5_input
0
/sys/class/hwmon/hwmon0/device/fan5_min
712
/sys/class/hwmon/hwmon0/device/fan6_alarm
0
/sys/class/hwmon/hwmon0/device/fan6_fault
0
/sys/class/hwmon/hwmon0/device/fan6_input
2848
/sys/class/hwmon/hwmon0/device/fan6_min
712
/sys/class/hwmon/hwmon0/device/fan7_alarm
0
/sys/class/hwmon/hwmon0/device/fan7_fault
1
/sys/class/hwmon/hwmon0/device/fan7_input
0
/sys/class/hwmon/hwmon0/device/fan7_min
712
/sys/class/hwmon/hwmon0/device/fan8_alarm
0
/sys/class/hwmon/hwmon0/device/fan8_fault
0
/sys/class/hwmon/hwmon0/device/fan8_input
2800
/sys/class/hwmon/hwmon0/device/fan8_min
712

(there's no fans 5 and 7 installed as there's no more room in the chassis).

Perfect - thanks a lot again!
Although this is already sufficient to monitor I'll try the userspace
lm-sensors part and I'll give you feedback on that.

Kind Regards - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


