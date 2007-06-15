From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Jun 2007 18:20:09 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-pre] s/SENSORS_/HWMON_/  in Kconfig,
Message-Id: <20070615202009.0e2847c0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <466E2E83.4010203@gmail.com>
In-Reply-To: <466E2E83.4010203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Jun 2007 14:56:56 -0600, Jim Cromie wrote:
> Jean Delvare wrote:
> > Thinking about it some more, I found 2 problems with your patch:
> >
> > * It breaks the ams driver:
> > $ grep -r CONFIG_SENSORS drivers/hwmon/ams
> > drivers/hwmon/ams/ams-core.c:#ifdef CONFIG_SENSORS_AMS_I2C
> > drivers/hwmon/ams/ams-core.c:#ifdef CONFIG_SENSORS_AMS_PMU
> > drivers/hwmon/ams/Makefile:ams-$(CONFIG_SENSORS_AMS_PMU)                += ams-pmu.o
> > drivers/hwmon/ams/Makefile:ams-$(CONFIG_SENSORS_AMS_I2C)                += ams-i2c.o
> > drivers/hwmon/ams/Makefile:obj-$(CONFIG_SENSORS_AMS)            += ams.o
> > drivers/hwmon/ams/ams.h:#ifdef CONFIG_SENSORS_AMS_I2C
> >
> > You need to update these too.
> >
> > * It breaks a lot of default configurations:
> > $ quilt grep CONFIG_SENSORS arch | wc -l
> > 2729
> > A number of these are for the drivers/i2c/chips part of your patch.
> >
> > So this will be a much bigger patch than you originally posted.
> 
> Does the size (and the default config breakage!) change anything from 
> your ends ?
> the patch is easy to do ( perl -pi.bak -e 's/SENSORS_/HWMON_/'),
> and easy to test (make allmodconfig - I didnt do this before, sorry)
> but its not clear that its value-in-clarity is worth the churn (seen by 
> everyone who builds)

Admittedly, this becomes much bigger than I initially thought, so I'm a
bit hesitant now. I think it's still worth it for the i2c/chips part,
because there, we're calling SENSORS devices which aren't and this is
confusing; and the count is lower. For HWMON vs. SENSORS, it can be
confusing but at least it's not plain wrong - so I'd say leave it alone.

But this is just my feeling of the moment. If others feel more strongly
one direction or the other, I won't insist either way.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
