From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 May 2008 14:19:03 +0000
Subject: Re: [lm-sensors] [PATCH] i2c-piix4: Blacklist two mainboards
Message-Id: <20080512161903.0ac214a9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080504183048.177fc0b4@hyperion.delvare>
In-Reply-To: <20080504183048.177fc0b4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 May 2008 15:32:26 +0200, Achim Gottinger wrote:
> Jean Delvare schrieb:
> > Achim, did you have a chance to give a try to this patch? I understand
> > that you don't want to apply it permanently while you're still having
> > fun with the I2C devices on the SMBus, but if you could still test it
> > and report whether it works as intended, that would be great. This
> > patch is in kernel 2.6.26-rc2 now, I would like to backport it to
> > 2.6.25.y, but before I do I'd like to have at least one positive test
> > result.
>
> Test positive:
> 
> piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
> piix4_smbus 0000:00:14.0: Accessing the SMBus on this system is unsafe!
> piix4_smbus: probe of 0000:00:14.0 failed with error -1

OK, thank you. I'll push the patch to 2.6.25.y now.

The error message might frighten people though, maybe we'll have to
change the error code so that no message shows in the future.

> But the i2c-piix4 module never made a problem it was only sensors-detect.

This is how you hit the problem, but there are many other ways people
could hit it, such as using i2cdump, i2cget or i2cset, or even just
loading a hardware monitoring driver which happens to probe I2C address
0x2e. While we fixed sensors-detect by now, not everyone will upgrade
to the new version of the script immediately, and all the other ways to
screw it up are still available. So, the only safe thing to do at the
moment is to disable the SMBus on your motherboard completely.

In the future, we could refine this and allow access again with
restrictions, such as no probing allowed from kernel drivers, and no
access from user-space (there's some more work needed before we can do
that.) Or we could limit the blacklisting to specific addresses (that's
easier to implement).

> About that overclocking module i'm working on. I moved all my kernel 
> stuff into a new dir called hwmod and made a modified hwmod.c from 
> hwmon.c.  Made all the required modifications
> on Kconfig and Makefile and stuff works fine. Devices use their own 
> class /sysfs/class/hwmod.
> I also added a new adapter class I2C_CLASS_HWMOD = (1<<7). To use the 
> i2c-piix4 module i had to add that class id to the i2c_adapter struct in 
> there.

I am worried that "hwmod" is too similar to "hwmon" and this will lead
to confusion. What about "overclock" or a similarly explicit term?

> I see no requirement to write separate modules for the smbus 
> controllers. I guess there is way to use I2C_CLASS_HWMON adapters for 
> devices ending up in /sysfs/class/hwmod, till  i figured out how i'll 
> simply patch i2c-piix4.

There is indeed no reason for separate modules for the SMBus
controllers, I'm not even sure how you came to think we could do that.
Adding a new class flag to i2c-piix4 was the right thing to do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
