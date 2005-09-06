From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 22:20:32 +0000
Subject: [lm-sensors] [PATCH 2.6.13-mm1] i2c: bug fix for
Message-Id: <20050906222025.342d6d62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050902010549.GD10106@mag.az.mvista.com>
In-Reply-To: <20050902010549.GD10106@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> >  mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >  int num) {
> >  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> > -	int	i, rc = 0;
> > +	int	i, rc;
> >  
> >  	for (i=0; i<num; i++)
> > -		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
> > -			break;
> > +		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) < 0)
> > +			return rc;
> >  
> > -	return rc;
> > +	return num;
> >  }
> 
> Agreed.  However, I think we still need to init 'rc' to 0 in case
> 'num' is ever 0 to prevent random data from being returned.

If num is 0, the for loop is never entered and num, not rc, is returned.
Thus I don't see why initializing rc to 0 would be needed. Or am I
missing something obvious?

-- 
Jean Delvare
