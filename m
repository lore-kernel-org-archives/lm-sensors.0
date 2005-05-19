From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH sysfs names: fscher: remove revision
Message-Id: <20050427185509.482fc04d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <8l9t61hd63l0tkt2n3ni27sb1559i9tmn2@4ax.com>
In-Reply-To: <8l9t61hd63l0tkt2n3ni27sb1559i9tmn2@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> fscher exposes chip revision to user-space, but does not use it 
> internally, this patch removes revision filename

I am in favor of this change, with two minor objections:

1* Maybe you could add an info printk saying "fscher: Found FSC Hermes
chip, revision %d", like the it87 driver does for example. That way,
people still get to know the revision of the chip if it should ever
matter.

2*
>  static void fscher_init_client(struct i2c_client *client)
>  {
> -	struct fscher_data *data = i2c_get_clientdata(client);
>  
> -	/* Read revision from chip */
> -	data->revision =  fscher_read_value(client, FSCHER_REG_REVISION);
>  }

This function can obviously go away altogether now. Empty static
functions are not that useful.

Thanks,
-- 
Jean Delvare
