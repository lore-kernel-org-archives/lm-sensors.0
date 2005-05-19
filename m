From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030624033239.GD10891@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Greg KH <greg@kroah.com> [2003-06-23 16:41:14 -0700]:
> On Thu, Jun 19, 2003 at 06:45:36PM -0700, Philip Pokorny wrote:
> > The data->foo and device register need to be in sync.  So I suppose both...
> > 
> > At first I thought that if I always updated the chip first and then the 
> > data->foo cached value, I'd be OK, but it seemed like there were too 
> > many exceptions where values were broken apart, or recombined...
> > 
> > The primary thing I was trying to avoid was one CPU writing a value 
> > while another CPU was reading a value (and therefore calling 
> > update_client) and the result being that the data->foo cached value was 
> > different from actual device register.
> 
> But if that happens, then the worse thing that could happen is we would
> show "stale" data in the resulting value.

Nope - as it was originally written (before Philip's most recent patch),
we could lose the value we meant to write.

> Hm, so I can understand if we need to protect access to the hardware
> when we read two values in a row, like this:
>                 res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
>                 res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
> 
> or the same thing when writing.

Good point.  The I2C core provides I2C/SMBus locking to prevent trashing
the bus itself, but that doesn't help the above.  Which brings about
another question... why wasn't i2c_smbus_read_word_data() used in that
case?  Philip?

> But what about this simpler patch, that pushes the lock down to the
> hardware reads and writes for multiple registers.  And it doesn't try to
> mirror the write in the "data" structure, as it's always read with the
> latest values for every read.

It looks like this scheme would actually work for lm85.c  But, for most
chip drivers with fan divisors there would still be a race.  E.g. look at
set_fan_min() and set_fan_div() in lm78.c; the meaning of data->fan_min
depends on data->fan_div so those two must be coherent. That locking can't
be pushed further down.

That lm85 doesn't use fan divisors is the exception rather than the rule.
I mean, I don't hate this patch... but it doesn't tell us anything about
how to fix the rest of them.  I still think Philip's original brute force
locking ;) is necessary there.

> Does it look ok?  It has the added benefit of making the .c and .o files
> smaller :)

>  int lm85_write_value(struct i2c_client *client, u8 reg, int value)
>  {
> +	struct lm85_data *data = i2c_get_clientdata(client);
>  	int res ;
>  
> +	/* serialize access to the hardware */
> +	down(&data->update_lock);
> +
>  	switch( reg ) {
>  	case LM85_REG_FAN(0) :  /* Write WORD data */
>  	case LM85_REG_FAN(1) :
> @@ -1009,6 +1000,7 @@
>  		res = i2c_smbus_write_byte_data(client, reg, value);
>  		break ;
>  	}
> +	up(&data->update_lock);
>  
>  	return res ;
>  }

I would add "data->valid = 0;" somewhere before the up().  Then you're
guaranteed never to read stale data after a write.

> @@ -1070,8 +1062,6 @@
>  	struct lm85_data *data = i2c_get_clientdata(client);
>  	int i;
>  
> -	down(&data->update_lock);
> -
>  	if ( !data->valid ||
>  	     (jiffies - data->last_reading > LM85_DATA_INTERVAL ) ) {
>  		/* Things that change quickly */
> @@ -1209,8 +1199,6 @@
>  	};  /* last_config */
>  
>  	data->valid = 1;
> -
> -	up(&data->update_lock);
>  }

We only want to service one update_client() call per some interval.
I think this lock needs to stay.

And one last off-topic nit: data->fan_ppr is set but not used?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
