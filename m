From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030619063004.GA1885@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 18, 2003 at 10:25:57PM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2003-06-18 11:25:07 -0700]:
> > ChangeSet 1.1318.3.2, 2003/06/16 11:31:43-07:00, margitsw@t-online.de
> > 
> > [PATCH] I2C: lm85 fixups
> > 
> > OK Here's the patch which :
> > 1) Fixes the race conditions
> 
> <cut>
> 
> > @@ -437,10 +434,13 @@
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> >  	struct lm85_data *data = i2c_get_clientdata(client);
> > +	int	val;
> >  
> > -	int val = simple_strtol(buf, NULL, 10);
> > +	down(&data->update_lock);
> > +	val = simple_strtol(buf, NULL, 10);
> >  	data->fan_min[nr] = FAN_TO_REG(val);
> >  	lm85_write_value(client, LM85_REG_FAN_MIN(nr), data->fan_min[nr]);
> > +	up(&data->update_lock);
> >  	return count;
> >  }
> 
> Ugh.  Looks like this sort of fix is needed in every single chip
> driver in 2.5.  And the CVS chip drivers have the same problem.

Hm, wait, what are we trying to protect with this lock?  The data->
values?  Or access to the hardware?  Or something else?

thanks,

greg k-h
