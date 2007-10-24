From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 21:39:34 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: Fix NACK detection in i2c-pasemi
Message-Id: <20071024233934.2ba9c9fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071024155917.GA25312@lixom.net>
In-Reply-To: <20071024155917.GA25312@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olof,

On Wed, 24 Oct 2007 10:59:17 -0500, Olof Johansson wrote:
> i2c: Fix NACK detection in i2c-pasemi
> 
> Turns out we don't actually check the status to see if there was a
> device out there to talk to, just if we had a timeout when doing so.
> 
> Add the proper check, so we don't falsly think there are devices
> on the bus that are not there, etc.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> On Wed, Oct 24, 2007 at 01:51:09PM +0200, Jean Delvare wrote:
> 
> > The question is, how do you manage to get that many errors reported,
> > when I don't get any when loading the lm90 driver, despite the 6 I2C
> > buses on my system. When you reach this point in the lm90 driver, it
> > means that i2c-core successfully probed that there was a device at said
> > address on the given bus. I have a hard time believing that you have
> > chips at 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d and 0x4e on 3
> > different I2C buses on your system.
> > 
> > It sounds like the underlying bus driver is broken and report chips
> > where they aren't. What are these I2C buses? Their driver(s) needs
> > fixing.
> 
> Crap, yeah, you're right. This was the only driver behaving this way
> for me, and I didn't have another controller to test on.
> 
> The bug is indeed in our bus driver, we don't check for NACK's, only
> timeouts (I was of the impresison that a nack would cause a timeout,
> but that's obviously wrong).
> 
> Patch below. Thanks a bunch!
> 
> 
> -Olof
> 
> 
> diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
> index 58e3271..a1d339e 100644
> --- a/drivers/i2c/busses/i2c-pasemi.c
> +++ b/drivers/i2c/busses/i2c-pasemi.c
> @@ -51,6 +51,7 @@ struct pasemi_smbus {
>  #define MRXFIFO_DATA_M	0x000000ff
>  
>  #define SMSTA_XEN	0x08000000
> +#define SMSTA_MTN	0x00200000
>  
>  #define CTL_MRR		0x00000400
>  #define CTL_MTR		0x00000200
> @@ -98,6 +99,10 @@ static unsigned int pasemi_smb_waitready(struct pasemi_smbus *smbus)
>  		status = reg_read(smbus, REG_SMSTA);
>  	}
>  
> +	/* Got NACK? */
> +	if (status & SMSTA_MTN)
> +		return -ENODEV;

What does the SMSTA_MTN bit mean exactly? If it is raised by any NACK,
then it doesn't necessarily mean "no device". It can also mean that the
slave didn't like the transaction for any reason. In this case -ENODEV
is too specific and you should instead return -ENXIO or maybe -EINVAL.

It's up to i2c-core to convert the error code to -ENODEV if it happens
during device probing.

> +
>  	if (timeout < 0) {
>  		dev_warn(&smbus->dev->dev, "Timeout, status 0x%08x\n", status);
>  		reg_write(smbus, REG_SMSTA, status);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
