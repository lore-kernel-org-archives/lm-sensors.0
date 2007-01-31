From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Date: Wed, 31 Jan 2007 10:18:04 +0000
Subject: [lm-sensors] fancontrol and ASUS quiet fan BIOS
Message-Id: <E1HCCXU-0001i6-FI@a4.complang.tuwien.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is somewhat of a reverse case of

http://www.lm-sensors.org/ticket/1917

I have an ASUS K8V SE Deluxe board (and use the w83697hf driver for
it).  I used to run a stock 2.6.13.2 kernel (with the perfctr patch)
and have now switched to a stock 2.6.19.2 (with the perfctr patch).  I
have also switched from Gentoo to Debian, but I doubt that is the
issue.  I used to have the Quiet Fan BIOS option enabled, but also
used the fancontrol script (fancontrol works much better, but not in
all OSs).

The way this setup apparently worked was that, as soon as I or
fancontrol wrote something to /sys/bus/i2c/devices/.../pwm2 (which
controls the CPU fan), the Quiet Fan BIOS stopped controlling the fan,
so they worked together beautifully.  Hmm, looking at ticket 1917, I
guess it was probably the loading of the module that disabled the
Quiet Fan feature.

After the upgrade to 2.6.19.2, this no longer works that way.  E.g., I
write to pwm2 and read it right back, like this:

echo 100 >pwm2; cat pwm2

That usually displays the number (100) I wrote, but a short time
later, pwm2 contains some other number, apparently what the Quiet Fan
BIOS deems appropriate.

I managed to work around this problem by disabling Quiet Fan in the
BIOS; then writing to pwm2 and fancontrol work as they have before.

That workaround is good enough for me, but I still wonder if there is
a way to get the old behaviour back (so i can have the Quiet Fan
feature for other OSs).  Any ideas?

Looking at ticket 1917, a solution might be to let the user control
how aggressive the initialization should be.  An automagic solution
would be to turn off Quiet Fan control when the first write to pwm2
happens, but I don't know if this is feasible.

- anton

