From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Mar 2007 08:53:06 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <20070309095306.8cd3846e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
	<1172655111.11100.50.camel@localhost.localdomain>
	<20070228143433.GB30168@khazad-dum.debian.net>
	<1172797936.14827.33.camel@localhost.localdomain>
	<20070302121304.9db20131.khali@linux-fr.org>
	<1173346084.10227.136.camel@localhost.localdomain>
	<20070308131323.GA417@khazad-dum.debian.net>
In-Reply-To: <20070308131323.GA417@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Thu, 8 Mar 2007 10:13:23 -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 08 Mar 2007, Zhang Rui wrote:
> > First, ACPI thermal zone can be used to set different cooling policies,
> > i.e. passive cooling mode and active cooling mode.
> > In passive mode, just as Matthew Garrett described, ACPI thermal may
> > throttle the CPU if the passive trip point is triggered, i.e. cool a
> > thermal zone by decreasing the performance of the devices(always CPU
> > now) in the zone.
> > The active cooling mode will use one or more active devices(usually fan)
> > to decrease the temperature, which consume extra power. And this is
> > really like the way that the hwmon is doing.
> > So we can only map the active cooling policy to hwmon, right?
> 
> Right, which is not to say we can't extend hwmon to also cover passive.

Correct. The hwmon interface had no reason to mention passive cooling
as hardware monitoring chips have no control over CPU speed. So far
this kind of passive cooling was implemented in user-space, using the
temperature as one of the decision factor for CPU frequency in cpufreqd
or similar. Of course, if the ACPI virtual hardware monitoring device
can control the speed, it might be convenient to extend the interface
to let the user do it. But I have no idea what it would look like.

> > Second, one ACPI thermal zone may have more than one fan devices, even
> > one active trip point may associate with several fan devices. And this
> > seems to be different from the sensors, doesn't it?
> 
> No, a LM85 does that too.  I don't recall if the current interface allows
> for that mapping easily, but if it doesn't, it needs to be modified.

It does, see item pwm[1-*]_auto_channels_temp in
Documentation/hwmon/sysfs-interface. Whether it qualifies as "easily"
is another problem ;)

-- 
Jean Delvare

