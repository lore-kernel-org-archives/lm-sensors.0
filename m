From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: lm_sensors2/doc/chips mic74
Message-Id: <pKkaw34y.1107351761.4505810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <gqUFWjmh.1107340522.3506030.khali@localhost>
In-Reply-To: <gqUFWjmh.1107340522.3506030.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark & all,

> > I don't see the point in having a kernel driver for this. The driver
> > currently exposes all the registers directly to procfs, with arbitrary
> > names. You could achieve the same goal with a user-space program relying
> > on i2c-dev. I guess that this device is meant for a very specific use
> > anyway.
>
> well you have a point there, but that comment also applies to pcf8574, for
> example.

I completely agree, and some other drivers as well. I believe that the
different devices have been handled too similarly for a long time now.
The i2c core is one thing, i2c/smbus master drivers are another, sensor
chips another, misc chips yet another, and user-space tools as well. One
may wonder why bus drivers do belong to the lm_sensors package and not
to i2c package. Likewise, some chip drivers are part of lm_sensors for
historical reasons but don't truly belong there. The fact that
libsensors and sensors know about a number of non-sensors chips doesn't
make much sense when you think of it. And the fact that the 2.4 kernel
drivers, libsensors and sensors are so tight together is much of a
concern too.

The reason why I mention all that now is that we will inevitably have to
make things way clearer on the 2.6 kernel side within a short time.
Hardware monitoring chips must be conceptually separated from the i2c
subsystem, because so many of them are now completely unrelated with
that. i2c-isa will soon be history, or so I hope. Also, the 2.6-only
implementation of libsensors (someday...) will only handle sensor chips,
based on the well-defined standard interface, no more chip-specific
stuff. While we are still far from this, it would be great to walk in
the right direction already.

> I think this driver has potential for enhancement...
> for example, if it's really used as a fan controller, the files could be
> renamed as pwmx and then it would work with pwmconfig, etc.
> So IMHO it was worth keeping.

Agreed, the chip can be used as a fan controller and that would belong to
the project in this case. But who is using this chip and driver exactly?
I still would like to know where the chip was seen.

At any rate, I would prefer a driver that specifically handles fan
control and only that, with standard interface, and a user-space tool
which handles the chip as an I/O expander, and only does that. I doubt
that the chip would be used for both at once, would it?

Side note about the chip detection (or lack thereof):

You said that the chip was impossible to detect. I don't think so.
During the past few years, we learnt quite a few tricks for detecting
chips, which would certainly apply here.

First, I see unused bits in the configuration register and fan speed
register. Should probably always read 0.

Then, as for most low register count chips, we could check what happens
when you read past the last register. Sometimes it returns 0, sometimes
the last read value, sometimes an i2c error. Sometimes registers cycle
over some boundary (like the LM75 does). All this can be used to improve
the detection - even if real identification registers are still prefered
for speed and reliability, of course. May we see a dump of a mic74 chip?

Thanks,
--
Jean Delvare
