From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Tue, 12 Dec 2006 23:13:33 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <200612130013.33643.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Dienstag, 12. Dezember 2006 09:52 schrieb Ulrich Ke?ler:
> What do I have to do now to load the new module? (modprobe -r w83627ehf
> and then modprobe w83627ehf does not work: no such device)
> I think I have ?recompiled only a module so I do not need to change the
> whole

the redy made "w83627ehf.ko" needs to be copied to 
to /lib/modules/<kernel-version>/kernel/drivers/hwmon/w83627ehf.ko   (of 
course replace <kernel version> by your kernel version)
you can say "depmod -a" afterwards to sort out module linkages but this might 
not even necessary (doesn?t hurt either).

Afterwards, "modprobe w83627ehf"  should work, start "tail 
-f /var/log/messages" in another window first to observe whats happening. 
use lsmod to confirm presence among modules.
confirm appearance of a bunch of devices in /sys (in my system 
its /sys/devices/platform/i2c-9191/9191-0290/ ): lots of fan*, in* and pwm* 
etc

BR
Christian

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de


