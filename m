From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710104623.7867d84b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Let's see. Please locate *all* "i2c.h" files that are present on
> > your system. Either do:
> >   dbupdate
> >   locate i2c.h
> > or:
> >   find / -name "i2c.h"
> 
> gives me:
> /usr/src/l/linux/linux-2.4.20/arch/cris/drivers/i2c.h
> /usr/src/l/linux/linux-2.4.20/include/linux/i2c.h
> /usr/src/l/linux/linux-2.4.20/include/config/i2c.h
> /usr/src/modules/i2c/kernel/i2c.h
> /usr/include/linux/i2c.h

You should have /usr/local/include/linux/i2c.h. That's where i2c (that
you got from CVS) installs them. So, if you don't have them, either you
did *not* run "make install" for i2c, or you tweaked the Makefile and
did not tell us...

So, what did you really do?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
