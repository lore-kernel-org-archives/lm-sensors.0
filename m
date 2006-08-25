From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 25 Aug 2006 18:23:07 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <20060825202307.8b8ce101.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Please check that the value of /sys/class/hwmon/hwmon0/device/vrm is
> > 8.2 as expected.
> 
> It gives 24.

Sorry, I don't know why I wrote "8.2", while I actually meant "24". So
it's OK :)

> > converting the values properly. This could be caused by a device
> > misconfiguration, or maybe by the IT8716F chip itself being
> > underpowered?
> 
> I don't think the chip is responsible for it, if I do it on purpose, or do you 
> think it also causes some deviation?

Depends on what you do exactly. If it is only supposed to affect the
CPU, the IT8716F chip shouldn't suffer from it.

> > The driver should print some messages in the log when you load it, can
> > you please copy them here?
> 
> it87: Found IT8716F chip at 0x290, revision 0
> it87: in3 is VCC (+5V)
> it87: in7 is VCCH (+5V)
> it87: fan4 is enabled
> it87: fan5 is enabled
> 
> Not too interesting, it seems, or is it?

It is, as it means VCC and VCCH are scaled internally. This means we
can't suspect different scaling resistors to explain the different
values between the BIOS and sensors.

> > One way to test this is as follows:
> > Reboot your system, and make sure that the it87 driver will not be
> > loaded at boot time.
> > Dump the contents of the chip:
> >   isadump -y 0x295 0x296 > /tmp/before.dump
> > Load the it87 driver, run sensors once.
> > Dump the contents of the chip again:
> >   isadump -y 0x295 0x296 > /tmp/after.dump
> > Send both files here.
> 
> Do you still want me to get the dumps, if you know now that I underpower on 
> purpose?

Well, the question is, do the voltage values reported by "sensors"
increase again if you stop underpowering your system? If they do,
obviously that's your business and I couldn't care less ;)

I generated a new version of my it87 patch, which should report fan
speeds properly:
  http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v3-2.6.18.patch
It also changes the low voltage limits to get rid of all the ALARMs.

-- 
Jean Delvare

