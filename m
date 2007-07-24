From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jul 2007 13:09:57 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070724150957.3752afb6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Jul 2007 14:57:53 +0200, Christian Hohnstaedt wrote:
> On Tue, Jul 24, 2007 at 02:06:04PM +0200, Jean Delvare wrote:
> > On Tue, 24 Jul 2007 11:35:37 +0200, Christian Hohnstaedt wrote:
> > > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > > index a40166f..4fa3220 100644
> > > --- a/drivers/hwmon/lm75.c
> > > +++ b/drivers/hwmon/lm75.c
> > > @@ -95,7 +95,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > >  	struct lm75_data *data = i2c_get_clientdata(client);
> > >  	int nr = attr->index;
> > > -	unsigned long temp = simple_strtoul(buf, NULL, 10);
> > > +	int temp = simple_strtol(buf, NULL, 10);
> > >  
> > >  	mutex_lock(&data->update_lock);
> > >  	data->temp[nr] = LM75_TEMP_TO_REG(temp);
> > 
> > temp should be a long rather than an int. Otherwise the input value
> > might wrap before LM75_TEMP_TO_REG has a chance to clamp it.
> 
> Since LM75_TEMP_TO_REG() expects an int, I thought it would be best
> to make temp an int here, to reduce confusion.

Good point. But what this means then is that LM75_TEMP_TO_REG() should
take a long as a parameter rather than an int.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
