From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 18 May 2011 16:35:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] staging:iio:adc:as1351 general cleanup
Message-Id: <20110518163508.GA11675@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk>
 <1305735420-23293-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305735420-23293-3-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "fabien.marteau@armadeus.com" <fabien.marteau@armadeus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, May 18, 2011 at 12:17:00PM -0400, Jonathan Cameron wrote:
> V2: Fix the precedence issue Guenter Roeck pointed out.
> 
Should be below ---, unless you want it in the commit log.

> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Nitpick below, otherwise

Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  drivers/staging/iio/adc/as1531.c |   59 +++++--------------------------------
>  1 files changed, 8 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/as1531.c b/drivers/staging/iio/adc/as1531.c
> index 1724c39..24a1ac0 100644
> --- a/drivers/staging/iio/adc/as1531.c
> +++ b/drivers/staging/iio/adc/as1531.c
> @@ -58,47 +58,6 @@ struct as1531_state {
>  	struct mutex lock;
>  };
>  
> -static int as1531_message(struct spi_device *spi, int cmd, int *ret_value)
> -{
> -	struct spi_message	message;
> -	struct spi_transfer	x[1];
> -	int status, i;
> -	u8	cmd_send;
> -	unsigned char buf[64];
> -	unsigned char buf_read[64];
> -
> -	cmd_send = cmd;
> -
> -	spi_message_init(&message);
> -	memset(x, 0, sizeof x);
> -	memset(buf, 0, sizeof(buf));
> -	memset(buf_read, 0, sizeof(buf_read));
> -
> -	for (i = 0; i < 8; i++) {
> -		buf[i] = ((cmd_send & 0x80)>>7);
> -		cmd_send = cmd_send << 1;
> -	}
> -
> -	x[0].tx_buf = buf;
> -	x[0].len = 24;
> -	x[0].rx_buf = buf_read;
> -	x[0].speed_hz = AS1531_SPI_SPEED;
> -	x[0].bits_per_word = 1;
> -	spi_message_add_tail(&x[0], &message);
> -
> -	status = spi_sync(spi, &message);
> -	if (status < 0)
> -		return status;
> -
> -	*ret_value = buf_read[11] & 0x01;
> -	for (i = 12; i < 23 ; i++) {
> -		*ret_value = *ret_value << 1;
> -		*ret_value = *ret_value | (buf_read[i]&0x01);
> -	}
> -
> -	return 0;
> -}
> -
>  static int as1531_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val,
> @@ -106,22 +65,22 @@ static int as1531_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	int status = 0;
> -	int ret_value = 0;
> +	u16 ret_value = 0;
>  	struct as1531_state *st = iio_priv(indio_dev);
>  
>  	if (mutex_lock_interruptible(&st->lock))
>  		return -ERESTARTSYS;
>  
> -	status = as1531_message(st->spi,
> -				AS1531_START_BIT | chan->address |
> -				AS1531_RANGE_0_TO_VREF | AS1531_MODE_COM |
> -				AS1531_POWER_NORMAL,
> -				&ret_value);
> +	status = spi_w8r16(st->spi,
> +			   AS1531_START_BIT | chan->address |
> +			   AS1531_RANGE_0_TO_VREF | AS1531_MODE_COM |
> +			   AS1531_POWER_NORMAL);
>  	mutex_unlock(&st->lock);
>  	if (status < 0)
>  		return status;
>  
> -	*val = ret_value*2500/4096;
> +	ret_value = status;
> +	*val = ((be16_to_cpu(ret_value) >> 2) & 0xFFF)*2500/4096;
>  
Even though checkpatch doesn't complain anymore (why ?), the rule to put spaces
around * and / still applies:

Use one space around (on each side of) most binary and ternary operators,
such as any of these:

        =  +  -  <  >  *  /  %  |  &  ^  <=  >=  =  !=  ?  :

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
