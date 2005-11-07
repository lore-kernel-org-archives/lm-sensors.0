From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Nov 2005 13:14:50 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800
Message-Id: <FQMVorb9.1131364926.0914080.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051106224429.533f13b7@heffalump.sk2.org>
In-Reply-To: <20051106224429.533f13b7@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stephen,

On 2005-11-06, Stephen Kitt wrote:
> I've been using fancontrol for a while to control my CPU fan. I'm using
> an Asus P4P800 Deluxe board with a W83627THF controller which has PWM2
> wired to control the CPU fan (there are two other headers on the board,
> but they only report the fan speed, their PWM isn't connected).
>
> I switched to 2.6.14 yesterday and noticed today that the CPU fan was
> stuck at the speed the BIOS cruise control left it at before the
> w83627hf module was loaded.

I'm a bit surprised by this statement. Cruise control (or Q-fan, as Asus
calls it) supposedly means that the chip dynamically changes the CPU fan
speed depending to the CPU temperature. So the CPU fan shouldn't be
"stuck" as you wrote. It should increase with CPU load. Isn't it the
case?

> Changing the PWM value via /sys/bus/i2c/devices/.../pwm2 had no
> effect. Loading the module with reset=1 fixed things, and I noticed
> in my logs the request to report its usefulness. I compared the code
> from 2.6.13 to 2.6.14 and saw the change (and the comment!).

Thanks a lot for reporting, so that we can go on improving the driver.

> So here's a reason why it's needed ;-)
>
> I hope this is useful; if you need more info (...)

Yes, I'd like you to do some tests.

First, here is what I think is happening. Your BIOS sets the W83627THF
chip in "thermal cruise" mode, where the fan speed is adjusted
depending on CPU temperature. The driver used to reset to the default
settings, thus voiding the BIOS configuration. In the default mode, the
fan speed can be manually controlled using /sys/.../pwm2. However, in
"thermal cruise" mode, you can't, as the speed is automatically
regulated. As the new driver leaves the chip in the mode the BIOS set it
in (unless you use reset=1), manual control is disabled.

I agree that the current situation is inconsistent. When the chip is
found in automatic fan control mode, we should either not present the
pwm files, or provide a way to revert to manual control mode.

But actually there is a patch floating around which adds full support for
the automatic modes of the W83627THF to the w83627hf driver. It wasn't
merged yet because it doesn't follow the standard interface, and would
need to be reviewed. But merging it would solve the issue.

Eric, you were supposed to resend the latest version of the patch on the
sensors-list, but I can't actually find it in the archives. Can you
please send it now, either as a text/plain or text/x-patch attachement,
or inline if you are certain your mailer will not wrap it badly? We need
to start from the latest version of the patch.

One thing I know for sure is that we will have to get rid of all the
"qfan" names. "Q-fan" is a name from Asus. It might even be (R) or
(TM) by them. The driver is for a Winbond chip, so we better use Winbond
names, or generic names.

Stephen, do you have some kernel programming knowledge? We need someone
to put the patch in conformance with the standard sysfs interface before
we can integrate it. If not, can you at least test patches against
recent kernels?

Stephen, can you please do the following tests:

1* In the BIOS setup screen, disable Q-fan, then boot Linux 2.6.14. You
should not need the reset=1 parameter, pwm2 should work out of the box,
because the BIOS will have left the chip in default configuration.

2* In the BIOS setup screen, enable Q-fan, and set the "fan speed
ratio" to, say, 13/16. Then boot Linux and report the output of
"isadump 0x295 0x296". Try again with a different value, say 11/16,
and report the output of the same dump. I want to know what register it
affects. I'd guess 0x09, but a confirmation would be welcome.

Thanks,
--
Jean Delvare
