From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Jun 2007 11:08:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <20070606130839.7a2731e9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Wed, 6 Jun 2007 12:35:22 +0200, Ivo Manca wrote:
> I've removed the kernel source, extracted a fresh tarball, applied the 
> patches and recompiled the kernel&modules.
> After copying them to the other pc and rebooting it, the following output 
> was shown:
> 
> [root@localhost ~]# sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> 
> If you need more information, just ask

Which version of lm-sensors are you using? Platform device support was
only added in 2.10.0, and received some fixes in 2.10.1. (With 2.10.0
you need to load at least one i2c driver, even unrelated, for it to
work.)

If you already have lm-sensors version >= 2.10.1, please compile with
CONFIG_HWMON_DEBUG_CHIP=y and look into your logs when loading the
driver. Also check what you see under /sys/class/hwmon
and /sys/bus/platform.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
