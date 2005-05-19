From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: lm78 ok on isa but not on i2c
Message-Id: <20040311031109.GA5845@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202225309.74d555b0.khali@linux-fr.org>
In-Reply-To: <20031202225309.74d555b0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Months ago...

* Jean Delvare <khali@linux-fr.org> [2003-12-02 22:53:09 +0100]:

> As I was testing lm_sensors on my old Pentium 200 system, I noticed that
> also sensors-detect sees my LM78 chip on both the i2c bus (at 0x2d) and
> isa bus (at 0x290), the lm78 driver itself won't detect the chip on the
> i2c bus (i2c-piix4 for that matter). It will only work if I load
> i2c-isa.
> 
> Same behavior tested with CVS, 2.8.1, 2.7.0 and 2.6.1. Am I missing
> something or does it need to be investigated and fixed?

I just picked up an ancient Tyan board with a LM79 and a pair of
LM75s.  (Perhaps hard to believe, but they're there.)  All are
connected to the SMBus.  CVS lm_sensors works fine on it.

My other board w/ LM78 was ISA only, otherwise I would have
responded last year. ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
