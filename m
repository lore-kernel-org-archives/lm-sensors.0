From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Mar 2011 11:19:09 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <20110312121909.79585472@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Sorry for the late answer.

On Tue, 9 Nov 2010 10:35:51 +0100, Juerg Haefliger wrote:
> Hi Jean
> 
> >> Took a quick glance at the datasheet. This is a totally different
> >> beast that is not even remotely compatible to anything we support thus
> >> far AFAIK. It contains an embedded microcontroller (!) which handles
> >> all the hwmon related tasks. The datasheet that I received doesn't
> >> contain any information about the microcontroller other than a simple
> >> block diagram. So at the moment it's absolutely a no go and even with
> >> all the technical data we would have to start from scratch with a new
> >> driver.
> >
> > Thanks Juerg for checking this. Can you please update sensors-detect
> > with the device name and features, and also create an entry in
> > wiki/Devices? So that other user with that chip know the current
> > status, even if it's bad.
> 
> I added detection to sensors-detect but I'm not too happy with the outcome:
> Trying family `SMSC'...                                     Yes
> Found `SMSC SCH5627 Desktop Embedded Controller'
>    (but not activated)
> 
> The chip shouldn't be probed at all since it's non-standard. Users
> might get confused by the 'not activated' message and will ask how to
> activate it. Is there a way to bypass the probing and just print a
> message that there is no driver for this chip?

Hans submitted a candidate driver for this device meanwhile, so it
would make sense to add support to sensors-detect too.

I am surprised by your report above. Looking at Hans's driver code, the
only non-standard thing about the SCH5627 is that the base I/O register
is at 0x66 instead of 0x60, with swapped bytes. The activation bit is
still 0x30[0], while your message above suggests that the bit in
question wasn't enabled on your system (although it's a little
difficult to comment, given that you never shared your sensors-detect
patch with us; maybe you selected the wrong logical device?)

Anyway, I agree that the non-standard location of the base I/O register
isn't supported by sensors-detect yet. We already have some code to
handle non-standard SMSC chips, but the SCH5627 is non-standard in a
different way. I'll try to come up with something, stay tuned.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
