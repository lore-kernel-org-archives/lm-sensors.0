From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 16:56:41 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110315175641.6e369604@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 15 Mar 2011 09:23:25 -0700, Guenter Roeck wrote:
> On Tue, Mar 15, 2011 at 06:27:34AM -0400, Jean Delvare wrote:
> > The first difference is "hyst" being changed to "crit hyst" for
> > critical temperature limit hysteresis. The original code enforced every
> > temperature limit label to 4 characters to keep all lines nicely
> > aligned, and your change breaks this effort. As the hysteresis value
> > was always printed right after the limit it related to, on the same
> > line, the "crit" in front of "hyst" was redundant. With the new code,
> > there might be a new line in between, which isn't so nice. This should
> > be addressed in an incremental patch IMHO (I can take care.)
>
> ok. Problem though is that there are other sensor strings which don't fit 
> into four characters (crit low for temperatures, more for other sensor types).
> We would have to change those as well, and possibly specify a fixed length for
> limit strings associated with other sensor types.

You're right, I've seen this problem too. I'll see if I have ideas how
to solve it. This is independent from your patch though, so let's get
your patch applied first.

> > (...)
> > You want " (" here.
> 
> Ok. That means the output will be "ALARM (MIN, MAX)".

Correct, as we has before.

> > > (...)
> > > +static void get_sensor_limit_data(const sensors_chip_name *name,
> > > +                               const sensors_feature *feature,
> > > +                               const struct sensor_limits *ts,
> > > +                               struct sensor_limit_data *ts_data,
> > > +                               int *ts_sensors,
> > > +                               struct sensor_limit_data *ts_alarm_data,
> > > +                               int *ts_alarms)
> > 
> > The names of the last 4 parameters are really confusing... even worse
> > than for print_limits()! Please use the same naming convention for both
> > functions. And in the calling functions, too. And I'm not even sure
> > what "ts" stands for... "temperature sensor", as a legacy of a time
> > where this function was only used to print temperature limits?
>
> Probably because I started with temperatures. 
> 
> Changed to 
>                                   const struct sensor_subfeatures *sf,
>                                   struct sensor_subfeature_data *limits,
>                                   int *num_limits,
>                                   struct sensor_subfeature_data *alarms,
>                                   int *num_alarms)
> which I hope is a bit better.

Yes, much better.

> > (...)
> > There is something I don't like about this function: you assume that
> > the provided ts, ts_sensors and ts_alarms are such that all the
> > subfeatures from ts (including exists and nexists recursions) will fit
> > in ts_sensors and ts_alarms are. If this assumption fails, you'll
> > overrun the arrays and corrupt the stack, which is pretty bad. The
> > recursive relations between the various ts arrays make it easy to get
> > wrong, methinks.
> > 
> > Unfortunately I see no way to check the sizes for correctness at build
> > time, which means we'll have to do it at run time. This could be done
> > with the current prototype by having the caller pass the array sizes as
> > the initial values of ts_sensors and ts_alarms. The code would only
> > have to be adjusted a little. Or maybe you have a better idea?
> > 
> One other idea would be to dynamically allocate data as needed. Not sure if that 
> would be much better.

I thought about it, but I can't think of an efficient way to do it in
one pass. And doing it in 2 passes will certainly perform badly.

> For now, I added parameters for max_limits and max_alarms.

Yes, this should work fine.

> > > (...)
> > > +     strcpy(fmt, "%-4s = %+5.1f");
> > > +     strcat(fmt, degstr);
> > 
> > I strongly discourage the use of strcpy and strcat, especially on stack
> > buffers, for both safety and performance reasons. I would have
> > suggested the use of snprintf instead, but...
>
> Sure snprintf would be faster ?

Probably not in this case, no, because the strings your manipulate are
small enough. But with larger strings, repeated strcat are pretty slow.

The main issue if the risk of buffer overflow anyway.

> > > (...)
> > > +static const struct sensor_limits power_inst_highest[] = {
> > > +     { SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, NULL, 0, "max" },
> > > +     { -1, NULL, NULL, 0, NULL }
> > > +};
> > > +
> > > +static const struct sensor_limits power_inst_max[] = {
> > > +     { SENSORS_SUBFEATURE_POWER_MAX, NULL, NULL, 0, "max" },
> > > +     { SENSORS_SUBFEATURE_POWER_CRIT, NULL, NULL, 0, "crit" },
> > > +     { -1, NULL, NULL, 0, NULL }
> > > +};
> > > +
> > > +static const struct sensor_limits power_inst_sensors[] = {
> > > +     { SENSORS_SUBFEATURE_POWER_ALARM, NULL, power_alarms, 1, NULL },
> > > +     { SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, power_inst_highest,
> > > +         power_inst_max, 0, "min" },
> > 
> > This deserves a comment at least... if it is correct at all. Why would
> > INPUT_HIGHEST require INPUT_LOWEST? I can imagine a chip providing one
> > without the other (this would even make a lot of sense if you ask me).
> > I also don't get why MAX and CRIT would be mutually exclusive with
> > INPUT_LOWEST and INPUT_HIGHEST. Please explain or fix.
>
> Backwards compatibility issue. "max" and "min" were traditionally used
> to display "highest" and "lowest", and I did not want to change that.

But the origial code supported max (highest) without min (lowest) just
fine, which you code does not.

Quite frankly, I wouldn't bother about backwards compatibility here.
For one thing, power sensors are relatively recent, so users probably
don't expect things to be carved in stone yet. For another, using "min"
and "max" for "lowest" and "highest" was a bad choice in the first
place. We have traditionally used "min" and "max" for limits, while
what we have here are measurement extremes. Re-using "min" and "max"
can only confuse the user. So I would use "lowest" and "highest" to
clearly show the difference.

> However, that overlaps with "max" for the new SENSORS_SUBFEATURE_POWER_MAX.
> 
> I've changed the highest output to to "hmax" to lift the limitation.
> Not optimal, since there is still the average max which is also displayed
> as "max". Please let me know if you have a better idea.

Instant and average power sensors are supposed to be mutually
exclusive, and so are their limits, so I don't see any problem here.

> > (...)
> > Do you have any more patch pending for lm-sensors? I'd like to flush
> > the queue and then schedule the release of lm-sensors 3.3.0.
>
> Nothing major.
> 
> I have a driver for MAX16065 in the queue, but it looks like that won't be detectable.
> 
> I am also looking into support for DS1721, DS1631, and DS1731. DS1721 is supported
> by the ds1621 driver, though auto-detection does not work if the chip is in "standard"
> mode (the driver itself still works, though).

The ds1621 driver shouldn't do device detection in the first place, it
is hardly reliable as the devices lack an ID register.

> I am waiting for samples for the other chips.

I have a DS1631 somewhere in a drawer. I asked Maxim for the samples
long ago and never got to add support for these. Shame on me. If you
work on this, I'll be happy to help with review and testing.

> Once I get those, I'll test the driver and update it as/if needed. I don't have an ETA for
> that, though.

And all this is on the kernel side and not lm-sensors anyway. So let's
get your patch finished, add a few improvements on top of it, and
prepare for the release.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
