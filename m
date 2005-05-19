From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <3Nx28QVV.1099575297.0585960.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> This mystery device on 0x2b is part of the problem.  As a workaround,
> you could load the asb100 module with the option "ignore=1,0x2b".

True, this is how we got it to work (over IRC) yesterday evening
(European time). I did not investigate why though, but it seems you did.

As a side note, we still don't know where the mysterious chips at 0x2b
and 0x2f come from. They are not supposed to be there on A7V8X boards as
far as I can remember. The chip at the latter address seems to be a
W83791D chip, unfortunately not supported under Linux 2.6 (why, BTW?)

> The real problem is in i2c_detect():
>
> (lines 153-159 of i2c-sensor-detect.c)
>
> >         /* OK, so we really should examine this address. First check
> >            whether there is some client here at all! */
> >         if (is_isa ||
> >             (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK,
> >                              NULL) >= 0))
> >                 if ((err = found_proc(adapter, addr, -1)))
> >                         return err;
>
> I.e. after the chip driver correctly decides that the device responding
> to 0x2b is NOT an asb100, it never gets the chance to examine 0x2d.

This would explain the behavior observed on Benjamin's board, correct.

> I'm not sure that replacing "return err;" with "continue;" is good enough.
> Also note that if it loops through the whole range but finds nothing, it
> returns 0 instead of e.g. -ENODEV.  The whole function seems to want a
> re-write... would it break otherwise working configs if I cleaned this
> thing up?

I don't think your analysis is correct. My feeling is that *_detect
functions found in the client drivers should NOT return non-zero values
on "misdetections". A misdetection is not an error per se, and
obviously the i2c_detect function was written with that in mind. So I
believe that the asb100 driver, not i2c_detect, would need to be fixed.

There are several other drivers that would need a similar fix, such as
w83781d and possibly it87. Other drivers I looked at seem to be OK
(lm75, lm83, lm90, w83627hf). I guess that a full review of all client
drivers would be welcome.

My investigations led me to ask several related questions:

1* What is the different between "normal" i2c addresses and "probe"
i2c addresses? It seems that both arrays are treated the same way, and
no client driver is using "probe" addresses (at a quick glance at
least.) Can't we just get rid of it?

2* What is the difference between i2c_probe in i2c-core and i2c_detect in
i2c-sensor (i2c-proc in 2.4)? Both functions seem to be very similar, I
couldn't find a difference (but I admittedly did not compare line by
line yet). If there are, it's probably not worth the code duplication.
As a matter of fact, I don't see how exactly i2c_detect is supposed to
be sensor-related. Can't we get rid of i2c_detect and use i2c_probe
everywhere?

It would be great if we could clean this mess now because I will do
significant changes to that part of the code soon (to get rid of the
thinkpad breakage issue, just like I did in the userspace tools already).

I admit that I find it a little strange that two things so obviously
redundant could have been in place for so long and nobody ever objected.
Am I missing something?

3* Did we ever see an ASB100 chip at any other address than 0x2d? We
don't have any documentation for that chip so it would probably be more
reasonable to limit the range to the only known address so far. As a
side effect, I suspect that it could help solve that ticket:
http://bugzilla.kernel.org/show_bug.cgi?id(99

Thanks,
Jean
