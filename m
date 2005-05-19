From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: lm_sensors
Message-Id: <WbnCzWdb.1115887029.3338190.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitry,

> > Which kernel version are you using?
>
> 2.6.11.5

Unfortunately, this kernel version does not have support for fan polarity
fix yet. You will have to upgrade to 2.6.12-rc2 or more (I would suggest
-rc4, obviously).

> it87 3-0290: detected broken BIOS defaults, disabling pwm interface

So this means that your BIOS did not program the PWM settings properly
(or at least we think it did not). You should first search for a BIOS
upgrade for your motherboard. If none is available, you should contact
Gigabyte and tell them about your problem.

Then, if all of the above failed, you may upgrade to 2.6.12-rc2 or later
and try:

modprobe it87 fix_pwm_polarity=1

Note that this is still experimental, so be very careful that your fans
don't stop.

You should now see the pwm control files in /sys, and if the workaround
works for you, you should be able to control the speed of your fans.

Hope that helps,
--
Jean Delvare
