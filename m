From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Jan 2009 13:47:24 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090125144724.4ee47907@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Jan 2009 00:08:45 +1300, Volker Kuhlmann wrote:
> On Sun 25 Jan 2009 23:00:03 NZDT +1300, Jean Delvare wrote:
> > Can't really say as you didn't tell what was version your previous
> > kernel was and what version your new kernel is.
> 
> Current 2.6.27.7-9-default #1 SMP 2008-12-04, openSUSE 11.1.
> Previous: pick pretty much any version of SUSE.
> The immediately previous kernel was 2.6.22.5. It's config was also
> MODULE_0=it87
> MODULE_1=k8temp
> but I never noticed the problem in a year of using it.

Could be that the lm_sensors init script has been slightly adjusted
between openSUSE 10.3 and 11.1, I don't really remember.

> > More specifically, the problem is that "service lm_sensors start" (or
> > whatever the command is for your specific distribution) at boot time is
> > influenced by the driver auto-loading, while "service lm_sensors
> > restart" isn't (because it removes all the drivers first.)
> 
> One could try in "start" to unload the modules first, which was one
> option I considered. But one of the modules may not unload, and it may
> also violate init script requirements.

Interesting idea. That should indeed work in the general case, even
though there may be rare cases where unloading might not work (module
unloading might be disabled in the kernel, and a module may be in use.)

I don't see any init script requirement that we would violate. What
matters is that we get things to work with no drawbacks, the
implementation details are really up to us.

> > I'm not too sure how we can fix this problem. One possibility would be
> > to not list in /etc/sysconfig/lm_sensors the drivers which were already
> > loaded before sensors-detect is run. However this could be a problem if
> > sensors-detect is ran again a second time, because all required hwmon
> > drivers would be already loaded so none would be listed
> > in /etc/sysconfig/lm_sensors.
> 
> I think it may be dangerous to not list prerequisites.

I'm not sure what you name a prerequisite here? hwmon modules?

The fact that the lm_sensors service must load the hwmon modules is a
simple consequence of the fact that these drivers did historically not
auto-load. If we know that some modules auto-load, then there is no
need to list them.

> > This problem can be avoided by stopping
> > the lm_sensors service before running sensors-detect. I think some
> > distributions do that already.
> 
> I'm pretty sure I ran sensors-detect while the service was not yet
> enabled - no point starting a service of which I knew it was
> unconfigured, and which will not run without manual configuration (that
> being /etc/sensors.conf).
> 
> It wouldn't really solve the problem anyway. If you stop the service at
> the start of sensors-detect, you still have the same discrepency between
> some modules being loaded at boot time, and service restart. It looks to
> me like the only reliable way to control the order of module loading is
> to unload them all first.

I'm not sure why you think my approach wouldn't work. Let's take the
case of your board: the k8temp driver loads automatically, the it87
driver doesn't.

At first run, sensors-detect would stop the lm_sensors service (no
effect as the service wasn't configured yet.) It would detect k8temp and
it87, but seeing that k8temp is already loaded, would only list it87
in /etc/sysconfig/lm_sensors.

At this point, starting the lm_sensors service only loads it87, because
k8temp is already loaded. Likewise, stopping or restarting the
lm_sensors service only unloads the it87 driver.

This means that a further run of sensors-detect will only unload the
it87 driver. Then it will see that k8temp is loaded and again will not
list it in /etc/sysconfig/lm_sensors.

Basically the idea is to leave auto-loaded drivers alone and only care
about drivers which need to be loaded explicitly. For what it's worth,
this is exactly what sensors-detect already does (in SVN, that's a
recent change) for i2c bus drivers. So doing the same for hwmon drivers
themselves would be along the same line.

The only cases which I see won't work properly are:
* Upgrade from a system where k8temp or similar modules are already
  listed in /etc/sysconfig/lm_sensors. Could be handled at
  distribution level with a post-install script.
* Driver being autoloaded at some point while it was not beforehand.
  A relatively rare case, but not unseen.

Are you worried by these drawbacks, or are there other problems which I
did not see?

Your approach doesn't have these drawbacks, admittedly, but it has a
minor performance issue. I also see potential problems for drivers with
more than one function, as the forced module reloading might have side
effects.

> But sensors isn't really affected, only fancontrol. Maybe identifying
> controllers by hwmon0, hwmon1 is inadequate, and fancontrol needs to be
> more intelligent and to automatically find its controllers?

We clearly have a general issue at the kernel interface level due to
the lack of persistent device names. The usual solution (udev) doesn't
work for us because hwmon devices have no device nodes in /dev, only a
sysfs interface.

Going with the device paths (e.g. /sys/devices/platform/it87.656) works
well for platform devices, but it doesn't work that well for
SMBus-based chips, for the same reason hwmon class devices don't work:
i2c bus numbers aren't persistent. libsensors has a custom device
naming scheme which predates kernel 2.6 and udev, and solves all these
issues, unfortunately in user-space rather than at the kernel interface
level as udev does.

Getting fancontrol to do the same as sensors means either duplicating
the libsensors device naming logic there, or changing fancontrol to use
libsensors (meaning that you have to rewrite it in a different language
first, as a shell script can't use a C library.) Or maybe an
intermediate solution would be a binary helper converting hwmon class
names to libsensors names and back. After all, I already added an
option to "sensors" to list the i2c buses which have at least one hwmon
device on them. We could have more options to address the hwmon device
naming issue.

As a side note, fancontrol started as a quick hack to get the fan
control job done. But it is showing its limits every now and then. We
have maintained it so far, but clearly writing something more robust,
flexible and user-friendly would be very needed (if such a replacement
doesn't exist yet...)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
