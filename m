From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710115137.6ef54f34.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > You should have /usr/local/include/linux/i2c.h. That's where i2c
> > (that you got from CVS) installs them. So, if you don't have them,
> > either you did *not* run "make install" for i2c, or you tweaked the
> > Makefile and did not tell us...
> > 
> > So, what did you really do?
> I am very sorry but I just done a fresh checkout of the cvs then make
> all and make install.
> 
> I get: installation successful!
> 
> but there is no i2c.h in /usr/local/include/linux
> 
> there is one in /usr/include/linux...
> 
> the only files I got in /usr/local/include/linux are:
> i2c-algo-bit.h  i2c-algo-biths.h  i2c-algo-pcf.h  i2c-dev.h
> 
> I did not change anything on the Makefile, also I did not forget to do
> make install.

OK, I see what's happening. You do have I2C enabled in your current
kernel, *built-in* (CONFIG_I2C=y), don't you?

INSTALL says:
Your I2C support must NOT be built-in your kernel already!
It must either be disabled or enabled as modules.

We don't prevent i2c from compiling in this case for very specific
cases, but it generally won't work, because then lm_sensors has to use
your kernel i2c headers, which are out of date.

If I'm right, you'll have to rebuild a kernel with either I2C as a
module or disabled, and then i2c and lm_sensors will install properly.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
