From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] updated it87 for kernel 2.6 - Part1
Message-Id: <20040216214304.03439d73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040216231514.61a84c5e.komoriya@paken.org>
In-Reply-To: <20040216231514.61a84c5e.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> "Smart guardian" is the automatic temperature control mode for the
> fan. sgpwm means pwm values for low, medium and high speed for fan,
> and sgtl means the temperature limits for fan off, low, medium, hi
> speed and over temperature.

OK, I think that I roughly see how it works. Later for the details.

> How about the sysfs names for Smart guardian like:
>  sgpwm_low[1-3] sgpwm_medium[1-3] sgpwm_high[1-3]
>  sgtemp_off[1-3] sgtemp_low[1-3] sgtemp_medium[1-3] sgtemp_high[1-3]
>  sgtemp_over[1-3]

Sounds correct to me.

> Please read the documentation of it87 for more details.
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/it87

Hehe, funny when a developer is told to go and read the docs ;) I took a
quick look and will read it more carefully when we will be working on
it.

> Here's the first patch for changing the sensor type selection method.
> The patch deletes temp_type option and make the sensor type be set at
> runtime instead.

(You will note that I will emit criticisms about your code while you
just do the exact same thing that was done in the 2.4 driver you used as
an example. This simply means that I want changed made to the 2.6 driver
to be better than the 2.4 driver is at the moment. I will then take care
that all improvements/changes we do to the 2.6 driver will be backported
to the 2.4 driver.)

Looks good overall, except two things (one detail, one critical).

You seem to consider that each temperature channel *must* have either
the PIIDIODE (0x01) or the THERMISTOR (0x08) bit set. If none is set,
you call it INVALID. According to the data sheets, I would say that the
only invalid value is when *both* bits are set at the same time. No bits
most probably means that the channel is not in use. For this reason, I
would rename the INVALID constant to UNUSED or DISABLED. I don't think
we need a numerical value for INVALID, since it is not going to happen
(if we do code cleanly, see below). (And, BTW, I think I would prefix
them with "SENSOR_" or something similar, but you are free to do or not
to do it).

Then, you forgot to define sysfs files for reading and writing the
temperature sensor types! Which makes your patch not acceptable as-is.
To follow the example of the other drivers, these files should be named
sensor[1-3]. Please note that according to my remark above, it is under
your responsability to ensure that you will never set both type bits to
1 for a given channel. The data sheets don't give details about what
would happen, but I wouldn't try. The prefered way to make sure it
doesn't happen is probably to make invalid writes fail (sysfs callback
function returns -1 instead of 0).

Please provide a patch fixing at least this second point, and the first
one if you share my views. If you don't, well, I'm listening to you.

Please make sure the driver compiles and works as intended after your
patch is applied. This is one of the reasons why it is great to cut
large patches into pieces, because it lets you test each change
individually.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
