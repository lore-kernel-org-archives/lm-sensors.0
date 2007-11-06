From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Nov 2007 21:51:17 +0000
Subject: Re: [lm-sensors] LM75: "ERROR: Can't get temperature data!"
Message-Id: <20071106225117.33918856@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1194039013.25315.2.camel@louie>
In-Reply-To: <1194039013.25315.2.camel@louie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Tue, 06 Nov 2007 12:10:39 -0600, Michael Brian Willis wrote:
> Thank you for your response. Below is the information you requested. 
> Thanks again for your help!
> -----
> 
> > Odd. Please check that no older libsensors version gets in the way
> > (sensors -v).
> [root@myboard /]# sensors -v
> sensors version 2.10.5 with libsensors version 2.10.5

OK, that's correct.

> > Also, please provide the output of "ls -lR /sys/class/hwmon/*/device/".
> [root@myboard /]# ls -lR /sys/class/hwmon/*/device/
> /sys/class/hwmon/hwmon0/device/:
> total 0
> -r--r--r-- 1 root root 4096 Dec 31  1969 alarms

Unrelated to your problem, but it seems to me that your clock is slightly off ;)

> lrwxrwxrwx 1 root root    0 Dec 31  1969 bus -> ../../../../../bus/i2c
> lrwxrwxrwx 1 root root    0 Dec 31  1969 driver -> ../../../../../bus/i2c/drivers/max1619
> lrwxrwxrwx 1 root root    0 Dec 31  1969 hwmon:hwmon0 -> ../../../../../class/hwmon/hwmon0
> -r--r--r-- 1 root root 4096 Dec 31  1969 name
> lrwxrwxrwx 1 root root    0 Dec 31  1969 subsystem -> ../../../../../bus/i2c
> -r--r--r-- 1 root root 4096 Dec 31  1969 temp1_input
> -rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_crit
> -rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_crit_hyst
> -r--r--r-- 1 root root 4096 Dec 31  1969 temp2_input
> -rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_max
> -rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_min
> --w------- 1 root root 4096 Dec 31  1969 uevent

This one looks correct.

> /sys/class/hwmon/hwmon1/device/:
> total 0
> lrwxrwxrwx 1 root root    0 Dec 31  1969 bus -> ../../../../../bus/i2c
> lrwxrwxrwx 1 root root    0 Dec 31  1969 driver -> ../../../../../bus/i2c/drivers/lm75
> lrwxrwxrwx 1 root root    0 Dec 31  1969 hwmon:hwmon1 -> ../../../../../class/hwmon/hwmon1
> drwxr-xr-x 2 root root    0 Dec 31  1969 lm75
> -r--r--r-- 1 root root 4096 Dec 31  1969 name
> lrwxrwxrwx 1 root root    0 Dec 31  1969 subsystem -> ../../../../../bus/i2c
> --w------- 1 root root 4096 Dec 31  1969 uevent
> 
> /sys/class/hwmon/hwmon1/device/lm75:
> total 0
> -r--r--r-- 1 root root 4096 Dec 31  1969 temp1_input
> -rw-r--r-- 1 root root 4096 Dec 31  1969 temp1_max
> -rw-r--r-- 1 root root 4096 Dec 31  1969 temp1_max_hyst


But this one does not! The attributes are in a subdirectory ("lm75")
instead of being directly in the device's directory. libsensors doesn't
expect this and fails. The lm75 driver in the vanilla kernel does NOT
do this, so I suspect that you're using a modified driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
