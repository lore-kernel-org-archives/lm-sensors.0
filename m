From: "Engelmayer Christian" <Christian.Engelmayer@frequentis.com>
Date: Tue, 26 May 2009 10:06:36 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/1] hwmon: Updated documentation on
Message-Id: <9EE81EBECB70824985BE0EDA8DC9B515021B3542@VIECLEX01.frequentis.frq>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, May 26, 2009 11:16 AM
> To: Hans de Goede
> Cc: Engelmayer Christian; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] [PATCH v2 1/1] hwmon: Updated documentation on
alarms
> 
> On Tue, 26 May 2009 11:01:26 +0200, Hans de Goede wrote:
> > On 05/25/2009 10:15 PM, Engelmayer Christian wrote:
> > > From: Christian Engelmayer<christian.engelmayer@frequentis.com>
> > >
> > > Added fan limit alarm 'max_alarm' to the alarm section.
> > >
> >
> > Looks good to me now,
> >
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> I've applied the patch now. Please note that I did have to edit it
> manually so that it would apply. Christian, please fix/setup your
> e-mail client so that it doesn't wrap long lines.

Sorry for the inconvenience. I can see my mails being altered, although the
client settings would be correct. I will fix it asap.

> 
> One thing I am curious about is how we can have fan[1-*]_max_alarm
> while we do not have fan[1-*]_max according to our documentation. Some
> drivers still seem to implement this feature (dme1737, adt7470,
> applesmc) so we should document it, whoulsn't we?

Seems consequential.

> 
> But the max6650 driver, which is what Christian is working on, does not
> have this feature, it doesn't even have fan1_min as far as I can see.
> This makes me curious about what the fan1_max_alarm and fan1_min_alarm
> flags are supposed to mean for the MAX6650/1 device? Apparently not what
> Documentation/hwmon/sysfs-interface says... which would be kind of
> problematic.

I understood the interface that the min/max alarms shall be raised when eg.
a fan spins not fast enough/too fast, whereas the minimum/maximum limits are
taken from the _min/_max limit files.

The max6650 driver does not implement fan1_min/fan1_max because the chip does
not provide support for configurable limits. The chip raises the affected
alarms in case the desired speed cannot be attained in closed-loop mode. The
limits are a direct result of the minimum/maximum output values supported by
the DAC. eg. minimum alarm is raised in case the largest available voltage
has
been applied across the fan, which means that the fan is unable to spin as
fast as the desired speed.

That's my reasoning for choosing the mapping to
fan1_min_alarm/fan1_max_alarm,
although the limits are preset by the hardware and not configurable. Is that
a too generous interpretation of the interface to You?

> 
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
