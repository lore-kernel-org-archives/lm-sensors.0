From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: sensors vs 2.6, sensors 0 kernel 1
Message-Id: <20040103223748.3bfbb5f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040103105038.632ee305.khali@linux-fr.org>
In-Reply-To: <20040103105038.632ee305.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >What are you using for the geforce2 card? Rivatv? Is that something
> >present in the kernel or some additional patch?
> 
> rivefb, in the kernel.

As far as I can see this doesn't make any use or the i2c subsystem.

> With the last reboot, /sys/bus/i2c doesn't exist.

I think you have to load the i2c-sensor module for this.

> I also have lost the ability to insmod/modprobe anything after the 
> reboot.

Didn't you forget to enable the module support? Not sure that the
configuration system would have let you compile drivers as modules else
though.

Or maybe you have some other problem with the module tools, but I can't
really help.

> I did modify that one line 337 in rc.sysinit because there doesn't 
> seem to be a /proc/ksims directory anymore.  And of course since I 
> can't insmod anything a cat of /proc/modules is a linefeed only, on 
> the cli.

That might mean that your distribution isn't fully ready for a 2.6
kernel. Maybe you should try to find some documentation on how to update
your specific distribution so that it works OK with a 2.6 kernel.

> I've done the modprobe-conversion thing, so I have an 
> /etc/modprobe.conf, possibly out of date because I haven't used 
> modules in over a year.

You should be mostly able to use lm_sensors with no modprobe.conf at
all.

> After putting in the module-init-tools-3.0-pre4, I have this in 
> /usr/local/sbin:
> -----------------
> -rwxr-xr-x 1 root root  95675 Jan 3 03:49 depmod
> lrwxr-xr-x 1 root root     12 Jan 3 03:48 depmod.old -> /sbin/depmod
> -rwxr-xr-x 1 root root  30179 Jan 3 03:49 insmod
> lrwxr-xr-x 1 root root     12 Jan 3 03:48 insmod.old -> /sbin/insmod
> -rwxr-xr-x 1 root root 478763 Jan 3 03:49 insmod.static
> -rwxr-xr-x 1 root root  78876 Jan 3 03:49 modprobe
> lrwxr-xr-x 1 root root   14 Jan 3 03:48 modprobe.old -> /sbin/modprobe
> -rwxr-xr-x 1 root root  33986 Jan 3 03:49 rmmod
> lrwxr-xr-x 1 root root    11 Jan  3 03:48 rmmod.old -> /sbin/rmmod
> ------------

I'm still using 0.9.14 and it works well. Maybe the newer versions have
some problems (it's labeled "pre"...)

> The w83781d module worked fine, under say 2.4.23-pre3...  When built 
> into the kernel too.

This driver has had some changes since it was ported to 2.5/2.6, and not
all of them have been ported.

> I suspect the real problem is the module-init-tools install, but I 
> can't see the trees for all that forest right now.

Sounds possible - although it wouldn't explain why your w83781d chip
wasn't detected in the first place.

Please try to get module support to work correctly before we go on,
since it will help a lot understanding what happens.

> So, no sound, or sensors.  OTOH, tvtime shows its usual great picture!
> Odd.  Puzzling even.  I need some sleep, this up all night crap ain't 
> what it was 60 years ago.

Good night ;) and good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
