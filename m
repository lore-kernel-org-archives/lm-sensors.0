From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Nov 2009 18:55:52 +0000
Subject: Re: [lm-sensors] ADT7473 and ADT7475
Message-Id: <20091116195552.622e6d9a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091107154621.55b98183@hyperion.delvare>
In-Reply-To: <20091107154621.55b98183@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Nov 2009 09:51:42 -0800, Darrick J. Wong wrote:
> On Fri, Nov 13, 2009 at 08:43:47PM +0100, Jean Delvare wrote:
> > No, CONFIG_SENSORS_ADT7473 will simply be dropped.
> > 
> > What could be done is have CONFIG_SENSORS_ADT7473 select
> > CONFIG_SENSORS_ADT7475 _during_ the transition phase, if you think this
> > can be useful. I am a little reluctant to have Kconfig dependencies
> > with no technical justifications, but in this case I can't think of any
> > problem that could cause, so why not.
> 
> "The adt747[35] drivers were refactored into one driver" seems like a good
> enough technical justification to me.
> 
> Then again since the drivers don't autoprobe and most everyone will have a

Actually, there will be some form of unintended auto-loading taking
place, exactly because of drivers being merged: loading the adt7473
driver on a system with a supported chip will instantiate an "adt7473"
driver. This in turn will trigger the loading of the adt7475 driver,
because this is where official adt7473 support is. In my tests, the
adt7473 driver is faster and the adt7475 driver gets loaded but isn't
used (for the ADT7473 at least). But I can imagine that in other cases
the adt7475 driver might pick the adt7473 first, so we are in the
unfortunate situation where we don't control exactly which driver picks
the device. This will stay that way until we finally delete the adt7473
driver. Hopefully both drivers will work the same so nobody will
notice ;)

This transition raises an interesting question about what should go in
initialization scripts to load i2c drivers. "modprobe $driver" is
vulnerable to consolidation as we're doing now. "modprobe i2c:$device"
would allow for smoother transitions, with the problem that 1* we would
need to teach sensors-detect about all device names and 2* a change in
the i2c alias format (which I can't exclude at this point) would break
all systems, so it's not bullet-proof either.

> 'modprobe adt7473' in some init script anyway, I suppose it won't really help.
> So, it's probably not worth the extra effort.

There's a log message that will be printed when using the deprecated
driver, and we will update sensors-detect to point to the adt7475
driver for ADT7473 support. I hope that will be good enough (and the
ADT7473 doesn't seem to be overly popular either.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
