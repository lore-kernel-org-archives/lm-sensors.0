From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Nov 2011 17:27:51 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE
Message-Id: <20111115182751.7ba724ba@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
In-Reply-To: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Nov 2011 13:49:46 -0200, Gustavo De Nardin (spuk) wrote:
> * Jean Delvare <khali@linux-fr.org> [2011-11-14 22:45 +0100]:
> > On Mon, 14 Nov 2011 19:14:16 -0200, Gustavo De Nardin (spuk) wrote:
> > > Unlike forcing the other chips' ids, with force_id=0x8721 PWM control seems
> > > to work reasonably, with pwm1_enable=1, pwm1=0 yields around 1132 RPM on the
> > > CPU fan, and pwm1%5 yields around 3260 RPM.  Should pwm1=0 actually stop
> > > the fan?  I get what (empirically) seem to be consistent logarithmic
> > > increase in RPM when increasing pwm1 value, anyway.
> > 
> > If this is a 4-wire fan then your results are expected. pwm=0 always
> > stops 3-wire fans (no power -> stopped) but typically 4-wire fans have
> > a minimum speed (speed control is separate from power.)
> 
> Yes, this is a 4-wire fan. The chassis fan connector is 3-wire though, and I
> can't seem to control the speed of a 3-wired fan by writing to pwm2.

It's up to the board designer to route the PWM pins to one or more
fans. Sometimes they do, sometimes they don't. Unfortunately this is
often not documented

> > So it's really a matter of finding the right scaling factors. Easiest
> > way in your case if probably to extract them from the DSDT table. See
> > http://www.lm-sensors.org/wiki/AsusFormulaHacking for some information
> > on this. If you provide the DSDT to myself and Luca we should be able
> > to figure it out.
> 
> Here: http://spuk.denardin.org/Asus_M5A78L-M-v0603_DSDT.bin
> 
> No hurry from me, I'm gonna use asus_atk0110 for reading, and it87 only for
> PWM control or now.

Ick, no, don't do that. Actually normally you can't, the drivers won't
let you do that. it87 will refuse to load if
acpi_enforce_resources=strict and asus_atk0110 will refuse to load if
not. You did not manage to load both at the same time, did you?

> I'm trying making sense of the formula in the RVLT method. How can I use
> isadump to get the raw values for checking the formula?

First you have to find the base I/O address of the chip. sensors tells
you it's 0x290. So the dump can be obtained with:

# isadump 0x295 0x296

This is preferably done with neither it87 not asus_atk0110 module
loaded. See it87.c for voltage register definitions:

#define IT87_REG_VIN(nr)       (0x20 + (nr))

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
