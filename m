From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 07 Oct 2006 07:35:00 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061007093500.8373d429.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here you go. I attached the driver itself, and a Makefile to compile it
> off-tree. Just type "make modules" to build the driver and "make
> modules_install" to install it. Then "modprobe pc87427" should work.
> Let me know if not.
> 
> Once the driver is loaded you should have fan interface files
> under /sys/class/hwmon/hwmon0/device. The driver reports the current
> fan speed, the low limit speed, and two alarm flags per fan: fan too
> slow (fanX_alarm) and fan stalled/missing (fanX_fault).
> 
> Please report how it works for you! Thanks.

BTW, lm-sensors SVN now has userspace support for that new driver too,
so you can pick it and install it:
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4197-20061007.tar.bz2

-- 
Jean Delvare

