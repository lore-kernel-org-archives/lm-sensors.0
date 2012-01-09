From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jan 2012 16:23:32 +0000
Subject: Re: [lm-sensors] [PATCH v2] Add support for new attributes to
Message-Id: <20120109172332.3244dd10@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111106224622.GA28914@ericsson.com>
In-Reply-To: <20111106224622.GA28914@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Jan 2012 16:14:27 -0800, Guenter Roeck wrote:
> Hi Jean,
> 
> On Sun, Jan 08, 2012 at 04:45:02PM -0500, Jean Delvare wrote:
> > Hi Guenter,
> > 
> [ ... ]
> > >  
> > >  static const struct sensor_subfeature_list power_inst_sensors[] = {
> > > +	{ SENSORS_SUBFEATURE_POWER_AVERAGE, NULL, 0, "avg" },
> > 
> > I'm confused. This one was missing on purpose. For power sensors we
> > consider instantaneous and averaging sensors as different types. The
> > code in function print_chip_power is pretty clear about this. So, just
> > as all _INPUT subfeatures aren't listed in limit arrays,
> > SENSORS_SUBFEATURE_POWER_AVERAGE must not be listed.
> > 
> I looked this up again.
> 
> The idea was to support display of both instantaneous power and average power
> if both is provided by the chip/driver.
> 
> With the above, this is displayed as follows: 
> 
> power: 55mW (avg: 50mW, highest: 70mW)
> 
> In other words, average power is displayed as limit, similar to lowest/highest values,
> if instantaneous power is supported as well. If not, it is still displayed as before.
> 
> power: 50mW (highest: 70mW)
> 
> Do you have a better idea how to handle this case ?

Oh, this is pretty nice. Now this all makes sense, thanks for the
clarification.

However it looks like a specific hack for a specific problem, rather
than a generic solution. We have two sets of highest/lowest power
attributes, one for instant measurements and one for averaged
measurements. While your change makes it possible to display both the
instant and averaged value, it can only display one set of
highest/lowest limit. I supposed that a monitoring device could expose
both, even if yours does not.

So with this change you can't claim that you display all power
attributes. Rather, you special-cased SENSORS_SUBFEATURE_POWER_AVERAGE
to be either an input value or a limit value. This is certainly
acceptable as long as it is properly documented. But this makes me
wonder if it wouldn't be better to assume that all attributes may be
present, and input may be missing in which case we use average as the
measurement.

Well that was a long speech for a short conclusion: as far as I can
see, all we have to do is duplicate power_avg_sensors[] at the end of
power_inst_sensors[] and adjust the labels to avoid ambiguous
duplicates. As far as I can see you don't even need to touch the code
itself, except for stripping out the comment which claims that power
sensor flavors are assumed to be mutually exclusive.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
