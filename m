From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Thu, 08 Mar 2007 13:13:23 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <20070308131323.GA417@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net> <20070226172716.b2e956b7.khali@linux-fr.org> <1172655111.11100.50.camel@localhost.localdomain> <20070228143433.GB30168@khazad-dum.debian.net> <1172797936.14827.33.camel@localhost.localdomain> <20070302121304.9db20131.khali@linux-fr.org> <1173346084.10227.136.camel@localhost.localdomain>
In-Reply-To: <1173346084.10227.136.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lm-sensors@lm-sensors.org, lenb@kernel.org, trenn@suse.de

On Thu, 08 Mar 2007, Zhang Rui wrote:
> First, ACPI thermal zone can be used to set different cooling policies,
> i.e. passive cooling mode and active cooling mode.
> In passive mode, just as Matthew Garrett described, ACPI thermal may
> throttle the CPU if the passive trip point is triggered, i.e. cool a
> thermal zone by decreasing the performance of the devices(always CPU
> now) in the zone.
> The active cooling mode will use one or more active devices(usually fan)
> to decrease the temperature, which consume extra power. And this is
> really like the way that the hwmon is doing.
> So we can only map the active cooling policy to hwmon, right?

Right, which is not to say we can't extend hwmon to also cover passive.

> Second, one ACPI thermal zone may have more than one fan devices, even
> one active trip point may associate with several fan devices. And this
> seems to be different from the sensors, doesn't it?

No, a LM85 does that too.  I don't recall if the current interface allows
for that mapping easily, but if it doesn't, it needs to be modified.

> Third, ACPI can not get/set the fan speed. It can only deal with the fan
> D-state. Fan is on in D0 state and off in D3 state.

That is easy to map to hwmon, you just don't implement some of the pwm
stuff.

> IMO, the hwmon sysfs interface make it very convenient for users to
> define the desired fan speed depending on a temperature measurement.
> And it seems that we can't take use of this if we map ACPI thermal and
> fan to hwmon-like sysfs interface, right?

Well, it is certainly not easy.  I am not really sure the answer is "we
cannot", though, but I don't really have the inclination to break out the
paper and pencil and start thinking *hard* on it right now, sorry :(

> Oh, a _read-only_ interface? Then, it will be much easier.
> But what is it used for?

Monitoring.  It is actually used more than the read-write interface...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

