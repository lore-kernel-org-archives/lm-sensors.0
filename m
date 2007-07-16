From: Marcin Dawidowicz <marcin.dawidowicz@kontron.pl>
Date: Mon, 16 Jul 2007 17:45:12 +0000
Subject: Re: [lm-sensors] Support for sch311x
Message-Id: <469BAEA8.90208@kontron.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707090909j63416c60lfc7ca6f689091966@mail.gmail.com>
In-Reply-To: <191fb4ca0707090909j63416c60lfc7ca6f689091966@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Thank you.

I've done short test of your driver and at first sight it seems to work 
quite well with SCH3112. It was tested on CP6012 CPU board from Kontron.

I found some issues which should be improved. One of those is resetting 
of alarms. Now, after alarm appeared it remains set - it is not cleared 
by sensor reading. (maybe not perfect but simplest would be resetting 
all alarms after sensors are read - look into my driver)

I think that temperature fault reading return improper values (see 
printout below).

Below is short snapshot of test:
.....
marcda@marcda-laptop:/lib/modules/2.6.22/kernel/drivers/hwmon$ sudo 
modprobe dme1737
Password:
marcda@marcda-laptop:/lib/modules/2.6.22/kernel/drivers/hwmon$
.....

.....
marcda@marcda-laptop:/lib/modules/2.6.22/kernel/drivers/hwmon$ dmesg |tail
[   26.916000] Bluetooth: HCI socket layer initialized
[   27.016000] Bluetooth: L2CAP ver 2.8
[   27.016000] Bluetooth: L2CAP socket layer initialized
[   27.052000] Bluetooth: RFCOMM socket layer initialized
[   27.052000] Bluetooth: RFCOMM TTY layer initialized
[   27.052000] Bluetooth: RFCOMM ver 1.8
[   33.604000] eth5: no IPv6 routers present
[ 3879.928000] PM: Adding info for platform:dme1737.2672
[ 3879.928000] dme1737 dme1737.2672: Found a SCH311X chip at 0x0a70
[ 3879.928000] dme1737 dme1737.2672: Optional features: pwm3=yes, 
pwm5=no, pwm6=no, fan3=yes, fan4=no, fan5=no, fan6=no.
marcda@marcda-laptop:/lib/modules/2.6.22/kernel/drivers/hwmon$
.....

.....
root@marcda-laptop:/sys/class/hwmon/hwmon0/device/driver/dme1737.2672# 
clear;for file in *_*; do echo "$file = `cat $file`"; done     cpu0_vid = 0
fan1_alarm = 0
fan1_input = 0
fan1_min = 0
fan1_type = 2
fan2_alarm = 0
fan2_input = 0
fan2_min = 0
fan2_type = 2
fan3_alarm = 0
fan3_input = 0
fan3_min = 0
fan3_type = 2
in0_alarm = 0
in0_input = 3610
in0_max = 6641
in0_min = 0
in1_alarm = 0
in1_input = 1625
in1_max = 2988
in1_min = 0
in2_alarm = 1
in2_input = 3303
in2_max = 3334
in2_min = 0
in3_alarm = 0
in3_input = 4993
in3_max = 6641
in3_min = 0
in4_alarm = 0
in4_input = 11965
in4_max = 15938
in4_min = 0
in5_alarm = 0
in5_input = 3309
in5_max = 4383
in5_min = 0
in6_alarm = 0
in6_input = 2983
in6_max = 4383
in6_min = 0
pwm1_auto_channels_zone = 1
pwm1_auto_point1_pwm = 128
pwm1_auto_point2_pwm = 255
pwm1_auto_pwm_min = 128
pwm1_enable = 0
pwm1_freq = 25000
pwm1_ramp_rate = 206
pwm2_auto_channels_zone = 2
pwm2_auto_point1_pwm = 128
pwm2_auto_point2_pwm = 255
pwm2_auto_pwm_min = 128
pwm2_enable = 0
pwm2_freq = 25000
pwm2_ramp_rate = 206
pwm3_auto_channels_zone = 4
pwm3_auto_point1_pwm = 128
pwm3_auto_point2_pwm = 255
pwm3_auto_pwm_min = 128
pwm3_enable = 0
pwm3_freq = 25000
pwm3_ramp_rate = 0
temp1_alarm = 0
temp1_fault = 0
temp1_input = 35562
temp1_max = 127000
temp1_min = -127000
temp1_offset = 0
temp2_alarm = 0
temp2_fault = 0
temp2_input = 33750
temp2_max = 127000
temp2_min = -127000
temp2_offset = 0
temp3_alarm = 1
temp3_fault = 0
temp3_input = -128000
temp3_max = 127000
temp3_min = -127000
temp3_offset = 0
zone1_auto_channels_temp = 1
zone1_auto_point1_temp = 90000
zone1_auto_point1_temp_hyst = 90000
zone1_auto_point2_temp = 122000
zone1_auto_point3_temp = 100000
zone2_auto_channels_temp = 2
zone2_auto_point1_temp = 90000
zone2_auto_point1_temp_hyst = 90000
zone2_auto_point2_temp = 122000
zone2_auto_point3_temp = 100000
zone3_auto_channels_temp = 4
zone3_auto_point1_temp = 90000
zone3_auto_point1_temp_hyst = 90000
zone3_auto_point2_temp = 122000
zone3_auto_point3_temp = 100000
root@marcda-laptop:/sys/class/hwmon/hwmon0/device/driver/dme1737.2672#
.....

I will let you know if I find something more.

Regards,
Marcin

Juerg Haefliger wrote:
> Hi Marcin,
>
> The attached updated dme1737 driver includes support for the sch311x
> chips. Could you please test it and report success/failure?
>
> Thanks
> ...juerg 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
