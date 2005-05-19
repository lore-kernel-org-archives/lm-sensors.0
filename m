From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <20040715214017.657536ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F5A42D.9070301@verizon.net>
In-Reply-To: <40F5A42D.9070301@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried 1, 2, 3, and 2345, or something like that out of
> rustration.:-) here's what I get trying the diodes (3).
> 
> Temp1:       +70?C  (low  =   +20?C, high =   +70?C)   sensor = invalid
> Temp/MB:     +29?C  (low  =   +25?C, high =   +45?C)   sensor = invalid
> Temp/CPU:    +21?C  (low  =   +15?C, high =   +60?C)   sensor = invalid

The "sensor = invalid" is exactly what was fixed in 2.8.5's "sensors".

That's just a matter of displaying the correct string however; it has
obviously no effect on the values.

The driver itself had some changes though. As said earlier, I doubt
it'll change anything, but that may still be wyrth trying.

You don't use the reset_it87 module parameter, do you?

If you run Windows, I'd be interested in you trying Motherboad Monitor
as a replacement for the ITE's tool, and tell me how it works. If Alex
managed to handle your case, he will probably help us.

> It finds a sis5595 I think, and at one time I think I had it installed
> too, but I can't find a sis5595 module to install now. I installed
> i2c-sis5595 but got no more sensors. Is there a plain sis5595 module
> for the 2.6.3 kernel? I'll look into this. But in win, the program
> that displays the temps is Smartguardian, and it's from ITE, not sis.

The SiS5595 is both an i2c bus (i2c-sis5595 driver) and a hardware
monitoring chip (sis5595). Beware however that it tends to be easily
misdetected, especially in not-so-recent versions of sensors-detect. You
could try sensors-detect from 2.8.7 and see if it changed its mind.

However, if the "Smartguardian" Windows tool does it all alone, you're
correct that it's most likely getting the value from the it87 itself and
not a secondary chip.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
