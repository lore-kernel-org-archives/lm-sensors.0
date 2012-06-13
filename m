From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Jun 2012 20:41:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc2103) Fix use of an uninitilized variable in error case
Message-Id: <20120613204120.GA13815@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338825228-29311-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338825228-29311-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 13, 2012 at 05:57:37PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon,  4 Jun 2012 08:53:48 -0700, Guenter Roeck wrote:
> > Fix:
> > 
> > emc2103.c: In function set_pwm_enable:
> > emc2103.c:463:12: warning: conf_reg may be used uninitialized in this function
> > 
> > by checking the return value from read_u8_from_i2c(). This fixes a real problem,
> > as conf_reg is really uninitialized if read_u8_from_i2c returns an error.
> > 
> > Cc: Steve Glendinning <steve.glendinning@smsc.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/emc2103.c |   12 ++++++++----
> >  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> Good catch. Still I'm a little worried about...
> 
thanks to those modern compilers ...

> > 
> > diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
> > index 9691f66..ff68563 100644
> > --- a/drivers/hwmon/emc2103.c
> > +++ b/drivers/hwmon/emc2103.c
> > @@ -451,11 +451,13 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
> >  		data->fan_rpm_control = true;
> >  		break;
> >  	default:
> > -		mutex_unlock(&data->update_lock);
> > -		return -EINVAL;
> > +		result = -EINVAL;
> > +		goto err;
> >  	}
> >  
> > -	read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
> > +	result = read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
> > +	if (result)
> > +		goto err;
> >  
> >  	if (data->fan_rpm_control)
> >  		conf_reg |= 0x80;
> > @@ -464,8 +466,10 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
> >  
> >  	i2c_smbus_write_byte_data(client, REG_FAN_CONF1, conf_reg);
> >  
> > +	result = count;
> 
> ... this. Is it guaranteed that sizeof(int) >= sizeof(size_t)? Probably
> it doesn't matter much in practice, but I'm still wondering. I think I
> would prefer if you'd return "count" and stuff error codes in it when
> needed, rather than returning "result".
> 
> But you can also just ignore me if you think it's irrelevant. Both
> cases, you have my ack.
> 
Hi Jean,

good point. sizeof(size_t) _can_ be larger than sizeof(int), and often is.
Sure, it doesn't matter much in practice, as count is hopefully never that large,
but it is better to be careful. I changed the code as you suggested, ie return count
and assign the error code to it if needed.

Thanks a lot for the review.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
