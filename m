From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: scaling of loadavg in sensord
Message-Id: <cdJX8MNs.1098959969.9798510.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <417CB2E3.3090007@aurel32.net>
In-Reply-To: <417CB2E3.3090007@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Aurelien, hi Mario,

> > I think it does. The fact that the update interval is 5 minutes is
> > hardly relevant. The point is that sensord reports instant measurements
> > for everything (voltages, temperatures, etc...) and the 1 minute average
> > load is the nearest value from instant load.
>
> I agree with that, however, the others measurements (and particularly
> temperatures) are changing slowly so that interpolation done bye RRD can
> work. This is not the case of the load.

Not true. CPU core temperatures change very quickly and integrated
thermal diodes report that very accurately. The CPU temperature reported
for my Pentium III CPU can chage as quickly as +10 degree C in a second
when I start some heavy job on the system. In turn, systems with
automatic fan speed control may see fast fan speed changes (although
probably not as fast as the temperature itself due to the mechanical
nature of fans).

So I cannot see much difference between load1 and hardware monitored
values in terms of latency. If there is any, them load1 may be _more_ of
an average value than the measured values.

> > I don't think this belongs to sensord. Sensord is not a system
> > monitoring daemon but a hardware monitoring daemon. The only reason why
> > load "average" is included is that several monitored values (CPU temp
> > first) may depend on the instant system load. Logging load5 or load15
> > doesn't make much sense IMHO.
>
> Ok, here is an example. Imagine that your system has a high load during
> the first four minutes of a five minutes interval, and a low load the
> during last minute. In that case the CPU temperature would still be
> high, but the load would be low if load1 is logged. So logging load1 in
> that case wouldn't make much sense. In that case logging load5 is a
> better idea IMHO.

The CPU temperature may not be that high. It really depends on how the
temperature is measured (internal diode or socket thermistor) and the
cooling solution efficiency. Some systems will need way less than one
minute to come back to their "original" temperature.

I agree that the thermal curve will depend on the system, and I guess
this is the reason why you want the user to be able to choose which
average load he/she wants to compare the temperature with.

I believe that people needing more accurate temperature vs. load curves
are better lowering the sampling rate to one every minute than averaging
the cpu load over a longer period of time. Comparing an instant
temperature with an average load doesn't make much sense unless you
assume that the instant temperature is actually a form of average
temperature too. However, in the best case (actually the worst case,
where heat dissipation is bad) the measured temperature will represent
the lowest point to which the CPU temperature was able to drop since its
last effort. This is not an average value. You may think of it that way
because it is between the busy temperature and the long run idle
temperature, but this doesn't make it an average value at all.

> BTW, the patch doesn't break the interface as the argument is optional.
> --load-average without arguments goes back to the previous behavior.

Yes, I noticed that and this is great if we'd end up applying the patch.
I still need to be convinced that we want to do that though.

As a side note, I may lack some knowledge about the way sensord and rrd
work together. Sensord samples all sensors every 5 minutes and sends raw
values to rrd, which is responsible for storing them and interpolating
where values are missing, right? Does rrd do any averaging in the
regular case? I think there was a discussion about this some months ago
but I cannot seem to remember where they did led us.

Thanks.

--
Jean Delvare
