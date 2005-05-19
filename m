From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: 2.8.7 doesnt see sensors on my machine.
Message-Id: <20040626221941.01a93225.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406190250.i5J2oDgJ005370@orion.dwf.com>
In-Reply-To: <200406190250.i5J2oDgJ005370@orion.dwf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I did find that in the startup script for init.d there is some logic 
> looking for sensors in /proc, viz
> 
> ### If sensors isn't supported by the kernel, try loading the
> #module...##
> ### [ -e /proc/sys/dev/sensors ] || /sbin/modprobe i2c-proc
> #&>/dev/null##
> ### # Don't bother if /proc/sensors still doesn't exist, kernel
> #doesn't have## # support for sensors.
> ### [ -e /proc/sys/dev/sensors ] || exit 0
> ###
> ### # If sensors was not already running, unload the module...
> 
> and I have had to comment this section out. 
> There is nothing I can do that seems to make /proc/sys/dev/sensors
> appear in the 2.6.6 kernel.  In particular, the 'modprobe i2c-proc'
> fails since the module is not found in the distributed kernel
> vmlinuz-2.6.6-1.435 again, mabe this is something that needs to be
> turned on (I dont have time to look right now) but 'sensor' seems to
> work fine without it.

In 2.6, sensors stuff is in /sys, not /proc, so this is no surprise that
you don't have /proc/sys/dev/sensors nor i2c-proc module. Our init
scripts would certainly need to be updated to support 2.6 kernels, but
nobody worked on this yet.

-- 
Jean Delvare
http://khali.linux-fr.org/
