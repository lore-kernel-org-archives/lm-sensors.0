From: Volker Kuhlmann <list0570@paradise.net.nz>
Date: Sun, 25 Jan 2009 02:11:51 +0000
Subject: [lm-sensors] Problem with order of module loading
Message-Id: <20090125021151.GE16739@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is a problem with kernels using the /sys/class/hwmon interface and
the order in which modules are loaded. For lm_sensors directly this may
not matter, but it will cause all/most/some fancontrol scripts to fail.

My Gigabyte GA-K8NF-9 mobo needs 

> cat /etc/sysconfig/lm_sensors
MODULE_0=it87
MODULE_1=k8temp

When I run /etc/init.d/lm_sensors restart from the command line it
always works:

 /sys/class/hwmon/hwmon0 -> ../../devices/platform/it87.656/hwmon/hwmon0
 /sys/class/hwmon/hwmon1 -> ../../devices/pci0000:00/0000:00:18.3/hwmon/hwmon1

However when booting, the fancontrol part of the service
always fails. The reason is that when booting, hwmon entries are always
created in reverse order.

My workaround for now is

> cat /etc/modprobe.d/sensors-hwmon-order
install k8temp /sbin/modprobe it87; /sbin/modprobe --ignore-install k8temp
remove k8temp /sbin/modprobe --ignore-remove --remove k8temp && /sbin/modprobe --remove it87

This hasn't been a problem for previous kernels. Was this by chance, or
has something changed?

Volker

-- 
Volker Kuhlmann			is list0570 with the domain in header
http://volker.dnsalias.net/	Please do not CC list postings to me.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
