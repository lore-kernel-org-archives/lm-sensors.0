From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <20031101170944.386fd941.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	i2c-algo-bit.c 
> Log Message:
> (Khali) Fix sclhi() for adapters that do not have getscl().
>         Enable bit_test for adapters that do not have getscl().
>         Mostly rewrite test_bus(), cleaner and probably faster.

I'd like reviewers and testers on this, since I plan to submit a similar
for Linux 2.6. There are two distinct changes:

1* Fixed sclhi() for adapters that do not have getscl(). It looks like
there was a udelay call missing in this case.

2* Rewrote test_bus() almost entirely, to allow adapters without
getscl() to be tested. It's still interesting to test SDA in this case.

I have a pair of questions with regard to i2c-algo-bit:

1* I don't understand how the whole thing works. Each of sdalo(),
sdahi(), scllo() and sclhi() are waiting adap->udelay before returning.
How in this condition can the driver change both SCL and SDA values in a
row?

2* It looks like i2c-algo-bit assumes that both SDA and SCL are high by
the time it is called. Why that? Looks like not all drivers will do so.
Especially, I tried my changes using i2c-matroxfb and it looks like this
driver doesn't set SDA not SCL before registering with i2c-algo-bit,
causing bit_test to sometimes fail with the message "seems to be busy".
I wonder if it wouldn't be easier (and safer) not to assume anything
about SDA and SCL in i2c-algo-bit.c:test_bus() (that is, remove that
"may be busy" test).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
