From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 02 Sep 2009 20:02:08 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <191fb4ca0909021302s28bdc3b1k239ca9fefeb7256c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

>> > Thank you for the suggestions.
>> >
>> > I looked in sysfs on the factory distro, no sign of dme1737 there (see
>> > attached). However there are other i2c devices not on my debian
>> > install...you could be right about the direct port io, but without
>> > disassembling the library it's hard to tell.
>> >
>> > I tried loading dme1737 with force_start, but that made no difference
>> > for me.
>> I was thinking about using the 'force' parameter to givie the address
>> explicitly to the module, the device may be on non standard port.
>> sensors-detect is usually more capable of detecting devices than kernel
>> modules
>
> Good point. The dme1737 driver only recognizes version/stepping value
> of 0x69 as the SCH5027. sensors-detect OTOH recognizes all version/
> steppings from 0x69 to 0x6f. It would be interesting to see a dump of
> the chip (modprobe i2c-dev then run i2cdump), I'd guess you have a
> version/stepping value > 0x69.
>
> Then I don't know which of the driver or sensors-detect is correct.
> Juerg?

The datasheet that I have specifies 0x69 as the initial
version/stepping value but doesn't specify the range of possible
values.

...juerg



> It might help to have a physical look at the chip and read the top
> marking, if this is possible.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
