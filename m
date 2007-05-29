From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 May 2007 17:01:45 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070529190145.6405ce17@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 29 May 2007 10:19:03 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I see we have SENSORS_FEATURE_TEMP_OVER, SENSORS_FEATURE_TEMP_LOW and
> > SENSORS_FEATURE_TEMP_HIGH defined. What are these? We don't have names
> > for these in our standard sysfs interface, and they seem completely
> > redundant with SENSORS_FEATURE_TEMP_MAX and SENSORS_FEATURE_TEMP_MIN.
> > Did your students get confused by the non-standard names in the 2.4
> > driver somehow? It looks to me like we could plain delete these three
> > symbols.
> 
> I think my students may have gotten confused by the 2.4 names in lib/chips.c 
> just like I was, so if you're reasonable sure that these do not exist in 2.6 
> drivers, feel free to remove them.

Yes, I am reasonably sure. Fix committed.

> > I would first need to be explained what this "LIM" thing is. It
> > doesn't correspond to anything in our standard sysfs interface as far
> > as I can see, and no legacy chip code was using it. I would get rid of
> > it.
> 
> I think my students added then LIM print_temp_info() minmax type, to support 
> chips like the fscscy, see print_fscfsy() in prog/sensors/chips.c

I see. But I have no idea what this corresponds to. I do not have the
FSC Scylla datasheet.

OK, after digging into the old fscscy driver code, it seems that the
"min" and "max" temperature values returned by the driver aren't
limits, but the minimum and maximum measured temperatures over the
driver lifetime. Weird, no other driver does this. So "lim" would
presumably be the high temperature limit which all other drivers call
max or high or over.

This confirms my intuition that we don't need any "LIM" temperature
display type. Fix committed.

> Ok, well first we need a decision on the LIM feature + print support, then I 
> can do some cleanup based on what was discussed sofar, after which it would be 
> really nice if you could review print_generic_chip_temp()

I've committed the temperature cleanups already. I'll let you commit
the fixes you suggested for voltages now.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
