From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Jan 2009 10:00:03 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090125110003.0194b3dd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

On Sun, 25 Jan 2009 15:11:51 +1300, Volker Kuhlmann wrote:
> There is a problem with kernels using the /sys/class/hwmon interface and
> the order in which modules are loaded. For lm_sensors directly this may
> not matter, but it will cause all/most/some fancontrol scripts to fail.
> 
> My Gigabyte GA-K8NF-9 mobo needs 
> 
> > cat /etc/sysconfig/lm_sensors
> MODULE_0=it87
> MODULE_1=k8temp
> 
> When I run /etc/init.d/lm_sensors restart from the command line it
> always works:
> 
>  /sys/class/hwmon/hwmon0 -> ../../devices/platform/it87.656/hwmon/hwmon0
>  /sys/class/hwmon/hwmon1 -> ../../devices/pci0000:00/0000:00:18.3/hwmon/hwmon1
> 
> However when booting, the fancontrol part of the service
> always fails. The reason is that when booting, hwmon entries are always
> created in reverse order.

No, that's not the reason. The reason is that the k8temp driver is one
of the few hwmon drivers which is loaded automatically at boot time
(because the K8 thermal sensors are implemented as a PCI device).

> My workaround for now is
> 
> > cat /etc/modprobe.d/sensors-hwmon-order
> install k8temp /sbin/modprobe it87; /sbin/modprobe --ignore-install k8temp
> remove k8temp /sbin/modprobe --ignore-remove --remove k8temp && /sbin/modprobe --remove it87
> 
> This hasn't been a problem for previous kernels. Was this by chance, or
> has something changed?

Can't really say as you didn't tell what was version your previous
kernel was and what version your new kernel is. But basically this
problem became frequent since the k8temp driver exists and auto-loads.
There have been other PCI hwmon devices in the past (drivers via686a,
vt8231) but they where usually the only hwmon device on the board so
the loading order didn't matter.

More specifically, the problem is that "service lm_sensors start" (or
whatever the command is for your specific distribution) at boot time is
influenced by the driver auto-loading, while "service lm_sensors
restart" isn't (because it removes all the drivers first.)

I'm not too sure how we can fix this problem. One possibility would be
to not list in /etc/sysconfig/lm_sensors the drivers which were already
loaded before sensors-detect is run. However this could be a problem if
sensors-detect is ran again a second time, because all required hwmon
drivers would be already loaded so none would be listed
in /etc/sysconfig/lm_sensors. This problem can be avoided by stopping
the lm_sensors service before running sensors-detect. I think some
distributions do that already.

I've created ticket 2368 to track this issue:
http://www.lm-sensors.org/ticket/2368

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
