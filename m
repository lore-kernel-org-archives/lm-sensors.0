From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jun 2010 12:25:15 +0000
Subject: Re: [lm-sensors] [RFC][PATCH]Add suspend and resume for LM75
Message-Id: <20100603142515.11f29639@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0680EC522D0CC943BC586913CF3768C003B3358228@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3358228@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 3 Jun 2010 09:06:33 +0200, Jean Delvare wrote:
> On Fri, 28 May 2010 11:31:23 +0530, Datta, Shubhrajyoti wrote:
> >  static struct i2c_driver lm75_driver = {
> >  	.class		= I2C_CLASS_HWMON,
> > @@ -292,6 +325,8 @@ static struct i2c_driver lm75_driver = {
> >  	.id_table	= lm75_ids,
> >  	.detect		= lm75_detect,
> >  	.address_list	= normal_i2c,
> > +	.suspend		= lm75_suspend,
> > +	.resume		= lm75_resume,
> 
> I get the following warning:
> 
> drivers/hwmon/lm75.c:326: warning: initialization from incompatible pointer type
> drivers/hwmon/lm75.c:327: warning: initialization from incompatible pointer type
> 
> so it can't be right. Look in <linux/i2c.h>, these functions want
> struct i2c_client as a parameter, not struct device.

Oh, I just remember now... what you probably want to do is embedded the
callbacks above in lm75_driver.driver.pm. See the tmp102 driver for an
example.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
