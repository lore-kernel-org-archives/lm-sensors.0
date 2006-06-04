From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 15:00:56 +0000
Subject: [lm-sensors] [PATCH] OpenCores I2C bus driver
Message-Id: <20060604170056.bf711d22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <874q0n1505.fsf@sleipner.barco.com>
In-Reply-To: <874q0n1505.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> >>>>> "Peter" = Peter Korsgaard <jacmet at sunsite.dk> writes:
> 
>  Peter> And here it is - Changes since last time:
> 
>  Peter> - Minor cleanups from Andrew Morton (2.6.17-rc3-mm1)
>  Peter> - Better handling of reserved bits as suggested by Rudolf Marek
>  Peter> - Documentation
> 
> Comments?

Sorry for the long delay. I finally took some time to (briefly) review
your code. It looks OK overall, and I've applied it with the following
changes I hope you'll approve:

* Reorder includes, asm/* must come after linux/*.
* Tag ocores_i2c_driver.remove __devexit_p().
* Tag the driver EXPERIMENTAL for now. You can send a patch later to
  remove that tag once it has spent some times in Linus' tree and is
  believed to be completely safe and operational.
* In the documentation, replace the .dev.platform_data construct in struct
  initialization, as I seem to remember not all compilers accept it.
  Also don't initialize .id to 0 as this is the default for a static
  struct.
* A few coding style adjustments.

I also have a few comments about things which looked suspicious to me,
but which I didn't dare to change:

> /* registers */
> #define OCI2C_PRELOW		0
> #define OCI2C_PREHIGH		1
> #define OCI2C_CONTROL		2
> #define OCI2C_DATA		3
> #define OCI2C_CMD		4
> #define OCI2C_STATUS		4

Two registers with the same number? If it's true this deserves a
comment, methinks.

> static struct i2c_adapter ocores_adapter = {
> 	.owner		= THIS_MODULE,
> 	.name		= "i2c-ocores",
> 	.class		= I2C_CLASS_HWMON,
> 	.algo		= &ocores_algorithm,
> 	.timeout	= 2,
> 	.retries	= 1,
> };

Why define .timeout and .retries if you don't use them in your driver?

If you want to change that (or anything else for that matter) please
send an incremental patch. The patch as I applied it for now is
(temporarily) available here:
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-opencores-new-driver.patch

Last, I would like you to become the maintainer for this new driver if
you feel like it. If you accept, please send a patch to MAINTAINERS and
I'll apply it.

Thanks,
-- 
Jean Delvare

