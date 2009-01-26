From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 Jan 2009 14:57:10 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090126155710.1ec77270@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

On Mon, 26 Jan 2009 22:47:36 +1300, Volker Kuhlmann wrote:
> On Mon 26 Jan 2009 02:47:24 NZDT +1300, Jean Delvare wrote:
> > Could be that the lm_sensors init script has been slightly adjusted
> > between openSUSE 10.3 and 11.1, I don't really remember.
> 
> This is the diff:
> 
> -# If sensors isn't supported by the kernel, try loading the module...
> -[ -e /sys/bus/i2c/devices ] || /sbin/modprobe i2c-dev &>/dev/null
> -
> -# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
> -# support for sensors.
> -[ -e /sys/bus/i2c/devices ] || exit 0
> -
> -# If sensors was not already running, unload the module...
> -[ -e /var/lock/subsys/sensors ] || /sbin/modprobe -r i2c-dev &>/dev/null
> 
> The problem started with /sys/class, but /sys/bus worked?

I don't think these changes have anything to do with your problem.
lm_sensors has never needed i2c-dev so the above was dead code to start
with.

> > I'm not sure why you think my approach wouldn't work. Let's take the
> > case of your board: the k8temp driver loads automatically, the it87
> > driver doesn't.
> > 
> > At first run, sensors-detect would stop the lm_sensors service (no
> > effect as the service wasn't configured yet.) It would detect k8temp and
> > it87, but seeing that k8temp is already loaded, would only list it87
> > in /etc/sysconfig/lm_sensors.
> > 
> > At this point, starting the lm_sensors service only loads it87, because
> > k8temp is already loaded. Likewise, stopping or restarting the
> > lm_sensors service only unloads the it87 driver.
> > 
> > This means that a further run of sensors-detect will only unload the
> > it87 driver. Then it will see that k8temp is loaded and again will not
> > list it in /etc/sysconfig/lm_sensors.
> 
> Ah yes, put it like that, it should work. It would be very sensitive to
> run-status being the same as boot-status though. Is this robust enough?

I agree it is a little fragile. It should work in the general case if
the user doesn't edit the configuration file manually and doesn't load
or unload hwmon drivers on its own. My hope is that users who start
loading or unloading drivers or editing configuration files will know
how to fix things if they break. But maybe that's too optimistic.

> > The only cases which I see won't work properly are:
> > * Upgrade from a system where k8temp or similar modules are already
> >   listed in /etc/sysconfig/lm_sensors. Could be handled at
> >   distribution level with a post-install script.
> 
> I wouldn't put money on all distributors with a new release of lm_sensors
> picking up on the new requirement to deal with post-install scripts...

I am doing my best to let packagers know when they should pay attention
to that kind of things. So far it went well.

> > (...)
> > Your approach doesn't have these drawbacks, admittedly, but it has a
> > minor performance issue.
> 
> # /usr/bin/time rclm_sensors restart
> Shutting down sensors, stopping fan control:                                             done
> Starting up sensors, starting fan control:                                               done
> 0.06user 0.08system 0:00.53elapsed 27%CPU (0avgtext+0avgdata 0maxresident)k
> 456inputs+0outputs (3major+6562minor)pagefaults 0swaps
> 
> With unloading all modules first:
> 
> # /usr/bin/time /tmp/root/lm_sensors restart
> Shutting down sensors, stopping fan control:                                             done
> Starting up sensors, starting fan control:                                               done
> 0.07user 0.12system 0:00.55elapsed 35%CPU (0avgtext+0avgdata 0maxresident)k
> 24inputs+32outputs (0major+8664minor)pagefaults 0swaps
> 
> 20 milliseconds longer, AMD64 3200+ CPU, system ca 3y old, not top-top
> then.
> 
> I don't think I'd worry about it.

You tested on a system with only modules doing direct I/O access (it87
and k8temp). On a system with sensors on SMBus or I2C this is a totally
different story. For example, I just tested on my home server which
needs the lm85 and ds1621 drivers, unloading and reloading these takes
~360 ms. On top of that there can be hidden costs, many hwmon drivers
cache register values, when you cycle the drivers you lose the cache.

At the moment these drivers do not auto-load so the issue is
theoretical. But if they ever do, unloading and reloading them when we
don't have to will be a significant waste of time.

> > (...)
> > Going with the device paths (e.g. /sys/devices/platform/it87.656) works
> > well for platform devices, but it doesn't work that well for
> > SMBus-based chips, for the same reason hwmon class devices don't work:
> > i2c bus numbers aren't persistent. libsensors has a custom device
> > naming scheme which predates kernel 2.6 and udev, and solves all these
> > issues, unfortunately in user-space rather than at the kernel interface
> > level as udev does.
> > 
> > Getting fancontrol to do the same as sensors means either duplicating
> > the libsensors device naming logic there, or changing fancontrol to use
> > libsensors (meaning that you have to rewrite it in a different language
> > first, as a shell script can't use a C library.)
> 
> A wrapper for the library, which outputs device names to /sys/class/...
> pairs one per line in a format easily parsable by a shell script?

Either that, or with a command line interface so that you can ask
directly for what you want. This will save some parsing in user-space, and also avoids computing things that the caller will just discard.l

> > Or maybe an
> > intermediate solution would be a binary helper converting hwmon class
> > names to libsensors names and back.
> 
> Only the sensors names to filesystem names would really be needed.

I think both ways are needed. pwmconfig would need to convert hwmon# to
a libsensors name and use that name in /etc/fancontrol, and fancontrol
would need to convert the libsensors name to hwmon# to access the right
sysfs files.

> > As a side note, fancontrol started as a quick hack to get the fan
> > control job done. But it is showing its limits every now and then.
> 
> :)
> 
> I had to mess with it because for my mobo it was plain not working at
> all (useful PWM values 4..12, not 30..255).

Recent versions of pwmconfig handle this just fine, what was your
problem exactly?

Note that in many cases, small control ranges can be improved by
tweaking the PWM base frequency. Some of our drivers support that
already, in particular the it87 driver supports that since kernel
version 2.6.21.

> What I'd really like to write is a panel applet which does all of this:
> 
> * Monitor all hardware, this includes sensors as well as hard disks
> (smartmontools!).

I'd rather see a kernel driver exporting HDD temperature in the
standard hwmon format.

> * Control hardware as needed, e.g. fans, perhaps CPU performance.
> Applets for the CPU already exist.
> 
> * Warn if hardware goes pear-shaped, e.g. fans below min speed, disks
> failing or getting too hot, ..., by producing suitable popups,
> repeatedly as configured or clicked away by the user.
> 
> * With each warning, give information to users who don't have any
> hardware understanding, saying how serious the problem is nd what can be
> done about it.
> 
> * With mobo sensors I don't see the day where vendors will give decent
> info in a generic usable form. It's not happening with hard disks
> either, some smart info is plain shocking, also smart standards seem to
> be vague in places. The only workaround to that I can see is to have a
> component database, and have the application pull updates automatically
> say once a week.

Everybody is asking for this, but nobody seems to have the time to
actually make it happen.

> * There would need to be some GUI app to configure the lot first. Could
> be integrated with the applet of course. Similar in style to the superb
> kinternet from SUSE.
> 
> I like this in particular because neither Billyware nor Macsware have
> anything similar, and Linux could claim a user-friendly first.

Well, Windows has a number of third-party applications which do
basically what you described (SpeedFan for example.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
