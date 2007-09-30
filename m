From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Sun, 30 Sep 2007 01:17:19 +0000
Subject: [lm-sensors] foo_fault attributes: why?
Message-Id: <20070930011719.GB3164@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 29 Sep 2007, Henrique de Moraes Holschuh wrote:
> I will look for the fooN_fault file docs, and implement that post haste,
> then.

Patch nearly done.  Should I keep returning an error (might as well be
ENXIO) if someone tries to read foo (when foo_fault is indicating a
problem), or should I return a stupid bogus value?

I liked the ENXIO a lot more.  Why should I force userspace to do *twice*
the ammount of sysfs attribute readings, just to know if the values it is
getting are valid?  If a sensor is faulty, is there a point on returning its
value at all?  When you return an error, userspace does NOT get an invalid
reading it could use because of a bug.  It follows the principle of least
suprise, the KISS principle, and it keeps the information of faults in-band.

If the sensor driver knows how to implement foo_fault, it could well
implement an ENXIO return on the faulty sensor, instead.   What was the
design reason to use foo_fault instead of an error return in the attributes
of the sensor that is faulty?

I can understand implementing *both*, though.  Makes it easier to just
monitor sensors for faults in an application, which *could* be faster in
some chips.

But for drivers like thinkpad-acpi, if I have to export foo_fault, until I
add some not-so-simple TTL-aware caching, it will cause *twice* the number
of slow ACPI EC accesses, and libsensors will do *twice* the number of sysfs
open+read+close...  I don't like it.  I will do it if you tell me I must,
but I'd rather have the interface extended to allow for some error return to
replace foo_fault, or to require both (the error return, and the foo_fault
attribute).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
