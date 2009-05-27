From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 May 2009 15:29:50 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/1] hwmon: Updated documentation on
Message-Id: <20090527172950.36fc3072@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Tue, 26 May 2009 12:06:36 +0200, Engelmayer Christian wrote:
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > (...)
> > One thing I am curious about is how we can have fan[1-*]_max_alarm
> > while we do not have fan[1-*]_max according to our documentation. Some
> > drivers still seem to implement this feature (dme1737, adt7470,
> > applesmc) so we should document it, whoulsn't we?
> 
> Seems consequential.

I've updated your patch.

For completeness, amongst the 3 drivers I listed above, only adt7470
implements fan[1-*]_max the way it is supposed to. For dme1737, the
value is used to calibrate the speed monitoring logic. For applesmc,
I'm not sure (I don't have any datasheet) but the fact that the
attribute is read-only suggests that it exposes the physical/nominal
maximum speed of the fan, rather than a user-selected speed limit.

This can probably be explained by the fact that the maximum fan speed
limits aren't terribly useful. Your system is at risk if a fan stalls,
but not if it spins very fast (it can be very noisy then, but that's
another issue.) The only indirect indication about a hardware problem,
is when the system is thermo-regulated, a fast-spinning fan suggests a
very high temperature. But this condition is much better detected with
a thermal sensor, of course.

As a matter of fact, libsensors doesn't even support fan[1-*]_max
attributes (if someone wants to implement that... go ahead.)

> > But the max6650 driver, which is what Christian is working on, does not
> > have this feature, it doesn't even have fan1_min as far as I can see.
> > This makes me curious about what the fan1_max_alarm and fan1_min_alarm
> > flags are supposed to mean for the MAX6650/1 device? Apparently not what
> > Documentation/hwmon/sysfs-interface says... which would be kind of
> > problematic.
> 
> I understood the interface that the min/max alarms shall be raised when eg.
> a fan spins not fast enough/too fast, whereas the minimum/maximum limits are
> taken from the _min/_max limit files.

This is correct.

> The max6650 driver does not implement fan1_min/fan1_max because the chip does
> not provide support for configurable limits. The chip raises the affected
> alarms in case the desired speed cannot be attained in closed-loop mode. The
> limits are a direct result of the minimum/maximum output values supported by
> the DAC. eg. minimum alarm is raised in case the largest available voltage
> has
> been applied across the fan, which means that the fan is unable to spin as
> fast as the desired speed.

This is a somewhat different condition. We do not have a dedicated sysfs
interface for this yet. Only a few supported devices/drivers implement
the fan speed target mode.

> That's my reasoning for choosing the mapping to
> fan1_min_alarm/fan1_max_alarm,
> although the limits are preset by the hardware and not configurable. Is that
> a too generous interpretation of the interface to You?

I'm not sure. On the one hand, these conditions aren't that different
from user-defined speed limits, and adding specific code to libsensors
and monitoring applications might be considered overkill. Both are
about the fan speed being above or below some limits. But on the other
hand, my reluctance comes from the fact that some chips actually
implement both limit types, with separate alarm flags for each (even
though I don't think any driver currently exposes those), and I'm not
sure how to make that fit in the current interface.

Opinions are welcome. In the meantime, I have no objection to you using
the current attribute names for the max6650 driver.

Don't you think it would make sense to expose the fan1_min and fan1_max
values which determine when the alarm flags will be raised? I presume
they can be computed from the target speed value.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
