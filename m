From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Tue, 26 Jan 2016 08:37:02 +0000
Subject: Re: [lm-sensors] [rtc-linux] [PATCH v4] rtc: rtc-ds1307: add temperature sensor support for ds3231
Message-Id: <20160126083702.GF11740@piout.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453648936-17017-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1453648936-17017-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, Alessandro Zummo <a.zummo@towertech.it>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>

On 25/01/2016 at 00:22:16 +0900, Akinobu Mita wrote :
> DS3231 has the temperature registers with a resolution of 0.25
> degree celsius.  This enables to get the value through hwmon.
> 
> 	# cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
> 	21000
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
> * v4 (all changes are suggested by Guenter Roeck)
> - drop the Cc: mailing lists in commit log
> - add Acked-by line
> - remove unnecessary header include
> - s/s32/int/
> - make ds1307_hwmon_register() a void function as the return value is not used
> 
>  drivers/rtc/Kconfig      |  9 +++++
>  drivers/rtc/rtc-ds1307.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
