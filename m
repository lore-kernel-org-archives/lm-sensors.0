From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 04 Jul 2006 22:12:40 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <44AAE7D8.9020402@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

After few hundreds kilometers in train and many hours outside of it I have
finally finished initial review. And I still dont know if I catched everything.

I'm attaching the driver with comments.

I would like to fix for sure:

1) step time/stop time unit to milliseconds
2) tolerance/range temperature to milidegrees of celsius, plus there is a little
problem with sysfs names. For EHF driver they are like this:
ruik at ruik:/sys/bus/i2c/devices/9191-0290$ ls pwm1*
pwm1  pwm1_enable  pwm1_min_output  pwm1_mode  pwm1_stop_time  pwm1_target
pwm1_tolerance

Because they are tight to pwm but your chip design has it tighten to temps... I
guess we cannot change it anyway...

Please can you provide some short documentation for new sysfs files that are
somewhat non-standard so we may discuss the names?

For example temp##index##_fan_map would be better name
temp[1-*]_auto_channels_pwm because we already define pwm[1-*]_auto_channels_temp

3)  WRITE_TO_REG
    is bad :) Please do not trust the cached values always write new one. ACPI
   might changed the value in your behind ;)

if (0 <= w83793_write_value(client, REG

Does not look nice too.

Plus there are many more comments and ideas in annotated driver. There are three
of my TODOs I will do that soon or later.

I'm offline starting tomorrow noon for two days so I will be not able to respond.

I think I will be able to respond you in morning if you have some questions to
my mail ;)

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83793.c
Type: application/octet
Size: 49177 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060705/4cc2553f/attachment-0001.bin 
