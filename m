From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: winbond temp magnitudes 2.6.1-rc1
Message-Id: <1074074899.400515137b60f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4004AEFE.2030605@verizon.net>
In-Reply-To: <4004AEFE.2030605@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark Studebaker:

> The w83781d and friends temperature magnitudes, that were 2 in
> -test9, are now even more whacked in -rc1.
> temp_xxx1 is still 2; temp_xxx2 and temp_xxx3 are now 1.
> Can anybody else verify?

I did not notice such a behavior, tested on a A7V133-C (as99127f rev.1)
with versions 2.6.1-rc1 to 2.6.1 final. Could you please double-check
that you are using vanilla kernel sources?

The differences in w83781d.c between .0-test9 and .1-rc1 can be seen
here:
http://www.linuxhq.com/kernel/v2.6/1-rc1/drivers/i2c/chips/w83781d.c

And there's nothing about temp magnitudes as far as I can see.

> I thought we were going for a magnitude of 3 everywhere?!?!?!

I submitted a patch to Greg that does just that, in case you missed it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
