From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 10 Aug 2005 12:15:01 +0000
Subject: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <OlUL6TaR.1123668419.1485260.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <42F95E9E.90204@yahoo.com>
References: <20050809231328.0726537b.khali@linux-fr.org>
In-Reply-To: <20050809231328.0726537b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: salahx@yahoo.com
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>


Hi Salah,

[Salah Coronya]
> I have a VT8235 chipset, I applied the patch to my kernel
> (2.6.12-gentoo-r6), compared the "before" and "after" eeproms in /sys
> with diff and they are the same.

Beware that eeprom files are binary files, so "diff" might not be the
more suitable tool for the job. "cmp" would probably do better.
Nevertheless, I think I remember that diff can at least differenciate
between identical and different binary files, so your test must still be
valid.

> So it seems to work with VT8235.

Yes, it does. Antonino A. Daplas reported success on his VT8235 in
private as well, so I am now confident that this chip is OK. The
question remains for VT82C686A and B though.

Thanks for your help!
--
Jean Delvare
