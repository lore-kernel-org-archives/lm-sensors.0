From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 30 Sep 2007 12:55:42 +0000
Subject: Re: [lm-sensors] foo_fault attributes: why?
Message-Id: <20070930145542.3fa31f4a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070930011719.GB3164@khazad-dum.debian.net>
In-Reply-To: <20070930011719.GB3164@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Sat, 29 Sep 2007 22:17:19 -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 29 Sep 2007, Henrique de Moraes Holschuh wrote:
> > I will look for the fooN_fault file docs, and implement that post haste,
> > then.
> 
> Patch nearly done.  Should I keep returning an error (might as well be
> ENXIO) if someone tries to read foo (when foo_fault is indicating a
> problem), or should I return a stupid bogus value?

Other drivers return the value they got from the hardware (even though
we know it doesn't make any sense.) When a fault attribute is
available, applications are supposed to check its value first, and if
it's not 1, they read the sensor value. Hmmm, not sure if even
"sensors" is implementing this properly, I'll take a look.

> I liked the ENXIO a lot more.  Why should I force userspace to do *twice*
> the ammount of sysfs attribute readings, just to know if the values it is
> getting are valid?  If a sensor is faulty, is there a point on returning its
> value at all?  When you return an error, userspace does NOT get an invalid
> reading it could use because of a bug.  It follows the principle of least
> suprise, the KISS principle, and it keeps the information of faults in-band.

The reason is historical. We had alarms files reporting various status
bits reported by the hardware. Most of these are alarms (measures value
outside of defined boundaries), but some chips also reported broken or
missing hardware. When we decided to split the single "alarms" file
into individual fooN_alarm files, we naturally created individual fault
files as well. Most frequently this is available for missing or broken
remote thermal diodes (tempN_fault), and sometimes also for missing or
stuck fans (fanN_fault).

> If the sensor driver knows how to implement foo_fault, it could well
> implement an ENXIO return on the faulty sensor, instead.   What was the
> design reason to use foo_fault instead of an error return in the attributes
> of the sensor that is faulty?

This isn't so much a design decision than a non-decision: we are simply
transmitting the information reported by the hardware. It seems that
nobody gave much thought to this problem yet, simple as that.

> I can understand implementing *both*, though.  Makes it easier to just
> monitor sensors for faults in an application, which *could* be faster in
> some chips.

Another value of these separate files is that they tell that the
hardware _can_ report failure for a given sensor. If the fault file
doesn't exist, it means that the hardware cannot report failures when
then happen.

> But for drivers like thinkpad-acpi, if I have to export foo_fault, until I
> add some not-so-simple TTL-aware caching, it will cause *twice* the number
> of slow ACPI EC accesses, and libsensors will do *twice* the number of sysfs
> open+read+close...  I don't like it.  I will do it if you tell me I must,
> but I'd rather have the interface extended to allow for some error return to
> replace foo_fault, or to require both (the error return, and the foo_fault
> attribute).

Not that many drivers have fault files at the moment, and usually only
for a few attributes, so performance has never been an issue. On top of
that, almost all hardware monitoring chips read all the registers at
once and cache the result for a second, so reading two files instead of
one doesn't really make a difference.

I agree that there is probably some room for improvement here, and that
returning -ENXIO when a sensor is not available makes sense. That
doesn't mean that we're going to convert all the other drivers right
now (I really don't have the time for this and we have more urgent
things to do), but we could update libsensors so that it gracefully
transmits the information to applications. Care to send a patch?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
