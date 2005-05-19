From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 4/4 WIP I2C kernel patches-Makefile and necessary changes
Message-Id: <m28z6lbwo6.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20B62.1164BAB7@bellsouth.net>
In-Reply-To: <3CE20B62.1164BAB7@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:

 
albert> obj-$(CONFIG_I2C)              += i2c-core.o
albert> obj-$(CONFIG_I2C_CHARDEV)      += i2c-dev.o
albert> obj-$(CONFIG_I2C_ALGOBIT)      += i2c-algo-bit.o
albert> -obj-$(CONFIG_I2C_PHILIPSPAR)   += i2c-philips-par.o
albert> -obj-$(CONFIG_I2C_ELV)          += i2c-elv.o
albert> -obj-$(CONFIG_I2C_VELLEMAN)     += i2c-velleman.o
albert> +obj-$(CONFIG_I2C_BITLP)        +=      i2c-philips-par.o
albert> +obj-$(CONFIG_I2C_BITELV)       += i2c-elv.o
albert> +obj-$(CONFIG_I2C_BITVELLE)     += i2c-velleman.o
albert> obj-$(CONFIG_I2C_ALGOPCF)      += i2c-algo-pcf.o
albert> -obj-$(CONFIG_I2C_ELEKTOR)      += i2c-elektor.o
albert> +obj-$(CONFIG_I2C_PCFISA)       += i2c-elektor.o
albert> obj-$(CONFIG_ITE_I2C_ALGO)     += i2c-algo-ite.o
albert> obj-$(CONFIG_ITE_I2C_ADAP)     += i2c-adap-ite.o
albert> obj-$(CONFIG_I2C_PROC)         += i2c-proc.o

Merge this with the config.in changes.

albert> --- linux/drivers/i2c/i2c-algo-bit.c.orig       2002-05-15 00:50:12.000000000 -0400
albert> +++ linux/drivers/i2c/i2c-algo-bit.c    2002-05-15 00:55:28.000000000 -0400
albert> @@ -119,8 +119,7 @@
albert> if (start+adap->timeout <= jiffies) {
albert> return -ETIMEDOUT;
albert> }
albert> -               if (current->need_resched)
albert> -                       schedule();
albert> +               if (need_resched) schedule();
albert> }
albert> DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
albert> #ifdef SLO_IO

Better put cond_resched(), that way it works in 2.4 & 2.5.

albert> --- linux/drivers/i2c/i2c-elv.c.orig    2002-05-15 00:59:01.000000000 -0400
albert> +++ linux/drivers/i2c/i2c-elv.c 2002-05-15 00:59:30.000000000 -0400
albert> @@ -113,10 +113,12 @@
albert> return 0;
albert> }
 
albert> +#ifdef MODULE
albert> static void bit_elv_exit(void)
albert> {
albert> release_region( base , (base = 0x3bc)? 3 : 8 );
albert> }
albert> +#endif

albert> static int bit_elv_reg(struct i2c_client *client)
albert> {
albert> --- linux/drivers/i2c/i2c-velleman.c.orig       2002-05-15 01:00:52.000000000 -0400
albert> +++ linux/drivers/i2c/i2c-velleman.c    2002-05-15 01:01:20.000000000 -0400
albert> @@ -102,10 +102,12 @@
albert> return 0;
albert> }
 
albert> +#ifdef MODULE
albert> static void bit_velle_exit(void)
albert> {      
albert> release_region( base , (base = 0x3bc)? 3 : 8 );
albert> }
albert> +#endif

Marking that __exit will not be enough, instead of putting it inside
#ifdefs?

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
