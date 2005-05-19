From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: linux-2.6.7 parallel port adapter
Message-Id: <20050508143940.1de6f8a4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <427B6E12.9000008@inf.ed.ac.uk>
In-Reply-To: <427B6E12.9000008@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nils,

> using the parallel adapter (light) in 2.6.7
> 
> #CONFIG_I2C_PARPORT=y
> CONFIG_I2C_PARPORT_LIGHT is not set

These lines make little sense. I guess you really mean:
#CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
Right?

> causes a kernel panic ...
> has anyone had similar problems or is it fixed
> in later versions (i did only a quick search)?

Never had any report about this. Can't tell whether this has a chance to
be fixed in 2.6.11+ without the kernel panic data.

> using the normal parallel port adapter
> 
> CONFIG_I2C_PARPORT=y
> #CONFIG_I2C_PARPORT_LIGHT is not set
> 
> seems to work fine with sysfs but
> causes problems over /dev/i2c-0 :
> i2cdetect just takes forever to complete a run
> e.g. just the following line took 5 minutes (and isnt correct)
> 
> 20: UU UU UU UU UU UU UU UU XX XX XX XX XX XX XX XX
> 
> removing the physical adapter during the run, allows
> the program to terminate immediatly...
> 
> is that a problem with the i2c-to-parallel adapter ?

Could be that your hardware adapter uses a different wiring than you
told the driver to use. Check the "type" parameter and the i2c-parport.h
definition file. If your adapter uses a different wiring from all those
defined, you'll have to add a new type.

You should try the bit_test=1 parameter to the i2c-algo-bit module, it
will test the lines when i2c-parport(-light) is loaded so you know
whether the driver uses the correct pins or not.

Hope that helps,
-- 
Jean Delvare
