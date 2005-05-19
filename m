From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: vt8231 and kernel 2.6.2 on RH 9
Message-Id: <1076597385.402b92896ff54@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040212140756.48144.qmail@web40104.mail.yahoo.com>
In-Reply-To: <20040212140756.48144.qmail@web40104.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the mailing list, not to me.]

Quoting Weijia Tao <taoweijia@yahoo.com>:

> thanks fellows for your reply for my ticket 1575.
> however, i am confused, on your supported driver,
> vt8231 is listed and it says it supports linux 2.5.x
> does it mean that this vt8231 does not work on 2.6.2?
> the sensors-detect successfully detects vt8231 why it
> doesn't load it?

You mix two different things here. The VT8231 is (or more precisely,
contains) an i2c *bus*, which is handled by the i2c-viapro driver in
both 2.4 and 2.6 kernels. The VT1211 is a monitoring chipset and is
handled by the vt1211 driver in 2.4. It hasn't been ported to 2.6 yet.

You never need both drivers on a given system. Either you need
i2c-viapro + a i2c chip driver, or i2c-isa + vt1211. Use sensors-detect
to know which combination is needed on your system.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
