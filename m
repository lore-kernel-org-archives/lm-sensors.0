From: rui.zhang@intel.com (Zhang Rui)
Date: Thu, 08 Mar 2007 09:28:04 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <1173346084.10227.136.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	 <20070226172716.b2e956b7.khali@linux-fr.org>
	 <1172655111.11100.50.camel@localhost.localdomain>
	 <20070228143433.GB30168@khazad-dum.debian.net>
	 <1172797936.14827.33.camel@localhost.localdomain>
	 <20070302121304.9db20131.khali@linux-fr.org>
In-Reply-To: <20070302121304.9db20131.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lm-sensors@lm-sensors.org, lenb@kernel.org, trenn@suse.de

On Fri, 2007-03-02 at 12:13 +0100, Jean Delvare wrote:
> Hi Zhang,
> 
> > On Thu, 2007-03-01 at 08:06 +0100, Jean Delvare wrote: 
> > > Indeed, ACPI thermal zone may have more thermal trip points than the
> > > hwmon interface specifies. Two of the trip points can be mapped to
> > > temp1_max and temp1_crit, respectively. If we want to handle them all,
> > > then probably we have to implement Henrique's suggestion and really
> > > think in terms of thermal zones, i.e. the trip points would be mapped
> > > to temp1_auto_point[1-*]_temp and possibly associated with a fan speed
> > > output.
> > 
> > Well, ACPI thermal zones are not only a logical collection of interfaces
> > to temperature sensors, trip points and thermal property information,
> > but also take charge of thermal controls, i.e. setting platform's
> > cooling mode policies.
> > I don't know if I missed something, but from Documentation/hwmon/sysfs-
> > interface, I can't find any interface that make it possible.
> 
> As I don't know what these "cooling mode policies" are, I can't really
> tell. Trip points in hwmon let the user define the desired fan speed
> depending on a temperature measurement, and that's about it. You can't
> associate other actions at the moment, essentially because hardware
> monitoring chips themselves can't do anything else. If it would be
> convenient for the ACPI case to add something else, we can discuss
> additional interface files.
> 
OK.
I still have some problems.

First, ACPI thermal zone can be used to set different cooling policies,
i.e. passive cooling mode and active cooling mode.
In passive mode, just as Matthew Garrett described, ACPI thermal may
throttle the CPU if the passive trip point is triggered, i.e. cool a
thermal zone by decreasing the performance of the devices(always CPU
now) in the zone.
The active cooling mode will use one or more active devices(usually fan)
to decrease the temperature, which consume extra power. And this is
really like the way that the hwmon is doing.
So we can only map the active cooling policy to hwmon, right?

Second, one ACPI thermal zone may have more than one fan devices, even
one active trip point may associate with several fan devices. And this
seems to be different from the sensors, doesn't it?

Third, ACPI can not get/set the fan speed. It can only deal with the fan
D-state. Fan is on in D0 state and off in D3 state.
IMO, the hwmon sysfs interface make it very convenient for users to
define the desired fan speed depending on a temperature measurement.
And it seems that we can't take use of this if we map ACPI thermal and
fan to hwmon-like sysfs interface, right?

This is my understanding of the hwmon. And if there is something wrong,
please help me point it out. :)

> My original idea was to simply add a read-only hwmon-like interface to
> the acpi fan and thermal modules. I didn't plan to replace the current
> interfaces offered by these modules, at least not directly. There must
> be many user-space tools and scripts relying on these at the moment, so
> we need a transition period anyway.
> 
Agree.
I've already finished the patch to duplicate ACPI procfs function in
sysfs, i.e. export the similar information while in sysfs style. And I
think this can make it not so painful for use-space tools and scripts to
convert to sysfs interface.
Oh, a _read-only_ interface? Then, it will be much easier.
But what is it used for?

Thanks,
Rui

