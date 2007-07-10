From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jul 2007 21:16:04 +0000
Subject: Re: [lm-sensors] fintek f71806f "support"
Message-Id: <20070710231604.30f5b15f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46913350.70300@hhs.nl>
In-Reply-To: <46913350.70300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 08 Jul 2007 20:56:16 +0200, Hans de Goede wrote:
> While updating the f71882fg wiki entry I noticed the f71806f entry said that 
> there is no datasheet, however the same webpage offering the f71882fg datasheet 
> has the f71806f datasheet too.

When I added the entry there was no datasheet available. I suppose that
Fintek added it meanwhile (which is good news.) Thanks for updating the
Devices page. BTW, please always add a comment (field at the bottom of
the edition page) to describe what changes you make in the wiki, that
makes it easier for others to follow what's going on.

> So I downloaded it to add detection code to sensors-detect, but we already 
> detect it as a ... f71872f, because they have the same devid (fintek did the 
> same with the f71882fg and the f71883fg) . I've been comparing all the hwmon 
> pages of the f71806f and f71872f page by page, here are the results:
> 
> Harmless differences:
> ---------------------
> 
> 1) The 71872 has hwmon register 09h "documented" as External BJT Offset
>     Register, with all bits reserved.
> 
> 2) The 71872 has  VIN_FAULT Mode Register 3  Index 39h, bit 7 documented,
>     marked as r/w and ... reserved, the 71806 has it as just reserved
> 
> 3) VIN_FAULT STATUS Register  Index 3Ah, bit 7 idem as 2)
> 
> 
> Troublesome differences:
> ------------------------
> 
> 1) The 71872 has T1 OFFSET Register -- Index 90h, and T2 at 91h and T3 at
>     92h, which the 71806 lacks according to its datasheet

The F71805F has them there as well. Strange that the F71806F doesn't.
My f71805f driver doesn't use these registers yet though, so it's not a
problem for now. But certainly something to keep in mind if we ever
implement support for temperature offset registers in this driver.

> VID differences:
> ----------------
> 
> 1) The 71872 has bit 3 of VID Control Register  Index 00h defined, for the
>     71806 this bit is reserved

I'm not too sure what this bit is supposed to do, but it seems to be an
advanced feature we probably don't want to support, so no big deal.

Thanks for doing this datasheet comparison, it might prove useful in
the future.

> Notice that the identical device id means that sofar sensors-detect has been 
> identifying the 71806 as a 71872, and most likely people have been loading and 
> using the 71872 driver on this chip too, I assume that the 71872 driver uses 
> the temp offset registers, and this could cause some troubles.

I'm not sure if there already are many F71806F chips in the wild. We
did not have any request to support it, while we did have several
requests to support the F71872F. But the fact that we did report both
as a F71872F so far may explain it in part.

>                                                                 Unfortunately I 
> haven't been able to find a way in the datasheets to find out which chip we are 
> really dealing with.

As said above, the f71805f driver does not use these offset registers.
If said offset registers are read-only on the F71806F, that would be a
way to differentiate between both chips (arguably ugly, but...)

I just updated sensors-detect to mention the F71806FG. I also added
detection for the F71862FG, now that its datasheet is available. And to
be complete, I added an entry for the F71862FG to the Devices page on
the wiki.

Now, the f71805f driver (and documentation) would need to be updated to
list the F71806F/FG as supported. Can you please submit such a patch,
or do you want me to do it?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
