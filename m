From: Volker Kuhlmann <list0570@paradise.net.nz>
Date: Sun, 25 Jan 2009 11:08:45 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090125110845.GA7159@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for your answer.

On Sun 25 Jan 2009 23:00:03 NZDT +1300, Jean Delvare wrote:

> > However when booting, the fancontrol part of the service
> > always fails. The reason is that when booting, hwmon entries are always
> > created in reverse order.
> 
> No, that's not the reason. The reason is that the k8temp driver is one
> of the few hwmon drivers which is loaded automatically at boot time
> (because the K8 thermal sensors are implemented as a PCI device).

Ok. Bottom line is still the load order is different, so the entries in
/sys/class/hwmon/ have a different order.

> Can't really say as you didn't tell what was version your previous
> kernel was and what version your new kernel is.

Current 2.6.27.7-9-default #1 SMP 2008-12-04, openSUSE 11.1.
Previous: pick pretty much any version of SUSE.
The immediately previous kernel was 2.6.22.5. It's config was also
MODULE_0=it87
MODULE_1=k8temp
but I never noticed the problem in a year of using it.

> More specifically, the problem is that "service lm_sensors start" (or
> whatever the command is for your specific distribution) at boot time is
> influenced by the driver auto-loading, while "service lm_sensors
> restart" isn't (because it removes all the drivers first.)

One could try in "start" to unload the modules first, which was one
option I considered. But one of the modules may not unload, and it may
also violate init script requirements.

> I'm not too sure how we can fix this problem. One possibility would be
> to not list in /etc/sysconfig/lm_sensors the drivers which were already
> loaded before sensors-detect is run. However this could be a problem if
> sensors-detect is ran again a second time, because all required hwmon
> drivers would be already loaded so none would be listed
> in /etc/sysconfig/lm_sensors.

I think it may be dangerous to not list prerequisites.

> This problem can be avoided by stopping
> the lm_sensors service before running sensors-detect. I think some
> distributions do that already.

I'm pretty sure I ran sensors-detect while the service was not yet
enabled - no point starting a service of which I knew it was
unconfigured, and which will not run without manual configuration (that
being /etc/sensors.conf).

It wouldn't really solve the problem anyway. If you stop the service at
the start of sensors-detect, you still have the same discrepency between
some modules being loaded at boot time, and service restart. It looks to
me like the only reliable way to control the order of module loading is
to unload them all first.

But sensors isn't really affected, only fancontrol. Maybe identifying
controllers by hwmon0, hwmon1 is inadequate, and fancontrol needs to be
more intelligent and to automatically find its controllers?

> http://www.lm-sensors.org/ticket/2368

Thanks.

Volker

-- 
Volker Kuhlmann			is list0570 with the domain in header
http://volker.dnsalias.net/	Please do not CC list postings to me.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
