From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 18 May 2011 16:12:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] staging:iio:adc: as1531 driver initial
Message-Id: <4DD3EFE3.9070201@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD26311.7070905@armadeus.com> <1305733172-18519-2-git-send-email-jic23@cam.ac.uk> <20110518160202.GC11280@ericsson.com>
In-Reply-To: <20110518160202.GC11280@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, fabien.marteau@armadeus.com, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On 05/18/11 17:02, Guenter Roeck wrote:
> On Wed, May 18, 2011 at 11:39:31AM -0400, Jonathan Cameron wrote:
>> From: Fabien Marteau <fabien.marteau-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
>>
>> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> 
> Hi Jonathan,
> 
> nice job. Thanks a lot for the effort.
> 
> [ ... ]
> 
>> +static int as1531_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val,
>> +			   int *val2,
>> +			   long m)
>> +{
>> +
> Extra blank line
> 
>> +	int status = 0;
>> +	int ret_value = 0;
>> +	struct as1531_state *st = iio_priv(indio_dev);
> 
> Move it to here, maybe ?
> 
>> +	if (mutex_lock_interruptible(&st->lock))
>> +		return -ERESTARTSYS;
>> +
>> +	status = as1531_message(st->spi,
>> +				AS1531_START_BIT | chan->address |
>> +				AS1531_RANGE_0_TO_VREF | AS1531_MODE_COM |
>> +				AS1531_POWER_NORMAL,
>> +				&ret_value);
>> +	mutex_unlock(&st->lock);
>> +	if (status < 0)
>> +		goto out;
>> +	
>> +	*val = ret_value*2500/4096;
>> +
>> +	return IIO_VAL_INT;
>> +out:
>> +	mutex_unlock(&st->lock);
> 
> Mutex was unlocked above already. Maybe just return status above ?
Hmm.. Sometimes working without testing shows just how bad first versions
of code really can be ;)

Thanks for the other review as well.  Have fixed up both.


Thanks.

Jonathan 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
