From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: New max6626.c driver for linux 2.6
Message-Id: <20041120111745.25890602.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> To get the MAX6626 to work the attached patch is required
> I think this is a general error:
> snip ...
> 	/* Now, we do the remaining detection. There is no
> 	identification-
> 	   dedicated register so we have to rely on several tricks:
> 	   unused bits, registers cycling over 8-address boundaries,
> 	   addresses 0x04-0x07 returning the last read value.
> 	   The cycling+unused addresses combination is not tested,
> 	   since it would significantly slow the detection down and
> 	   would hardly add any value. */
> ... snip
> "so addresses 0x04-0x07 returning the last read value"
> I think the idea behind checking against co and os is following:
> there must be one and only one of the register read back equal to them
> (isn't it?)
> In the original driver the exit was forced when one of them was not
> equal.

No, the original code is exact. On the LM75, addresses 0x04-0x07 are
non-registers, thus the chip returns the last read register value when
these addresses are queries, whatever the register was. In our detection
code it happens that the last read value is hyst, so we check all
0x04-0x07 addresses against this value.

We generally avoid relying on such tricks but the LM75 is otherwise hard
do detect.

If the MAX6626 behaves differently we may be more tolerant, at least for
addresses where the MAX6626 is known to live. Could you please provide
the output of i2cdump for your MAX6626 chip? Feel also free to add some
printks in the driver code to see which values are returned for
addresses 0x04-0x07.

> On my wishlist there would be further extension to the driver:
>   - the name lm75 -> max6626

How that? There is no way to differenciate between both chips as far as
I can see (other than chips at addresses 0x4C-0x4F cannot be MAX6626
chips). You may also rely on the extra temperature bits but there's an
obvious 1/8 failure, plus not only the MAX6626 clone has 12-bit
resolution if I remember correctly.

I don't think it's worth the pain trying to label the chips properly
since we will have an obviously non-neglectable failure rate (actually
the failure would more likely be the rule than the exception).

>   - the register names found in /sys directory
>     for example temp1_max_hyst should be renamed to tlow

Certainly not. We had a very hard time agreeing on what would be a good
standard name scheme, and we're not changing that now. See
Documentation/i2c/sysfs-interface. Basically we want the names to
reflect the function in a standard way, regardless of how the datasheets
names the feature.

>   - support for the additional three bits of resolution in temp1_input

Fair enough, should be quite straightforward.

> What would you propose?
>  - reuse the lm75.c
>    may be you can give me some hints in doing that

Open, edit, save, compile, test :)

I see only two locations requiring changes:

1* Detection code if the MAX6626 behaves slightly differently from the
LM75.

2* Temperature conversion. The functions are in lm75.h and used by other
drivers so don't edit them directly, instead duplicate them with a
different name and use them in the lm75 driver.

>  - add new dedicated driver max6626.c

I don't think this would make much sense since both devices are 90%
compatible.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
