From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 29 Apr 2010 05:21:46 +0000
Subject: [lm-sensors] Simple fan question
Message-Id: <1272518506.24542.163.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi folks !

I'm writing some support for d-link dns323 rev C1 NAS. It has a fan that
is controlled by some non-programmable PWM circuit. Basically, all I can
do is tweak to GPIOs that controls the feed into the circuitry for the
fans to be off, slow or fast.

I don't know what the actual PWM values are for "slow" or "fast". I
-might- be able to do some measurements but I can't promise it.

Now I'm trying to do a simple hwmon driver for that in order to easy
userspace support for these guys, and I don't really see a 'nice' way to
expose that which would fit the interfaces documented
Documentation/hwmon/sysfs-interface.

So before I do something horrible, I felt I might poke you guys see if
you have a good idea here :-)

Before I read the above document I was thinking about a sysfs file that
contains "off", "slow" or "fast" but it looks like this won't fit at all
the typical hwmon APIs.

Another comment while at it is when implementing the thermal control for
PowerMacs a while back (windfarm etc...) I had to deal with two
different type of interfaces to fans. RPM controlled and PWM controlled.

The later basically let me program a percentile value (a percent of the
duty cycle).

I looks like the described sysfs interface only does RPM, or at least
doesn't provide a way to expose the units used...

Cheers,
Ben.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
