From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Tue, 20 Oct 2009 01:43:46 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <4ADD15D2.8090001@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The file is dated Sept 20 2006. I suspect this may be the issue... there
> is nothing in there for VRM 10 or 11. It would appear that I need a
> later hwmon-vid driver? Or am I completely on the wrong track there LOL...

That's only your installed header file.  It would only affect userspace
programs doing the conversion themselves.  The latest code from the
kernel module is at:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/hwmon-vid.c;hb=HEAD

And all the VID revisions are defined in there.

> As you say, the info is definitely there to be read - according to
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024581.html
> the IT8718F does have VID info, but it is stored differently:
> 
> "The IT8718F and IT8720F also features VID inputs (up to 8 pins) but the
> value is stored in the Super-I/O configuration space. Due to technical
> limitations, this value can currently only be read once at
> initialization time, so the driver won't notice and report changes in
> the VID value. The two upper VID bits share their pins with voltage
> inputs (in5 and in6) so you can't have both on a given board."

Well it looks like the value isn't being read properly during chip
initialisation.  Perhaps a bug in the it87 hwmon driver?

The VID seems to get read in around line 1037:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/it87.c#l1035

Probably more research required to figure out why that value is zero on
our motherboards.

Cheers,
Adam.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
