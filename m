From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Mar 2007 11:13:04 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <20070302121304.9db20131.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>
	<20070226172716.b2e956b7.khali@linux-fr.org>
	<1172655111.11100.50.camel@localhost.localdomain>
	<20070228143433.GB30168@khazad-dum.debian.net>
	<1172797936.14827.33.camel@localhost.localdomain>
In-Reply-To: <1172797936.14827.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, lenb@kernel.org, konstantin.a.karasyov@intel.com

Hi Zhang,

> On Thu, 2007-03-01 at 08:06 +0100, Jean Delvare wrote: 
> > Indeed, ACPI thermal zone may have more thermal trip points than the
> > hwmon interface specifies. Two of the trip points can be mapped to
> > temp1_max and temp1_crit, respectively. If we want to handle them all,
> > then probably we have to implement Henrique's suggestion and really
> > think in terms of thermal zones, i.e. the trip points would be mapped
> > to temp1_auto_point[1-*]_temp and possibly associated with a fan speed
> > output.
> 
> Well, ACPI thermal zones are not only a logical collection of interfaces
> to temperature sensors, trip points and thermal property information,
> but also take charge of thermal controls, i.e. setting platform's
> cooling mode policies.
> I don't know if I missed something, but from Documentation/hwmon/sysfs-
> interface, I can't find any interface that make it possible.

As I don't know what these "cooling mode policies" are, I can't really
tell. Trip points in hwmon let the user define the desired fan speed
depending on a temperature measurement, and that's about it. You can't
associate other actions at the moment, essentially because hardware
monitoring chips themselves can't do anything else. If it would be
convenient for the ACPI case to add something else, we can discuss
additional interface files.

> And, porting ACPI fan and thermal zones to the hwmon model? That is
> really complicated.
> Add Len and Konstantin to cc list and see if they have any ideas. :)

My original idea was to simply add a read-only hwmon-like interface to
the acpi fan and thermal modules. I didn't plan to replace the current
interfaces offered by these modules, at least not directly. There must
be many user-space tools and scripts relying on these at the moment, so
we need a transition period anyway.

-- 
Jean Delvare

