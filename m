From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710091255.444264b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I followed your advice and compiled again with the CVS-Version, both
> i2c and lm-sensors.
> 
> Before I done make I done cvs update -d
> 
> i2c goes grest but lm-sensors gives me:
> 
> kernel/busses/i2c-nforce2.c: In function `nforce2_access':
> kernel/busses/i2c-nforce2.c:154: `I2C_CLIENT_PEC' undeclared (first
> use in this function) kernel/busses/i2c-nforce2.c:154: (Each
> undeclared identifier is reported only once
> kernel/busses/i2c-nforce2.c:154: for each function it appears in.)
> (...)

CVS is known to compile great, so you must have done a mistake
somewhere, or your system is special (or broken).

Remember you have to *install* i2c before trying to *compile*
lm_sensors2. I would do a fresh CVS checkout and reinstall everything
from scratch, just to make sure no file was accidentally modified in
your local directories.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
