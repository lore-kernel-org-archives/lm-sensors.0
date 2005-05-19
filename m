From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH 2.6] new sensors driver: SMSC LPC47B397-NC
Message-Id: <20050103205854.6dea89f4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050102212924.GB17759@jupiter.solarsys.private>
In-Reply-To: <20050102212924.GB17759@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

See my comments inline.

> Signed-off-by: Craig Kelly <ckelly at ibnads d0t com>
> Signed-off-by: Glenn Ball <glenn_ball at utilitek d0t com>

Hm. Greg won't like that, you know ;) (Nor do I for that matter. It's
not the f4r w3st here! ;))

> --- linux-2.6.10-mmh.orig/Documentation/i2c/chips/smsc47b397.txt	2004-12-29 05:08:59.698570592 -0500
> +++ linux-2.6.10-mmh/Documentation/i2c/chips/smsc47b397.txt	2004-12-26 20:48:26.000000000 -0500
> @@ -0,0 +1,128 @@
> +November 23, 2004
> +
> +The following specification describes the SMSC LPC47B397-NC sensor
> chip +(for which there is no public datasheet available).  This
> document was +provided by Craig Kelly (In-Store Broadcast Network) and
> edited/corrected +by Mark M. Hoffman <mhoffman@lightlink.com>.
> (...)

I think that this document should be better formated (i.e. lines should
be cut before column 80 when they are too long).

> --- linux-2.6.10-mmh.orig/drivers/i2c/chips/Kconfig	2004-12-26 19:39:51.000000000 -0500
> +++ linux-2.6.10-mmh/drivers/i2c/chips/Kconfig	2004-12-26 20:48:26.000000000 -0500
> @@ -252,6 +252,18 @@ config SENSORS_SMSC47M1
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called smsc47m1.
>  
> +config SENSORS_SMSC47B397
> +	tristate "SMSC LPC47B397-NC

Missing closing quotation mark.

> --- linux-2.6.10-mmh.orig/drivers/i2c/chips/Makefile	2004-12-26 19:39:51.000000000 -0500
> +++ linux-2.6.10-mmh/drivers/i2c/chips/Makefile	2004-12-26 20:48:26.000000000 -0500
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>  obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
>  obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
> +obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
>  obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o

Hm, alphabetical order?

> --- linux-2.6.10-mmh.orig/drivers/i2c/chips/smsc47b397.c	2004-12-29 05:08:59.698570592 -0500
> +++ linux-2.6.10-mmh/drivers/i2c/chips/smsc47b397.c	2004-12-26 20:48:26.000000000 -0500
> (...)
> +/* 0 <= nr <= 3 */
> +#define SMSC47B397_REG_FAN_LSB(nr) (0x28 + 2 * nr)
> +#define SMSC47B397_REG_FAN_MSB(nr) (0x29 + 2 * nr)

Additional parentheses around "nr" please.

> +static struct smsc47b397_data *smsc47b397_update_device(struct device *dev)
> (...)
> +	if (time_after(jiffies - data->last_updated, (unsigned long)(HZ+HZ/2))

Where do you get the 1.5 second from? Seems much to me for such a simple
device, especially since it has an ISA access. I would hope 1 second is
enough.

> +	if (!request_region(addr, SMSC_EXTENT, "smsc47b397")) {
> +		dev_err(&adapter->dev, "Region 0x%x already in use!\n",addr);
> +		return -EBUSY;
> +	}

I have sent a patch recently, which make all drivers request their
region using *_driver.name instead of duplicating the name string:
http://archives.andrew.net.au/lm-sensors/msg28657.html

Care to do the same for this driver?

While you're at it, missing space before last comma.

> +static int __init smsc47b397_init(void)
> +{
> +	if (smsc47b397_find(normal_isa)) {
> +		return -ENODEV;
> +	}

You could instead propagate the error code returned by smsc47b397_find.

Other than that, I'm fine with this driver. Nice work :)

Additional question:
This driver uses logical device 8, while sensors-detect probes device
0x0a. Is this a bug in sensors-detect?

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
