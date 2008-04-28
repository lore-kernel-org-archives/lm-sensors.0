From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Apr 2008 11:17:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7473) Initialize
Message-Id: <20080428131758.75d0e578@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080426163426.7684ce5d@hyperion.delvare>
In-Reply-To: <20080426163426.7684ce5d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paulius,

Thanks for the review.

On Mon, 28 Apr 2008 11:31:22 +0300, Paulius Zaleckas wrote:
> Jean Delvare wrote:
> > --- linux-2.6.26-rc0.orig/drivers/hwmon/adt7473.c	2008-04-26 15:36:41.000000000 +0200
> > +++ linux-2.6.26-rc0/drivers/hwmon/adt7473.c	2008-04-26 16:15:05.000000000 +0200
> > @@ -298,6 +298,9 @@ no_sensor_update:
> >  						ADT7473_REG_PWM_BHVR(i));
> >  	}
> >  
> > +	i = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG4);
> > +	data->max_duty_at_overheat = !!(i & ADT7473_CFG4_MAX_DUTY_AT_OVT);
> 
> Maybe it would be more understandable to use:
> data->max_duty_at_overheat = (i & ADT7473_CFG4_MAX_DUTY_AT_OVT) ? 1 : 0;

The !! construct seems to be widely used in the kernel, I found 800
occurrences, so I guess it's OK to use it here. But if Darrick (as the
driver author) or Mark (as the subsystem maintainer) prefer your
variant, I can update the patch.

> Although I don't know if gcc optimizes both to the same instructions.

It seems so, yes (gcc 4.1.2).

> 
> > +
> >  	data->limits_last_updated = local_jiffies;
> >  	data->limits_valid = 1;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
