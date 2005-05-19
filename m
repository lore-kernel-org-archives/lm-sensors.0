From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <zw98qMP6.1107511777.0206960.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> I think there should NOT be many bugs in 792 driver for 2.4 after the
> review of MDS and me, and wish to commit it into CVS as soon as possible.
> But my manager suggested that I commit it only after a full test, so that
> we can avoid some na?ve bugs, I agree with him now, but this will lead to
> the delay in committing the 792 driver.

It is always possible to commit a first version and apply patches
afterwards as problems are found and fixed. We don't plan to release a
new version of lm_sensors before a couple of months, so it can be
committed now, get some testing by the few CVS users we have, get fixed
where needed and be ready for the next release. That would sound like a
sane timeline.

I think we have a few users which have W83792D chips and are waiting for
a driver to test. I can't remember if these were running 2.4 or 2.6
kernels though. At any rate, committing early will increase the chances
that your code gets additional testing, which is definitely good.

What MDS is probably waiting for before adding your driver to lm_sensors
CVS is a patch to libsensors and sensors that would add support for the
w83792d chip type. End-users need this to really take benefit of your
driver. Reading the raw values from /proc isn't exactly convenient. As
a side effect, doing this should help you understand how voltage scaling
works and hopefully convince you that libsensors can handle voltage
conversions just right so your driver don't need to do that by itself ;)

> And we have one question:
> we want to add some other sys-interfaces about Winbond Smart FanI and
> FanII, for example, in the 792 driver of linux-2.4, I added such
> interfaces:
> fan_cfg,
> pwm_flag,
> pwm[1-3],
> thermal_cruise,
> fan_tolerance,
> sf2_levels_fan[1-3],
> sf2_points_fan[1-3]
> [Note: Please refer to the mail and attached pictures sent by me on
> 2005-01-24]
> If I also want to add these interfaces into 792 driver for linux-2.6,
> How should I stick to the standard Documentation/i2c/sysfs-interface?
> Because it seems that it has no description about SmartFan.

See the "PWM" section of the document. It has standard file names and
values for both manual and hardware-controlled fan speed control.
Basically, pwmN_enable selects control mode (off, manual, automatic),
pwmN controls duty cycle in manual mode (and optionally displays current
duty cycle in automatic mode), the other files control the various trip
points in automatic mode. It might or might not fit the W83792D model. I
hope it does, because we had a hard time designing this interface so
that it would be suitable for all chips. If you need more than that,
just add the files you need. If it happens that more chip drivers need
the same, we'll attempt to standardize afterwards.

The basic rule is that you shouldn't use a different name or different
value conventions for things that are already standardized - for the
rest you are relatively free, as long as your choices are consistent.

Thanks,
--
Jean Delvare
