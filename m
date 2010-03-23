From: Sergey Spiridonov <sena@hurd.homeunix.org>
Date: Tue, 23 Mar 2010 10:29:35 +0000
Subject: [lm-sensors] Fujitsu D2778 sensors
Message-Id: <fphm77-hj.ln1@legba.gamic.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

I got Fujitsu mainboard D2778 and I need to run sesnors on
Linux Gentoo with kernel 2.6.30 or 2.6.31. I found contribution of Thilo
Cestonaro on lm-sensors.org [1]. As far as I understood, this is his
config for on that mainboard.

1.
http://www.lm-sensors.org/wiki/Configurations/FujitsuTechnologySolutions/D2778%20(A1%2C%20B1%20%2CC1%2C%20X1%2C%20Y1)


I tried it and it does not work for me. May anybody confirm that it
works with Fujitsu D2778?

Here is what i get:

# modprobe fschmd

# lsmod| grep fsc
fschmd                 18576  0
hwmon                   2528  1 fschmd
i2c_core               19832  3 fschmd,i2c_dev,i2c_i801

# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

# cat /etc/sensors.conf
# Fujitsu Technology Solutions D2778 (A1, B1 ,C1, X1, Y1), "Syleus"-Chip
# Contributed by Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>

chip "fscsyl-*"

# Temperatures
    label temp1 "CPU Temp"
    ignore temp2
    ignore temp3
    label temp4 "Super I/O Temp"
    label temp5 "Northbridge Temp"

# Fans
    label fan1 "CPU Fan"
    label fan2 "System FAN2"
    label fan3 "System FAN3"
    label fan4 "System FAN4"
    label fan7 "PSU Fan"

# Voltages
    label in0 "+12V"
    label in1 "+5V"
    label in2 "Vbat"
    ignore in4
    label in3 "+3.3V"
    label in5 "+3.3V-Aux"
-- 
Best regards, Sergey Spiridonov


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
