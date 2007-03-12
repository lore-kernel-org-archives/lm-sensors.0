From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 16:49:26 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070312174926.62947dce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

On Mon, 12 Mar 2007 15:44:19 +0100, Hans-J?rgen Koch wrote:
> Am Montag, 12. M?rz 2007 14:50 schrieb Jean Delvare:
> > We have fan1_input and fan1_target for this. 
> 
> Documentation/hwmon/sysfs-interface doesn't mention fan1_target. I tried to 
> follow that specification. I'll rename "speed" accordingly.

Sorry about that, it is relatively new, only one driver supports that
at the moment (f71805f) and I forgot to update the documentation
accordingly. Patch attached, comments welcome.

> > > fan1_min_speed,
> > > fan1_max_speed: (rw) Planned/defined operating range in RPM
> >
> > We have fan1_min for the former. We could have fan1_max for the latter,
> > but no known chip actually supports upper limit for fan speeds.
> 
> My intention was not to set upper/lower limits but to allow the driver to 
> calculate things like "divider" or "counttime". If I make "divider" 
> or "counttime" (or whatever algorithm a chip uses) sysfs attributes, then a 
> user needs data sheet and calculator to find appropriate values for them. 
> Min/max values are either known or can simply be found by experimenting and 
> the rest is calculated by the driver, not by the user.

Ah, I get the idea now, interesting.

I proposed some times ago that drivers could adjust these parameters by
themselves, by detecting overflows and underflows, but my proposal
received a mitigated response, and only a few drivers are implementing
this at the moment (w83627ehf, adm9240 and pc87360 IIRC). Choosing the
fan clock divider (or whatever it is) based on expected speed range is
more or less the same. For most chips, fast fans are not the problem,
slow fans are, and setting fan1_min had the effect of pinning down the
clock divider to the correct clock divider value in my model. Pretty
much what you are proposing...

> > > fan1_mode: (rw) on, off, closed_loop, open_loop, ...
> >
> > This is exactly what pwm1_enable does. The name could have been chosen
> > better, granted.
> 
> I don't understand Documentation/hwmon/sysfs-interface in this point. Which 
> values for pwm1_enable correspond to on, off, closed_loop, and open_loop? Can 
> I define new ones? The text mentions "2+"...

pwm1_enable = 0 means no control at all, i.e. fan on at full speed.
pwm1_enable = 1 means manual control, from fan down (pwm1 = 0) to full
speed (pwm1 = 255.) This is your open loop as I understand it.
pwm1_enable = 2 or more is any form of closed loop. Some chips
implement the feedback based on temperature, some on fan speed. Some
chips implement both (e.g. Fintek F71805F.)

> I'll do that if possible. After all, I have two registers (prescaler and 
> countime) that are affected. As I'm limited to powers of two by the 
> specification, it might not fit. If that is the case, I'll leave that 
> attribute away and we have to live with a fixed value given by a module 
> parameter.

Notice that the counttime is also only expressed as powers of 2.

> All right. New version will follow soon.

Great, thanks.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-sysfs-interface-add-fan-target.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070312/c90e122d/attachment-0001.pl 
