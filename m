From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Feb 2007 15:56:09 +0000
Subject: [lm-sensors] fancontrol and ASUS quiet fan BIOS
Message-Id: <20070204165609.31070afe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anton,

On Wed, 31 Jan 2007 11:18:04 +0100 (CET), Anton Ertl wrote:
> This is somewhat of a reverse case of
> 
> http://www.lm-sensors.org/ticket/1917
> 
> I have an ASUS K8V SE Deluxe board (and use the w83697hf driver for

This driver doesn't exist, I'll assume you mean the w83627hf driver and
your chip is a W83697HF.

> it).  I used to run a stock 2.6.13.2 kernel (with the perfctr patch)
> and have now switched to a stock 2.6.19.2 (with the perfctr patch).  I
> have also switched from Gentoo to Debian, but I doubt that is the
> issue.  I used to have the Quiet Fan BIOS option enabled, but also
> used the fancontrol script (fancontrol works much better, but not in
> all OSs).
> 
> The way this setup apparently worked was that, as soon as I or
> fancontrol wrote something to /sys/bus/i2c/devices/.../pwm2 (which
> controls the CPU fan), the Quiet Fan BIOS stopped controlling the fan,
> so they worked together beautifully.  Hmm, looking at ticket 1917, I
> guess it was probably the loading of the module that disabled the
> Quiet Fan feature.
> 
> After the upgrade to 2.6.19.2, this no longer works that way.  E.g., I
> write to pwm2 and read it right back, like this:
> 
> echo 100 >pwm2; cat pwm2
> 
> That usually displays the number (100) I wrote, but a short time
> later, pwm2 contains some other number, apparently what the Quiet Fan
> BIOS deems appropriate.
> 
> I managed to work around this problem by disabling Quiet Fan in the
> BIOS; then writing to pwm2 and fancontrol work as they have before.
> 
> That workaround is good enough for me, but I still wonder if there is
> a way to get the old behaviour back (so i can have the Quiet Fan
> feature for other OSs).  Any ideas?

The old behavior isn't something we want to do again. Loading a driver
should not reconfigure the hardware monitoring chip, doing so confuses
the users a lot, especially when we offer no way to revert the change.
We fixed the driver for that reason.

> Looking at ticket 1917, a solution might be to let the user control
> how aggressive the initialization should be.  An automagic solution
> would be to turn off Quiet Fan control when the first write to pwm2
> happens, but I don't know if this is feasible.

You should be able to set the fan speed control to manual mode by
writing 1 to pwm2_enable. Then values written to pwm2 should stick, as
they used to.

-- 
Jean Delvare

