From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: 1283 ticket datasheet
Message-Id: <20031215204332.18f34069.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055798868.13976.2.camel@rentnerschreck.mine.nu>
In-Reply-To: <1055798868.13976.2.camel@rentnerschreck.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marius,

I am in the process of writing a driver for the W83L785TS-S. I would
like you to answer a few question if possible:

> Don't worry about the different partnumber in the link, they made a
> mistake in the document name. You'll see the correct partnumber in the
> document itself.

Yes, noticed that.

> There are other mistakes too: 
> Page 8 says "The 8-bit temperature data can be obtained by reading the
> register." without telling you which one (it's CR27).

Agreed.

> In the tables on page 10,13 and 20 the values for R1 are wrong in the
> row 85?C/30?C (should be 9.1K instead of 91K) and in the row 85?C/32?C
> (should be 6.8K instead of 68K). Of course now that I understand the
> purpose of those resistors I realize that they don't matter for a
> device driver.

That's right, we don't care, but thanks for the clarification anyway.

> Most important is the mistake on page 10 where the sentence reads:
> "When monitoring CPUT1 (Pin 2) temperature exceeds temperature fault
> limit(ex: 90 o C) in CR26, or CR27, pin6 TEMP_FAULT# will be
> asserted.". This should really read: "When monitoring CPUT1 (Pin 2)
> temperature in CR27 exceeds the temperature fault limit in CR26 (ex:
> 90?C) pin6 TEMP_FAULT# will be asserted.". 
> On page 13 the document declares CR26 to be reserved, but I checked on
> my board and it does indeed contain the temperature fault limit value.

I'm rather skeptical for this one. I would read the temperature fault
limit from register 0x53, according to the data sheet. That said, the
value in this register, from a dump one user provided, is 100, while I
would expect 85 of 90.

I think that the confusion with register 0x26 in Winbond's sheet comes
from the fact that this register holds a second temperature value in the
W83L785R, and the 785TS looks like a cut down version of the 785R. But I
have value 89 in this register, so I admit it would be a reasonable
value for a limit as well, although that's neither 85 nor 90 either.

Could you provide a dump (using i2cdump) of your chip so that I would
have a second set of data?

For now my driver is read-only. I do not allow the user to write a
custom limit. There are two reasons for that:
1* I'm still not sure which register it is.
2* I'm not even sure it is possible to change this value. The datasheet
says the value is latched at startup, maybe that's not something we
can/should change after.

If you volunteer to make write tests, let me know and I'll tell you what
to do exactly.

> Another thing to note is that the 7-bit i?c address is 0101110.
> Normally the lowest bit indicates reading from or writing to the chip.
> This would make 0x5C the read and 0x5D the write address. However the
> chip is clearly accessible at the address 0x2E on the A7N8X (same
> 7-bit address just shifted to the right).

I don't see any problem here. I2C addresses are almost always given as 7
bit values. This is the real address of the chips. The fact that you
have to append a 0 or a 1 to write or read to/from the chip is another
thing. I've seen people using the "read address" instead of the 7-bit
address but that's confusing IMHO. So Winbond is right here :) We can't
blame them all the time.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
