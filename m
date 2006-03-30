From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 30 Mar 2006 21:26:00 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <442C4CE8.3020909@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
In-Reply-To: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Hi,
> 
> 
>>Sometimes there are places with spaces and not tabs (especially in #define
>>) plus some operators like + dont have spaces around too.
> 
> 
> Ok, will fix.

Good.

> 
> 
>>I'm proposing that some of funcs can be done via macro or 2D array. This
>>might help to shrink the source code a bit.
> 
> 
> I had it this way in the begining but threw it out for some reasons I
> can't remember anymore. I'll take a look at it again.

Maybe Jean have some idea about it too? Or others?


>>I'm not user about the runtime UCONFIG configuration. Perhaps cleanest
>>solution would be to create/remove sysfs nodes
>>runtime instead of exporting them with zero.
> 
> 
> I don't understand. Exporting the UCH config register is a left-over
> from the 2.4 driver. I think the reason why it's in the 2.4 driver is
> because some BIOSes don't set it correctly. Maybe this is not true
> anymore and we can now fully rely on the BIOS doing it right and don't
> need to export the register anymore. Comments anyone?

Well me. I think we can drop this interface and read the UHC conf only at the
driver start. User with bad BIOS config can do i2cset/isaset commands if neccessary
to change the config and then load the driver.


>>Also I think several printks can be replaced with dev_err stuff.
> 
> 
> OK, will do.
> 

Good.

>>Last thing to discuss is about the forced interrupt mode. I'm not sure if
>>it is OK because it may affect the chip
>>pins.
> 
> 
> Well the vt1211 implements 3 different interrupt modes (or more
> precisely 3 different modes of how interrupts get cleared):
> 
> 1) Generate INT when temp exceeds max limit. Clear INT when temp falls
> below max limit.
> 2) Generate INT when temp exceeds max limit. Clear INT when status
> register is read. Regenerate INT as long as temp stays above
> hysteresis limit.
> 3) Generate INT when temp exceeds max limit. Clear INT when status
> register is read. DON'T regenerate INT until temp falls below
> hysteresis limit and exceeds hot limit again.
> 
> The default is mode 3 (on my EPIA M10000) and the driver sets it to
> mode 2 upon initialization. This is also a left-over from 2.4 and it
> has been around for some time. I'm not aware of any problems with this
> so I'm reluctant to change it unless somebody fells strongly about
> it...

Ok I think we can drop it later if it causes some troubles.

> 
> 
>>I'm not too familiar with the platform stuff yet so I'm asking Jean to
>>look into this.
>>
>>Overall the code looks very good. I tried to read all the stuff carefuly
>>but it is quite difficult not to miss anything.
>>(and even I spent like 3 hours just with reading and I'm not even sure :(
>>)
> 
> 
> Thanks for taking the time to look at the patch. I really appreciate
> it and keep up the good work! You guys do an outstanding job!

Well this work is done mostly by me and Jean and sometimes Mark... People willing to help with this would be welcomed.

Regards,
Rudolf

