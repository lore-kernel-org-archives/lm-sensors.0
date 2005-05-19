From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: included files in asb100 driver
Message-Id: <cc8q9FUJ.1106644489.4407560.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

Any reson why asb100.c (in linux 2.6.11-rc2) includes linux/ioport.h and
asm/io.h? As an i2c-only chip driver, I don't think it needs these.

As a side note, I also wonder what the inclusions of linux/config.h,
linux/types.h and asm/errno.h are there for.

Thanks,
--
Jean Delvare
