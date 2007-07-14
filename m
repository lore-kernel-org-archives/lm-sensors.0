From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jul 2007 20:00:27 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <20070714220027.20c2d903@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, hi Darrick,

On Fri, 13 Jul 2007 14:49:12 +0200, Hans de Goede wrote:
> Darrick J. Wong wrote:
> > But every time I run sensors (from svn) I see only this:
> > root@elm3a181:/usr/local/src/lm_sensors/prog# sensors/sensors -c
> > /tmp/sensors.conf 
> > adt7470-i2c-0-2f
> > Can't get adapter name for bus 0
> 
> While the "Can't get adapter name for bus 0" message is strange, its also 
> harmless.

I confirm it is harmless. Typically, it happens when you are using
lm-sensors <= 2.10.2, a kernel >= 2.6.22, and you did not enable
CONFIG_SYSFS_DEPRECATED in your kernel. So the fix is to either upgrade
to lm-sensors 2.10.3 or later, or rebuild your kernel with
CONFIG_SYSFS_DEPRECATED=y.

This is explained on this page for reference:
http://www.lm-sensors.org/wiki/Kernel2.6

Now Darrick says he has the problem with lm-sensors SVN, which is more
surprising. Maybe sensors is linking with an older version of
libsensors present on the system. This theory can be confirmed by
running "sensors -v".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
