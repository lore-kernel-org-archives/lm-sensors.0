From: sergio <mailbox@sergio.spb.ru>
Date: Wed, 25 Mar 2009 15:33:04 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <49CA4EB0.8000006@sergio.spb.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> That being said, the script approach has the advantage that
> it is extremely easy for users to customize for their own needs. They
> don't have to download the sources and rebuild a binary. For a fan
> control script this seems to have value. Users might miss this
> flexibility if we switch to C. One advantage though is that fancontrol
> would finally honor temperature adjustments made in sensors.conf.
Another advantage, that it's more simple to include it in embedded
system. Current fancontrol doesn't work in busybox or dash.
I don't believe, that shell is good for daemons.

> A third possibility which was discussed in the thread I mentioned above
> is a helper binary, linked with libsensors, which would take care of
> translating hwmonN names to libsensors chip names and back.
IMHO this is worst way.

> A fifth possibility is to try harder to always load the hwmon drivers
> in the same order. In this respect, lm-sensors 3.1.0 should behave much
> better than previous versions did. Did you give it a try?
I have two similar machines with identical sensors. One with debian
lenny (3.0.2) other with sid (3.1.0). The sensors are: acpitz, k8temp
and it8718. On both machines acpitz and k8temp loads automagically and
it8718 from /etc/modules. If k8temp also present in /etc/modules it is
don't matter in which order this modules are written in this file.
acpitz always will hwmon0, k8temp -> hwmon1, and it8718 -> hwmon1 (if it
present in modules)
What difference should i see?

(Really, on machine with lenny it87 loads via force_load in
initramfs-tools hook, so it87 is (always?) first.)

So hwmon names jumping it's not very big problem for me.
It is never happens unexpectedly. Only when i change or upgrade something.

> Honestly, I am not sure if it makes much sense to rewrite fancontrol as
> it exists today in C. fancontrol is very limited in what it can do and
> the conditions it checks. There are other control daemons out there
> which are much more flexible, as they can change behaviors not only
> based on temperature, and they can change a lot more settings than just
> fan speeds. So, instead of rewriting fancontrol, I'd rather work on
> integrating sensors better in existing daemons.
OK. Let's leave fancontrol as simple script. But i don't know any other
fan control daemon. Can you give examples of such programs?

May be should add possibility to define real path to device 
(/sys/devices/platform/it87.552)?
Or this path isn't always identical?
(And not all hwmons has a device)

And what about udev for name stabilizing?
 > The usual solution (udev) doesn't work for us because hwmon devices
 > have no device nodes in /dev, only a sysfs interface.
Network interfaces is not present in /dev, but udev takes care about 
they names.

-- 
sergio

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
