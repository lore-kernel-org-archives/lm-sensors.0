From: kmalkki@cc.hut.fi (Kyosti Malkki)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: penguin on i2c bus after motherboard change (PCTVpro,with msp34xx)
Message-Id: <Pine.OSF.4.50.0211251007410.4255-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 24 Nov 2002, Kyosti Malkki wrote:

> A minor patch for algo-bit was applied 2002/07/03, changing SCL
> behaviour, but I think it is not relevant here.

More info:

Chapter 5 "I2C Bus Interface" of MSP34x0D datasheet describes conditions
when SCL is held low to allow time for internal processing.

In I2C revisions prior to 2.6.4, i2c-algo-bit did not check SCL low when
sending " Repeating Start ". This bus condition is used when master
writes to client to select register, and then gets the content.
Call to msp3400c_read() does just that.

Patch only replaces setscl(adap,1) with sclhi(adap) in
drivers/i2c/i2c-algo-bit.c, i2c_repstart(), line 147.


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
