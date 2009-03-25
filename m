From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Mar 2009 21:35:01 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <20090325223501.24dcaaaa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Mar 2009 18:33:04 +0300, sergio wrote:
> Jean Delvare wrote:
> 
> > That being said, the script approach has the advantage that
> > it is extremely easy for users to customize for their own needs. They
> > don't have to download the sources and rebuild a binary. For a fan
> > control script this seems to have value. Users might miss this
> > flexibility if we switch to C. One advantage though is that fancontrol
> > would finally honor temperature adjustments made in sensors.conf.
> Another advantage, that it's more simple to include it in embedded
> system. Current fancontrol doesn't work in busybox or dash.
> I don't believe, that shell is good for daemons.

Honestly, fan speed control under busybox doesn't strike me as the most
needed feature.

> > A third possibility which was discussed in the thread I mentioned above
> > is a helper binary, linked with libsensors, which would take care of
> > translating hwmonN names to libsensors chip names and back.
> IMHO this is worst way.

Why that?

> > A fifth possibility is to try harder to always load the hwmon drivers
> > in the same order. In this respect, lm-sensors 3.1.0 should behave much
> > better than previous versions did. Did you give it a try?
> I have two similar machines with identical sensors. One with debian
> lenny (3.0.2) other with sid (3.1.0). The sensors are: acpitz, k8temp
> and it8718. On both machines acpitz and k8temp loads automagically and
> it8718 from /etc/modules. If k8temp also present in /etc/modules it is
> don't matter in which order this modules are written in this file.
> acpitz always will hwmon0, k8temp -> hwmon1, and it8718 -> hwmon1 (if it
> present in modules)

I presume you mean it8718 -> hwmon2.

> What difference should i see?

On Debian, none. The improvement is only for distributions where
lm_sensors is a service which loads the required kernel modules when
started and removes them when stopped. Debian doesn't work that way, so
it shouldn't be affected by the problem in the first place.

> (Really, on machine with lenny it87 loads via force_load in
> initramfs-tools hook, so it87 is (always?) first.)

What is force_load? And why do you need it?

> So hwmon names jumping it's not very big problem for me.

Why are you reporting it then?

> It is never happens unexpectedly. Only when i change or upgrade something.

"change or upgrade something" is simply too vague for me to do anything
useful with the information.

> > Honestly, I am not sure if it makes much sense to rewrite fancontrol as
> > it exists today in C. fancontrol is very limited in what it can do and
> > the conditions it checks. There are other control daemons out there
> > which are much more flexible, as they can change behaviors not only
> > based on temperature, and they can change a lot more settings than just
> > fan speeds. So, instead of rewriting fancontrol, I'd rather work on
> > integrating sensors better in existing daemons.
> OK. Let's leave fancontrol as simple script. But i don't know any other
> fan control daemon. Can you give examples of such programs?

What I had in mind was cpufreqd:
http://freshmeat.net/projects/cpufreqd

As far as I remember it already supports temperature values as inputs,
and its configuration file was pretty flexible so adding fan speed
control shouldn't be that hard.

There may be other similar daemons that can be extended. Or feel free
to start your own, but then pretty please make its configuration file
much more flexible and clear than fancontrol's one. Shouldn't be too
hard ;) If you come up with something really good then I will be happy
to kill the pwmconfig and fancontrol scripts in favor of your work.

> May be should add possibility to define real path to device 
> (/sys/devices/platform/it87.552)?

This is a possibility, yes, and it shouldn't be too hard to implement.
Want to give it a try?

> Or this path isn't always identical?

Depends. For platform devices it should be totally stable. For I2C
devices the I2C adapter number may change. But it's a lot more stable
than hwmon# numbers either way.

> (And not all hwmons has a device)

This is correct. For hwmon without a device, obviously the hwmon# class
device is the only way if you don't take the libsensors route.

> And what about udev for name stabilizing?
>  > The usual solution (udev) doesn't work for us because hwmon devices
>  > have no device nodes in /dev, only a sysfs interface.
> Network interfaces is not present in /dev, but udev takes care about 
> they names.

Tell me about it. It's a nightmare, we keep getting bug reports about
it. Not to say that it can't be done properly for hwmon devices. But do
you have some concrete proposal? "Let's just use udev" doesn't tell me
much.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
