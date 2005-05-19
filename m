From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (almost solved)
Message-Id: <200307281908.44724.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030727233434.568d9d4c.khali@linux-fr.org>
In-Reply-To: <20030727233434.568d9d4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne po 28. ?ervence 2003 16:57 jste napsal(a):
> OK, just finished. I fixed a pair of actual or potential bugs and
> cleaned the code up (over 10% reduction in source code size). Could you
> please give it a try and tell me how it works for you? Remplace the file
> in kernel/chips with this new one, recompile, reinstall and you're done.
>
> What you should expect to see:
> 1* +12V reading = 0 (because it's not wired on your board, and that's
> why it doesn't appear in Intel's software).

+12V:      +0.06 V  (min = +10.68 V, max = +13.06 V)   ALARM 
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)

> 2* Slightly higher default voltage limits (both min and max).

after reinstall ne1619 driver are values of min/max voltage 0.

e.g.

+2.5V:     +2.48 V  (min =  +0.00 V, max =  +0.00 V)
+2.5V:     +2.48 V  (min =  +0.00 V, max =  +0.00 V)

(I only replaced driver, recompiled lm_sensors and rebooted)

> 3* No more ALARM for VCore nor +12V.

OK

> 4* No need to force the driver anymore.

perfect. 
btw: speed of fan can show lm_sensors with ne1619 too?

> You may have to reboot your system (sigh) in order to see 1* and 3*.
> That's because our driver used to overwrite a configuration bit. I fixed
> that but if it has already been overwritten by the previous version of
> the driver, it won't help.
>
> I admit the changes aren't very important from the user-side, but I have
> indeed changed many things in the simplification process so I'd like to
> see how it turns out, and that's why I'm very interested in you testing
> the new driver.
>
> I'll also appreciate a dump of the
> /proc/sys/dev/sensors/adm1025-i2c-0-2d/* files. You could play a bit
> with limits in the config file too, and see if it does what it is
> supposed to do.

OK, current values are:

alarms 0
in0 0.00 0.00 2.48
in1 1.40 1.55 1.46 
in2  0.00 0.00 3.33
in3  0.00 0.00 5.02
in4  0.00 0.00 0.00
in5  0.00 0.00 3.26
temp1 0.0 0.0 43.0 
temp2 0.0 0.0 43.0 
vid 1.500
vrm 9.0

> > > BTW, is the data at address Ox44 on your I2C bus still the same? ;)
> > > Just curious.
> >
> > you think this magic line? 00: 00 00 0f 3f 00 00 02 00 50 00 00 00 00
> > 00 00 00 It's constantly. I tested something and after 2-3 reboots
> > looks this line still same, so maybe you have new fun ...
>
> No fun, it just confirms it must be some kind of EEPROM. I don't have
> any idea of what it can stand for however, so I won't go any further
> unless the other guy can help (not heard from him yet).

all right, bye ...
-- 
Ondrej Cecak

