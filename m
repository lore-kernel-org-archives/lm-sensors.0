From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 14 Jun 2007 20:56:56 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <4671AB98.4090303@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <466E2E83.4010203@gmail.com>
In-Reply-To: <466E2E83.4010203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
> Thinking about it some more, I found 2 problems with your patch:
>
> * It breaks the ams driver:
> $ grep -r CONFIG_SENSORS drivers/hwmon/ams
> drivers/hwmon/ams/ams-core.c:#ifdef CONFIG_SENSORS_AMS_I2C
> drivers/hwmon/ams/ams-core.c:#ifdef CONFIG_SENSORS_AMS_PMU
> drivers/hwmon/ams/Makefile:ams-$(CONFIG_SENSORS_AMS_PMU)                += ams-pmu.o
> drivers/hwmon/ams/Makefile:ams-$(CONFIG_SENSORS_AMS_I2C)                += ams-i2c.o
> drivers/hwmon/ams/Makefile:obj-$(CONFIG_SENSORS_AMS)            += ams.o
> drivers/hwmon/ams/ams.h:#ifdef CONFIG_SENSORS_AMS_I2C
>
> You need to update these too.
>
> * It breaks a lot of default configurations:
> $ quilt grep CONFIG_SENSORS arch | wc -l
> 2729
> A number of these are for the drivers/i2c/chips part of your patch.
>
> So this will be a much bigger patch than you originally posted.
>   

Does the size (and the default config breakage!) change anything from 
your ends ?
the patch is easy to do ( perl -pi.bak -e 's/SENSORS_/HWMON_/'),
and easy to test (make allmodconfig - I didnt do this before, sorry)
but its not clear that its value-in-clarity is worth the churn (seen by 
everyone who builds)

thanks
-jimc


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
