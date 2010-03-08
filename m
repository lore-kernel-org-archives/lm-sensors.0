From: Phillip Pi <ant@zimage.com>
Date: Mon, 08 Mar 2010 21:43:14 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100308214314.GA22889@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > > Nothing interesting in the DSDT; the hwmon chip is used only for
> > > > reading a temperature (TZ).
> > > > I think you can use "acpi_enforce_resources=lax", there not other ways
> > > > to access the sensor data.
> > > 
> > > If you do, please make sure to blacklist the ACPI "thermal" driver.
> >
> > Where do I set blacklist it?
> 
> Depends on the distribution. Sometimes it's enough to add:
> 
> blacklist thermal
> 
> to /etc/modprobe.d/*.conf, but sometimes init scripts actively load the
> thermal driver, so you have to hack them or at least edit
> distro-specific config files.

Thanks. I see existing files in mine:
$ ls /etc/modprobe.d/
aliases.conf              blacklist-bluetooth   libpisock9.conf
alsa-base-blacklist.conf  blacklist.conf        linux-sound-base_noOSS.conf
alsa-base.conf            fbdev-blacklist.conf  oss-compat.conf


> > What is bad about "thermal" driver? 
> > Conflict?
> 
> Yes. The thermal driver will access the same I/O ports as the w83627ehf
> driver, without any synchronization between them, so very bad things
> can happen.

In older Kernels like v2.6.30, did this conflict happen too? I only 
remember seeing inaccurate values like for voltages. Speaking of 
voltages, which part is responsibile for voltages showing that I don't 
have in 2.6.32, but did in 2.6.30?
-- 
Quote of the Week: "This isn't a war. It never was a war, any more than
there's war between man and ants." --artilleryman from H.G. Wells' The
War of the Worlds
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
