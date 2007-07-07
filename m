From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 19:15:55 +0000
Subject: Re: [lm-sensors] add AMDSI PECI sensortype support to
Message-Id: <20070707211555.7a118b1a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707170959.63922c3e@hyperion.delvare>
In-Reply-To: <20070707170959.63922c3e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 07 Jul 2007 17:45:36 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Thu, 5 Jul 2007 13:23:04 +0200 (CEST), lm-sensors-notify@lm-sensors.org wrote:
> >>       Author: jwrdegoede
> >>         Date: Thu Jul  5 13:22:57 2007
> >> New Revision: 4552
> >>    Changeset: http://lm-sensors.org/changeset/4552
> >>
> >> Modified:
> >>    lm-sensors/branches/lm-sensors-3.0.0/prog/sensors/chips_generic.c
> >>
> >> Log:
> >> add AMDSI PECI sensortype support to generic_temp_print()
> > 
> > Good catch, but this does not yet cover all the values listed in
> > Documentation/hwmon/sysfs-interface:
> > 
> > temp[1-*]_type	Sensor type selection.
> > 		Integers 1 to 6 or thermistor Beta value (typically 3435)
> > 		RW
> > 		1: PII/Celeron Diode
> > 		2: 3904 transistor
> > 		3: thermal diode
> > 		4: thermistor (default/unknown Beta)
> > 		5: AMD AMDSI
> > 		6: Intel PECI
> > 		Not all types are supported by all chips
> > 
> > Notice the "or thermistor Beta value". The w83627hf and w83781d drivers
> > actually export 3435 and not just 4 for thermistors, so the new
> > "sensors", in its current state, won't work for them. We could make it
> > default to "thermistor" for unknown or arbitrarily large values. But
> > OTOH, this feature (exporting the beta value) doesn't seem terribly
> > useful. In the two drivers which export the beta value... this value is
> > hard-coded in the driver, and not used anywhere, so what's the point?
> > 
> > Thus I think that this is also the right time to get rid of this old
> > convention, and start using always value 4 for thermistors. The upgrade
> > plan would be:
> > 
> > * Update Documentation/hwmon/sysfs-interface to no longer mention
> > beta values, and change the w83781d and w83627hf drivers to export
> > a thermal sensor value of 4 instead of 3435 for thermistors. We may
> > want to still accept when 3435 is written to the tempN_type files for
> > backwards compatibility for now, and drop support for it only later.
> > Proposed patch attached.
> > * Update sensors (v3) to still expect a thermal type value of 3435, and
> > treat it as value 4. We want it to work OK with the drivers from
> > previous 2.6 kernels.
> > * Update sensors.conf.eg to mention this change.
> > 
> > The good news is that the old "sensors" already defaults to
> > "thermistor" for unknown values for w83781d and w83627hf, so it won't
> > be affected by the change. Hopefully, other applications using
> > libsensors either do the same, or use generic code to display the
> > thermal types, of don't report thermal types at all.
> > 
> > Objection anyone?
> 
> Your proposal sounds good, and the patches look good. I didn't see a patch for 
> sensors3 to recognise the old 3435 value though, whichbring us to the queston 
> what will be the minimum kernel version we want to support with 3.0.0.

The sensors3 patch should be pretty easy, maybe you could take care of
it? It's needed anyway, whether my kernel patch gets applied or not.

I'm still not sure which minimum version we want to support. I don't
want to support anything older than 2.6.5 for sure, things were just
too badly broken before that. And I don't want to clutter the
libsensors code too much to deal with the non-standard things that some
old kernels had. Unless someone has a better plan, I think we'll make
things work for the systems we developers are using, and release that,
and then if users complain that it doesn't work with some older kernel
they're using, we'll consider adding support on a case-by-case basis,
depending on how intrusive that would be.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
