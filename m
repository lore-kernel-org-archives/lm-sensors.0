From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jun 2007 18:26:28 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <20070614202628.6cb1b8f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <466E2E83.4010203@gmail.com>
In-Reply-To: <466E2E83.4010203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Mon, 11 Jun 2007 23:26:27 -0600, Jim Cromie wrote:
> 
> (patch attached, with this stuff at the top - hope thats ok)
> 
> This changes SENSORS to HWMON in Kconfig and Makefile,
> which makes it agree with 'menuconfig HWMON' at the top of Kconfig,
> and with the dir-name itself.  ISTM that theres no reason
> (save legacy) to keep this arbitrary difference.
> 
> Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>
> ---
> [jimc@harpo hwmon-stuff]$ diffstat diff.conf-sensors-2-hwmon
>  Kconfig  |  110 +++++++++++++++++++++++++++++++--------------------------------
>  Makefile |  102 +++++++++++++++++++++++++++++-----------------------------
>  2 files changed, 106 insertions(+), 106 deletions(-)

Thinking about it some more, I found 2 problems with your patch:

* It breaks the ams driver:
$ grep -r CONFIG_SENSORS drivers/hwmon/ams
drivers/hwmon/ams/ams-core.c:#ifdef CONFIG_SENSORS_AMS_I2C
drivers/hwmon/ams/ams-core.c:#ifdef CONFIG_SENSORS_AMS_PMU
drivers/hwmon/ams/Makefile:ams-$(CONFIG_SENSORS_AMS_PMU)                += ams-pmu.o
drivers/hwmon/ams/Makefile:ams-$(CONFIG_SENSORS_AMS_I2C)                += ams-i2c.o
drivers/hwmon/ams/Makefile:obj-$(CONFIG_SENSORS_AMS)            += ams.o
drivers/hwmon/ams/ams.h:#ifdef CONFIG_SENSORS_AMS_I2C

You need to update these too.

* It breaks a lot of default configurations:
$ quilt grep CONFIG_SENSORS arch | wc -l
2729
A number of these are for the drivers/i2c/chips part of your patch.

So this will be a much bigger patch than you originally posted.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
