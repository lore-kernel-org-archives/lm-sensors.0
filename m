From: cgfreita@netsite.com.br (cgfreita)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040726110020.5b2fdfb5.cgfreita@netsite.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

> > 1) I was reading my mainboard manual and I found that there is a
> > third fan connector (1 processor fan and 2 chassis fans). I have
> > just two: 1 processor and 1 chassis). I confirmed at the mainboard
> > and the third connector is really there. I can't test it for now.
> 
> I've read the manual too, and it says that fan3 control is optional,
> depending on whether you have a 47M132 or 47M142 chip. They also say
> that the CPU fan can be monitored but not controled, and that the
> System fan can be monitored and controled.

	Great. I was reading the short manual (printed version)
	I was just looking for fan connectors position. But this information
is interesting.

> > I tried to put values in fan1_min.
> > It didn't accepted values less than 1299 and treated it as 1300.
> > I tried negative values and it didn't accept it.
> > (if you "cat fan1_min" or use sensors command, the output is the
> > same: 1300)
> 
> Fine, that's exactly what was supposed to happen.
> 
> Note that the actual min depends on the fan clock divider. I guess
> you had a divider of 4.

	Yes, divider equals to 4. :-)

> > As I said, I am not using PWM (power management?), so I don't
> > know how to try this. Sorry.
> 
> PWM means for "pulse width modulation" and not related to power
> management at all. It's a way to control the speed of your fans.
> 
> In /sys/bus/i2c/devices/1-0800 you should see files named fan1_pwm
> and fan1_pwm_enable. You can change their values to control how fast
> you want your fan to spin. That's interesting if your system is not
> too hot but a bit noisy. It basically lets you select a
> temperature/noise tradeoff.

	I had already seen this files, but I didn't know about PWM meaning.
Thank you.
	I tried to change fan2 and, as we could see, fan2 here, at my
mainboard, means processor fan and, as you told, it can't be turned
off. :-)

> fan1_pwm_enable can take two values: 0 and 1. 0 means that the fan
> is always running at full speed. 1 means that you can control the
> speed with the second file, fan1_pwm. fan1_pwm value is between 0
> (fan off, not recommended) and 255 (full speed).
> 
> Note that depending on how the motherboard is wires, fan1_pwm can
> control fan1 OR a different fan, there's no way to know. Anyway,
> according to your motherboard docs, cpu fan speed is not
> controlable, so you should be able to play safely with this feature
> (unless your fans are not plugged in the correct headers).
> 
> If fan1_pwm doesn't seem to have any effect you can try fan2_pwm.
> 
> A test sequence would be:
> echo 255 > fan1_pwm
> cat fan1_pwm (should read 252)
> echo 1 > fan1_pwm_enable
> cat fan1_pwm_enable (should read 1)
> echo 160 > fan1_pwm
> cat fan1_pwm (should read 160, fan should slow down)
> echo 0 > fan1_pwm_enable
> cat fan1_pwm_enable (should read 0, fan should go back to full
> speed)
>
> You should wait 2 seconds between each command to make sure you read
> the values from the chip and not from the cache.

	I patched -R the last diff.
	I patched with the file below.
	Compiled fine.
	I tried the commands above.
	Just an strange behavior with sensors command information.
	Please, take a look at probs4.txt attached.
 
> Yes. I've updated the patch:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-beta2.diff
> 
> I've fixed a number of corner cases, and also added some code so
> that changing the fan clock divider should preserve the
> corresponding fan min. I'd like you to try that:
> 
> echo 8 > fan1_div
> cat fan1_div (should read 8)
> echo 3000 > fan1_min
> cat fan1_min (should read around, but not exactly, 3000)
> echo 2 > fan1_div
> cat fan1_div (should read 2)
> cat fan1_min (should read around, but not exactly, 3000)
> echo 4 > fan1_div
> cat fan1_div (should read 4)
> cat fan1_min (should read around, but not exactly, 3000)
> 
> Also, about the logs you sent, I'm a bit surprised about the alarms.
> You seem to be as well... Looks like they trigger more often than
> they should (i.e. if the fan speed is little above the limit). Could
> you please provide a dump of your chip so that I can check why this
> happens?
> 
> isadump -f 0x800 0x80
> 
> And if possible the corresponding output of "sensors" with such an
> alarm set.

	Please, take a look at results_jean.txt and results_jean_dump.txt.

> > compute fan2_min (@+4), (@+4)
> 
> You can discard that, it's not worth it IMHO. Fan speeds are not
> exact values, some noise is expected.

	Discarded. :-)
	All tests I did were made without this line.
	If you need more information, please tell me.
	From today, I can delay a little more to answer because I am back to
college classes. (The end of vacation)

	P.S. My english is not good enough. :-)

	Thank you.

Cheers,

Freitas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: probs4.txt
Type: application/octet-stream
Size: 4235 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040726/8c902c84/probs4.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: results_jean.txt
Type: application/octet-stream
Size: 4483 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040726/8c902c84/results_jean.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: results_jean_dump.txt
Type: application/octet-stream
Size: 725 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040726/8c902c84/results_jean_dump.obj
