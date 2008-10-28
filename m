From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Date: Tue, 28 Oct 2008 08:04:24 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <1225180344.15167.48.camel@kaiwan-1>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Got a chance to test this patch today..
short answer: no it did not seem to work.

I got readings with largish negative values (from /sys/.../temp1_input);
have not really had the time to debug this..

[Sorry have not pasted o/p here becoz i do the work on an office PC,
where i built the 2.6.28-rc2 kernel & tried this; a bit misconfigured so
graphics did not come up (hence no clipboard stuff)...
Also, am writing this email off my notebook where i can't test the
device as it has no parport.]

Of course, in the first place, that's why the logic is the way it is.
I can (re)confirm though that for the LM70 chip the temperature register
is sent MSB first...

Let me know,

-kaiwan.

On Fri, 2008-10-24 at 02:21 -0700, David Brownell wrote:

> I suspect the following should do the job ... it has
> the parport based adapter leave the data in MSB-first
> byte order, with the lm70 driver converting to CPU
> byte order.  (In a way that will match the TMP121/123
> support.)
> 
> - Dave
> 
> ---
>  drivers/hwmon/lm70.c      |    4 +++-
>  drivers/spi/spi_lm70llp.c |   19 +++----------------
>  2 files changed, 6 insertions(+), 17 deletions(-)
> 
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -67,7 +67,7 @@ static ssize_t lm70_sense_temp(struct de
>  	}
>  	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
>  
> -	raw = (rxbuf[1] << 8) + rxbuf[0];
> +	raw = (rxbuf[0] << 8) + rxbuf[1];
>  	dev_dbg(dev, "raw=0x%x\n", raw);
>  
>  	/*
> @@ -109,6 +109,8 @@ static int __devinit lm70_probe(struct s
>  	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
>  		return -EINVAL;
>  
> +	/* NOTE:  we assume 8-bit words, and convert to 16 bits manually */
> +
>  	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
>  	if (!p_lm70)
>  		return -ENOMEM;
> --- a/drivers/spi/spi_lm70llp.c
> +++ b/drivers/spi/spi_lm70llp.c
> @@ -173,6 +173,8 @@ static void lm70_chipselect(struct spi_d
>  {
>  	struct spi_lm70llp *pp = spidev_to_pp(spi);
>  
> +	/* REVISIT initialize the clock polarity ... */
> +
>  	if (value)
>  		assertCS(pp);
>  	else
> @@ -184,22 +186,7 @@ static void lm70_chipselect(struct spi_d
>   */
>  static u32 lm70_txrx(struct spi_device *spi, unsigned nsecs, u32 word, u8 bits)
>  {
> -	static u32 sio=0;
> -	static int first_time=1;
> -
> -	/* First time: perform SPI bitbang and return the LSB of
> -	 * the result of the SPI call.
> -	 */
> -	if (first_time) {
> -		sio = bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
> -		first_time=0;
> -		return (sio & 0x00ff);
> -	}
> -	/* Return the MSB of the result of the SPI call */
> -	else {
> -		first_time=1;
> -		return (sio >> 8);
> -	}
> +	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
>  }
>  
>  static void spi_lm70llp_attach(struct parport *p)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
