From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 04 Sep 2006 21:12:31 +0000
Subject: [lm-sensors] Random thoughts on fan speed control
Message-Id: <20060904231231.c7dc7e1f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've been adding fan speed control to the f71805f driver today. Along
the way of testing, I had some thoughts which I'd like to share.

* Frequency matters. I wasn't convinced so far, now I am. The F71805F
defaults to a PWM frequency of 187.5 kHz. At this frequency, the fan is
at either full speed or stopped. I even feared for a moment that my
motherboard wasn't wired for fan speed control... Basically the fan is
at almost full speed down to pwm = 24, and then dives very fast, giving
you absolutely no control.

So I hacked a perl script testing several frequencies from 160 kHz to
30 kHz (the lowest the F71805F can do). You can see the result here:
  http://khali.linux-fr.org/devel/lm-sensors/pwm_response_curves.png

At and above 10 kHz, it's about the same as I just described. The range
where the pwm value actually matters is 0 - 40, not exactly usable.

At and below 100 Hz, I found that you reach a point where the fan speed
is no more reported properly. I puroposedly removed the bogus value
from the graph, but you can see where the curves are stopping, at
approximatively 1200 RPM. I guess that the tachometer doesn't like
these frequencies, so using them also means that you can't use the
lowest range of duty cycle values (< 64), as there's very little point
in controlling the fan speed if in return you can't monitor it anymore.

From this you'd conclude that the 300 - 2000 Hz frequency range is the
best choice. Except that my fan starts emitting high-pitch noise when I
use these frequencies. The whole point of fan speed control being noise
reduction, it pretty much voids the effort, replacing a noise with
another (even more annoying at that.)

* Fan speed control isn't ready for mainline. With the default PWM
frequency, I almost didn't notice that I could control my fan. Then it
took me a day of tests to find out what frequencies were better, and
what pwm value range to use in each case. And I'm not even sure what
I'll do now, as every frequency has some form of drawback. And of
course I presume that all of this depends on the fan model, so it's not
even worth documenting for others.

* Reading the F71805F documentation, I learned that the external
circuitery needed for PWM fan speed control is completely different
from the one needed for DC fan speed control. So I wonder if it is a
good idea to let the user change between the two modes. Clearly the
BIOS should set it right. I tried to switch to DC mode and it had no
effect at all on my fan (not even on/off). I wonder if it is possible
to confuse or even damage the hardware by using the wrong mode?

* pwmconfig doesn't work for non-i2c-based hardware monitoring drivers,
because the script still looks for the devices in /sys/bus/i2c rather
than /sys/class/hwmon. We need to fix this before the 2.10.1 release.
Any volunteer? It's probably just a couple of lines of shell to add.

-- 
Jean Delvare

