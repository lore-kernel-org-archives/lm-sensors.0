From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 Nov 2007 09:28:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (gl518sm) Refactor fan functions
Message-Id: <20071126102800.7b84f3a4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071022174642.3c3ce8f0@hyperion.delvare>
In-Reply-To: <20071022174642.3c3ce8f0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Herbert,

On Sun, 25 Nov 2007 15:29:43 +0100, Herbert Valerio Riedel wrote:
> On Sun, 2007-11-25 at 14:08 +0100, Jean Delvare wrote:
> > +static ssize_t show_fan_input(struct device *dev,
> > +			      struct device_attribute *attr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct gl518_data *data = gl518_update_device(dev);
> > +	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_in[nr],
> > +					DIV_FROM_REG(data->fan_div[nr])));
> > +}
> > +
> > +static ssize_t show_fan_min(struct device *dev,
> > +			    struct device_attribute *attr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct gl518_data *data = gl518_update_device(dev);
> > +	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
> > +					DIV_FROM_REG(data->fan_div[nr])));
> > +}
> 
> one thing just sprang to my mind... is it safe to assume that the
> expressions data->fan_min[nr] and data->fan_div[nr] are evaluated
> atomically? or to put it differently, why don't we need a rw-lock here
> to protect against interleaved updates?

This is a very good question. We always assumed that reading from the
register cache did not require to hold the lock. However for this to be
true on all architectures, I guess that we should be declaring all the
register values with type atomic_t. So you're probably right, our code
is probably not safe on some architectures.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
