From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <JKhjj76Y.1111065984.8408240.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Tony, hi all,

> I was able to also duplicate the bug with eeprom with nividiafb-i2c, and
> the bug only appears when running sensors as a regular user, not as root.

Correct, that's what was reported in bug #4347 also.

> I've tracked this to eeprom_read in drivers/i2c/chips/eeprom. I don't know
> exactly what happens but commenting out this part in eeprom_read():
>
>	if (data->nature = VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
> #if 0
>		int in_row1 = 16 - off;
>		memset(buf, 0, in_row1);
>		if (count - in_row1 > 0)
>			memcpy(buf + in_row1, &data->data[16], count -
>			       in_row1);
> #endif
>
> at least, prevents the hang.

First thing I noticed is that you should never enter this portion of
code, since it is there only for Vaio laptops. I found that this is
caused by a bug I introduced recently in a different part of the code.
Missing curly braces cause *all* EEPROMSs at address 0x57 to be
considered as Vaio EEPROMS, regardless of their content. I will submit a
patch to fix this soon. I apologize deeply for introducing this bug :(

However, this side bug does NOT explain the behavior observed here, it
only allowed the oops to happen. It would be great if we could
understand why the oops happens, so that we can really fix the problem.

Could you please add some printks on off, count and in_row1 in various
places so that we can find out which values are passed to memset and
memcpy?

I guess that either memset or memcpy is causing the oops. It would be
great if you could isolate which one exactly does.

I'll do some additional tests this evening. I do have a Vaio laptop and
also a monitor with an EEPROM at 0x57. Both systems use radeonfb.

Thanks,
--
Jean Delvare
