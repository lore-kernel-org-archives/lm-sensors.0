From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Jun 2013 11:41:28 +0000
Subject: Re: [lm-sensors] [lm-sensors 2/2] hwmon: (ds1621) Add ds1721 update interval sysfs attribute
Message-Id: <20130606114128.GD5834@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-3-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-3-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 06, 2013 at 09:48:11AM +0200, Jean Delvare wrote:
> Hi Robert, hi Guenter,
> 
> Sorry for joining the game a little late...
> 
> On Wed, 8 May 2013 22:45:54 -0700, Robert Coulson wrote:
> > +static umode_t ds1621_attribute_visible(struct kobject *kobj,
> > +					struct attribute *attr, int index)
> > +{
> > +	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct ds1621_data *data = i2c_get_clientdata(client);
> > +	struct device_attribute *devattr;
> > +
> > +	devattr = container_of(attr, struct device_attribute, attr);
> > +	if (attr = &dev_attr_update_interval.attr)
> > +		if (data->kind != ds1721)
> > +			/* shhh, we're hiding update_interval */
> > +			return 0;
> > +	return attr->mode;
> > +}
> 
> "make W=1" complains that devattr is defined but never used. And this is
> true, and should be fixed.
> 
I'll take care of it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
