From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: via686a on I2C
Message-Id: <1077546551.403a0e37a215a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040217230608.31c66662.khali@linux-fr.org>
In-Reply-To: <20040217230608.31c66662.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mark Studebaker <mds4@verizon.net>:

> one problem with adding i2c support to via686a in 2.6 is that it's a
> PCI module so you'd still have the driver conflict problem.
>
> You'd have to delay PCI module registration, or else do a separate
> driver.

You're right, but don't we want to solve that conflict anyway? It was
working with Linux 2.4, so I can't get why it couldn't work with 2.6.
Isn't it as simple as only reserving the region we need instead of
registering the device? 

> Where is the i2c address for the via686a set?
> couldn't find it in the docs.

Correct, that's not in the docs, but I suspect that it is at 0x48. I
could verify that with two users (value 0x2d, which was the i2c address
for them). On my via686a (unused and not on i2c) the value in register
0x48 is 0x00, so this makes sense.

Strangely however, when accessing the chip through i2c, the value at
0x48 is *not* the same (contrary to winbond Chips for example). It was
0xad for both user reports, if I remember correctly.

I plan to update sensors-detect soon so that it can detect the i2c
via686a. That said, it doesn't look like something really easy to
detect (no chip nor manufacturer IDs).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
