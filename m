From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 19:23:40 +0000
Subject: Re: [lm-sensors] add AMDSI PECI sensortype support to
Message-Id: <468FE83C.5010205@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707170959.63922c3e@hyperion.delvare>
In-Reply-To: <20070707170959.63922c3e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 07 Jul 2007 17:45:36 +0200, Hans de Goede wrote:
>> Your proposal sounds good, and the patches look good. I didn't see a patch for 
>> sensors3 to recognise the old 3435 value though, whichbring us to the queston 
>> what will be the minimum kernel version we want to support with 3.0.0.
> 
> The sensors3 patch should be pretty easy, maybe you could take care of
> it? It's needed anyway, whether my kernel patch gets applied or not.
> 

Ok, here is a proposal:

Index: prog/sensors/chips_generic.c
=================================--- prog/sensors/chips_generic.c        (revision 4566)
+++ prog/sensors/chips_generic.c        (working copy)
@@ -209,6 +209,11 @@
    /* print out temperature sensor info */
    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_SENS)) {
      int sens = (int)TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_SENS);
+
+    /* older kernels / drivers sometimes report a beta value for thermistors */
+    if (sens > 1000)
+      sens = 4;
+
      printf("sensor = %s", sens = 0 ? "disabled" :
                            sens = 1 ? "diode" :
                            sens = 2 ? "transistor" :

The idea here is that a beta value should (reasonably) always be > 1000, and we 
don't want to assume thermistor for any unknown value as we might add new types 
to the list later. Does this look ok?

> I'm still not sure which minimum version we want to support. I don't
> want to support anything older than 2.6.5 for sure, things were just
> too badly broken before that. And I don't want to clutter the
> libsensors code too much to deal with the non-standard things that some
> old kernels had. Unless someone has a better plan, I think we'll make
> things work for the systems we developers are using, and release that,
> and then if users complain that it doesn't work with some older kernel
> they're using, we'll consider adding support on a case-by-case basis,
> depending on how intrusive that would be.
> 

That sounds like a plan, but not like something one would put in a README, 
which then brings me to the question what do we put in the readme, just that it 
requires a kernel > 2.6.5, or maybe we should require one which has the hwmon 
class?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
