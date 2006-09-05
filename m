From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 05 Sep 2006 16:20:18 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <20060905182018.7eae4adb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David, Matthias,

> Nice to get some feedback on w83627ehf. The datasheet documents only 4
> RPM sensors, but 5 pwm outputs. That's if your motherboard uses the
> standard w83627ehf without any additional electronics.

No, that's the other way around. 5 RPM sensors, 4 PWM output.

> Can you disconnect one fan at a time while in the BIOS readings and
> verify that each is independent of all other fans? I wonder if the
> BIOS is actually getting 5 independent RPM readings.

The number of readings in the BIOS matches the number of fan monitoring
inputs of the chip - looks clear enough to me.

> Also, is there some way (a different OS, or in the BIOS) that you can
> actually control each of the fans independently? I'm looking for more
> info on your motherboard, but there is the possibility that the two
> CHA fans and the two PWR fans are actually hard-wired together.

This is my conclusion as well. The PWM outputs wiring is decided by the
motherboard maker, and they may use the same PWM output for several
fans. Given that there are only 4 PWM outputs they actually had little
choice for at least two fans. It makes sense to me to control related
fans with a single command too.

> Can you provide a listing of the sysfs files exported by the driver on
> your system? The w83627ehf pins for fans 4 and 5 can be programmed as
> general purpose I/O, and the driver detects whether you have 3, 4, or
> 5 fan pins configured. (The setting is read, but not changed.) So...do
> you have pwm4 and pwm5 in your sysfs?

Matthias, can you please provide a dump of your chip (isadump 0x295
0x296) at init time, before loading the w83627ehf driver?

I'd try forcing the driver to use all 5 fan inputs. Just run "isaset
0x295 0x296 0x47 0x05 0x05" before loading the w83627ehf driver, and
see what happens. It's supposed to be the default, but...

Maybe our heuristics to detect the use of the pins are not correct,
although they are simple enough and look OK to me. Or maybe the Asus
BIOS isn't configuring the chip properly (that'd be odd as they need
proper setup for displaying the values themselves.)

-- 
Jean Delvare

