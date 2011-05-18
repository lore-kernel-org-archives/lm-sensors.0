From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 18 May 2011 16:02:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] staging:iio:adc: as1531 driver initial
Message-Id: <20110518160202.GC11280@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD26311.7070905@armadeus.com>
 <1305733172-18519-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305733172-18519-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "fabien.marteau@armadeus.com" <fabien.marteau@armadeus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, May 18, 2011 at 11:39:31AM -0400, Jonathan Cameron wrote:
> From: Fabien Marteau <fabien.marteau@armadeus.com>
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Hi Jonathan,

nice job. Thanks a lot for the effort.

[ ... ]

> +static int as1531_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
> +{
> +
Extra blank line

> +	int status = 0;
> +	int ret_value = 0;
> +	struct as1531_state *st = iio_priv(indio_dev);

Move it to here, maybe ?

> +	if (mutex_lock_interruptible(&st->lock))
> +		return -ERESTARTSYS;
> +
> +	status = as1531_message(st->spi,
> +				AS1531_START_BIT | chan->address |
> +				AS1531_RANGE_0_TO_VREF | AS1531_MODE_COM |
> +				AS1531_POWER_NORMAL,
> +				&ret_value);
> +	mutex_unlock(&st->lock);
> +	if (status < 0)
> +		goto out;
> +	
> +	*val = ret_value*2500/4096;
> +
> +	return IIO_VAL_INT;
> +out:
> +	mutex_unlock(&st->lock);

Mutex was unlocked above already. Maybe just return status above ?

Thanks,
Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
