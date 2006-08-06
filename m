From: johannes@sipsolutions.net (Johannes Berg)
Date: Sun, 06 Aug 2006 11:41:02 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <1154864462.31814.29.camel@johannes.berg>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2006-08-02 at 21:15 +0200, Michael Hanselmann wrote:

> +config SENSORS_AMS
> +       tristate "Apple Motion Sensor driver"
> +       depends on HWMON && PPC_PMAC && INPUT && EXPERIMENTAL

This causes the build failure, because now SENSORS_AMS can be 'y' while 

> +config SENSORS_AMS_I2C
> +       bool "I2C variant"
> +       depends on SENSORS_AMS && I2C

is satisfied by I2C=m. I think.

SENSORS_AMS should probably have
	depends on HWMON && PPC_PMAC && INPUT && (ADB_PMU || I2C) && EXPERIMENTAL

Is it possible to check further constraints? This still doesn't solve
all problems since I2C=m and ADB_PMU=y would satisfy SENSORS_AMS=y, but
that'd still lead to a build failure with SENSORS_AMS_I2C=y.

I'm not sure if that's possible to solve at all. But since ADB_PMU is
practically required even on those machines where we have the I2C
version of the sensor (they'll boot IIRC, but most things won't work
without it), how about just depending on that anyway? Hence making the
dependency
	depends on HWMON && PPC_PMAC && INPUT && ADB_PMU && I2C && EXPERIMENTAL

Also, "default y" should go away, and be put into the ppc32_defconfig.
We don't ever need this on ppc64. The dependency on ADB_PMU would of
course stop people from building it on ppc64 :)

johannes
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060806/29aaade5/attachment.bin 
