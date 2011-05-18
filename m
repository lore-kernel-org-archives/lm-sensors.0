From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 18 May 2011 15:57:52 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] staging:iio:adc:as1351 general cleanup
Message-Id: <20110518155752.GB11280@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD26311.7070905@armadeus.com>
 <1305733172-18519-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305733172-18519-3-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "fabien.marteau@armadeus.com" <fabien.marteau@armadeus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Jonathan,

On Wed, May 18, 2011 at 11:39:32AM -0400, Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/as1531.c |   60 +++++--------------------------------
>  1 files changed, 8 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/as1531.c b/drivers/staging/iio/adc/as1531.c
> index 7222549..30119ce 100644
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
> @@ -107,21 +66,20 @@ static int as1531_read_raw(struct iio_dev *indio_dev,
>  {
>  
>  	int status = 0;
> -	int ret_value = 0;
> +	u16 ret_value = 0;
>  	struct as1531_state *st = iio_priv(indio_dev);
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
>  		goto out;
> -	
> -	*val = ret_value*2500/4096;
> +	ret_value = status;
> +	*val = (be16_to_cpu(ret_value) >>2)&0xFFF*2500/4096;

checkpatch does complain about this one ... oddly enough, though, only about the missing space
between >> and 2.

& has lower precedence than * and /, so I am not sure if the code here does
what you expect it to do.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
