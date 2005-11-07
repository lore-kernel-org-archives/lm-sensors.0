From: lists@sk2.org (Stephen Kitt)
Date: Mon, 07 Nov 2005 22:12:09 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800
Message-Id: <20051107221125.0b09b06e@heffalump.sk2.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051106224429.533f13b7@heffalump.sk2.org>
In-Reply-To: <20051106224429.533f13b7@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Nov 2005 13:02:06 +0100 (CET), "Jean Delvare" <khali@linux-fr.org>
wrote:
> On 2005-11-06, Stephen Kitt wrote:
> > I switched to 2.6.14 yesterday and noticed today that the CPU fan was
> > stuck at the speed the BIOS cruise control left it at before the
> > w83627hf module was loaded.
> 
> I'm a bit surprised by this statement. Cruise control (or Q-fan, as Asus
> calls it) supposedly means that the chip dynamically changes the CPU fan
> speed depending to the CPU temperature. So the CPU fan shouldn't be
> "stuck" as you wrote. It should increase with CPU load. Isn't it the
> case?

Well, the fan slows down during the BIOS POST, but it never budges once Linux
has loaded - that's how I noticed the change. By "stuck" I meant that writing
to the pwm2 control file didn't change the fan speed. The fan's speed didn't
change with the CPU temperature either, but that might not mean much. I'm
running a 2.6GHz P4C with a Zalman CNPS7000-AlCu cooler, so the CPU stays
reasonably cool even under load. The fan's maximum speed is 2600rpm; with
Q-Fan at 11/16 it runs at 2100rpm. I tried loading the CPU as much as
possible this evening after a reboot, but I couldn't get it much beyond 50?C -
so if the BIOS's settings are anything like those the W83627THF's spec sheet
mentions (a target temperature of 55?C +/- 3?C), the fan speed wouldn't be
expected to change. I'd assume Q-Fan is behaving the way it's supposed to
given the Winbond documentation - I'd got used to fancontrol which behaves
rather differently on my system!

> Yes, I'd like you to do some tests.
> 
> First, here is what I think is happening. Your BIOS sets the W83627THF
> chip in "thermal cruise" mode, where the fan speed is adjusted
> depending on CPU temperature. The driver used to reset to the default
> settings, thus voiding the BIOS configuration. In the default mode, the
> fan speed can be manually controlled using /sys/.../pwm2. However, in
> "thermal cruise" mode, you can't, as the speed is automatically
> regulated. As the new driver leaves the chip in the mode the BIOS set it
> in (unless you use reset=1), manual control is disabled.

Indeed, this seems to be the case - as I mentioned above, my testing doesn't
prove or disprove anything with regards to the expected Q-Fan behaviour.

[...]

> One thing I know for sure is that we will have to get rid of all the
> "qfan" names. "Q-fan" is a name from Asus. It might even be (R) or
> (TM) by them. The driver is for a Winbond chip, so we better use Winbond
> names, or generic names.

The Winbond documentation mentions "SpeedFan(TM) Control" and "Thermal
Cruise", as you mention. I'd mixed the two up ;-)

> Stephen, do you have some kernel programming knowledge? We need someone
> to put the patch in conformance with the standard sysfs interface before
> we can integrate it. If not, can you at least test patches against
> recent kernels?

I'm afraid I don't have any kernel-specific programming knowledge - certainly
not enough to make the patch conform to the standard sysfs interface, of
which I know nothing! I'd be happy to test patches against recent kernels
though.

> Stephen, can you please do the following tests:
> 
> 1* In the BIOS setup screen, disable Q-fan, then boot Linux 2.6.14. You
> should not need the reset=1 parameter, pwm2 should work out of the box,
> because the BIOS will have left the chip in default configuration.

Yup, disabling Q-Fan allows fancontrol to control the fan without my having
to specify reset=1 when loading the w83627hf module.

> 2* In the BIOS setup screen, enable Q-fan, and set the "fan speed
> ratio" to, say, 13/16. Then boot Linux and report the output of
> "isadump 0x295 0x296". Try again with a different value, say 11/16,
> and report the output of the same dump. I want to know what register it
> affects. I'd guess 0x09, but a confirmation would be welcome.

I'm attaching three files: qfnone.txt is the register dump with Q-Fan
disabled, qf1116.txt with Q-Fan enabled at 11/16 (2100rpm or thereabouts),
and qf1316.txt with Q-Fan enabled at 13/16 (2350rpm or thereabouts). You're
right, register 0x09 changes, but others do too - some with the same values
as 0x09, some with another pair of values (eg. register 0x29).

Regards,

Stephen
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 b1 10 00 37 30 01 b1 01 b1 3c 3c 05 03 
10: 01 ff 10 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
20: 65 cb d7 be ff 00 00 23 72 50 70 00 00 d9 b2 d9 
30: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
40: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
50: ff ff 80 ff ff ff 00 00 90 20 ff ff 11 04 ff 05 
60: 65 cb d7 be ff 00 00 23 72 50 70 00 00 d9 b2 d9 
70: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
80: 01 ff 01 b1 10 00 37 30 01 b1 01 b1 3c 3c 05 03 
90: 01 ff 10 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
a0: 65 cb d7 be ff 00 00 23 72 50 70 00 00 d9 b2 d9 
b0: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
c0: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
d0: ff ff 80 ff ff ff 00 00 90 20 ff ff 11 04 ff 05 
e0: 65 cb d7 be ff 00 00 23 72 50 70 00 00 d9 b2 d9 
f0: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 d1 10 00 37 30 01 d1 01 d1 3c 3c 05 03 
10: 01 ff 10 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
20: 65 cb d7 be ff 00 00 23 72 47 70 00 00 d9 b2 d9 
30: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
40: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
50: ff ff 80 ff ff ff 00 00 90 20 ff ff 11 04 ff 05 
60: 65 cb d7 be ff 00 00 23 72 47 70 00 00 d9 b2 d9 
70: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
80: 01 ff 01 d1 10 00 37 30 01 d1 01 d1 3c 3c 05 03 
90: 01 ff 10 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
a0: 65 cb d7 be ff 00 00 23 72 47 70 00 00 d9 b2 d9 
b0: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
c0: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
d0: ff ff 80 ff ff ff 00 00 90 20 ff ff 11 04 ff 05 
e0: 65 cb d7 be ff 00 00 23 72 47 70 00 00 d9 b2 d9 
f0: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff 01 ff 00 00 37 30 01 b1 01 b1 3c 3c 05 03 
10: 01 ff 10 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
20: 65 ca d7 bf ff 00 00 22 72 41 70 00 00 d9 b2 d9 
30: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
40: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
50: ff ff 80 ff ff ff 00 00 90 20 ff ff 11 04 ff 05 
60: 65 ca d7 bf ff 00 00 22 72 41 70 00 00 d9 b2 d9 
70: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
80: 01 ff 01 ff 00 00 37 30 01 b1 01 b1 3c 3c 05 03 
90: 01 ff 10 00 00 01 01 3c 42 00 ff ff 24 32 00 de 
a0: 65 ca d7 bf ff 00 00 22 72 41 70 00 00 d9 b2 d9 
b0: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
c0: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
d0: ff ff 80 ff ff ff 00 00 90 20 ff ff 11 04 ff 05 
e0: 65 ca d7 bf ff 00 00 22 72 41 70 00 00 d9 b2 d9 
f0: c4 c5 b2 15 32 00 08 08 00 2d 28 fe fe fe 00 00 
