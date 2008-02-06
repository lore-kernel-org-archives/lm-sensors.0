From: "Peter Eser" <Peter.Eser@heuft.com>
Date: Wed, 06 Feb 2008 08:42:44 +0000
Subject: Re: [lm-sensors] failed to load it87 module on IT8712F
Message-Id: <000601c8689c$3dfdf6e0$180411ac@EDVW14>
List-Id: <lm-sensors.vger.kernel.org>
References: <002001c8641e$71d8f6e0$180411ac@EDVW14>
In-Reply-To: <002001c8641e$71d8f6e0$180411ac@EDVW14>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

yes the values of the it8712 make sense.
Most likely its a BIOS issue, I try now to connect Aaeon (They celebrate new
year at the moment...).
The VT1211: I have a VIA CX700M on board and on
http://www.via.com.tw/en/products/chipsets/c-series/cx700m/
it looks like it's included.

Many Thanks, I let you know how the story moves on...

Peter



----- Original Message -----
From: "Jean Delvare" <khali@linux-fr.org>
To: "Peter Eser" <Peter.Eser@heuft.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>; <lm-sensors@lm-sensors.org>
Sent: Sunday, February 03, 2008 5:51 PM
Subject: Re: [lm-sensors] failed to load it87 module on IT8712F


> Hi Peter,
>
> On Fri, 1 Feb 2008 07:50:43 +0100, Peter Eser wrote:
> > Ok, switched on some debug messages on i2c and hardware monitoring chip
> > debugging messages.
> >
> > After that on insmod it87 I also see "Device not activated, skipping"
> > (perhaps I've only overseen that before).
> > I then commented out the goto exit; in it87.c after this message and
voila
> > the driver says now:
> >
> > Found IT8712F chip at 0x290, revision 7
> > it87 it87.656: Detected broken BIOS defaults, disabling PWM interface
> >
> > sensors says:
> >
> > it8712-isa-0290
> > Adapter: ISA Adapter
> > and the voltages, etc. following (yeah...)
>
> Please include the actual output of "sensors". Just because it prints
> values doesn't mean these are real. In particular, if the logical
> device is not enabled, it is likely that the chip doesn't actually
> refresh the monitored values. Check if the values make sense, and check
> if they change over time.
>
> 99% of the time, logical devices that are not activated by the BIOS are
> not actually used. That's the reason why most hwmon drivers do not have
> any option to forcibly activate the disabled devices. Your case could
> be different, of course... But then it would call for a BIOS fix rather
> than a driver fix.
>
> In your original post, you said that the board was also supposed to
> have a VT1211. Did you find it on the board? Or could it be hiding
> under a heatsink? If the board really has both a VT1211 and an IT8712F
> then it is very likely that only one of those has its hardware
> monitoring features used. I have to admit I would be surprised though -
> two Super-I/O chips on the same board doesn't make much sense.
>
> --
> Jean Delvare
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
