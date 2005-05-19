From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors doesn't detect voltage measurements on HP Proliant
Message-Id: <20040915140437.M36361@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
In-Reply-To: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Sep 2004 12:42:33 +0100, Jim Chen wrote
> Jean,
> 
> Thanks a lot.
> 
> Please see attached file after using i2cdump 0 0x60. Does that give any
> hint?

Well, it looks like a real chip, but the register map is really strange and
doesn't look like any hardware monitoring I know of. Could be some kind of
media chip, I can't say.

> I am struggling installing HP system inside manager at the moment. It
> takes many many steps and very easy to go wrong. I will let you know 
> the result once I get it running.

OK, thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
