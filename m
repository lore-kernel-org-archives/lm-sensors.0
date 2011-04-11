From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Mon, 11 Apr 2011 18:40:04 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (sht15) add support for the
Message-Id: <1302545729-sup-8957@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302198246-22212-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302198246-22212-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Excerpts from Guenter Roeck's message of 2011-04-08 10:28:11 -0400:
> Overall very nice cleanup. Couple of comments below.
> 
> On a high level: Since the driver can now turn on the heater, and the heater
> should not be turned on for a long time, would it be prudent to explicitly
> turn it off if the driver is unloaded ?

Good point. I send a soft reset (which reinitialize the config) in the
__devexit function and return an -EFAULT if an error occurs.

> If you use SENSOR_DEVICE_ATTR, you can replace show_battery and show_heater
> with a single function.
> 
> static ssize_t sht15_show_status(struct device *dev,
>                                  struct device_attribute *attr,
>                                  char *buf)
> {
>            int ret;
>            struct sht15_data *data = dev_get_drvdata(dev);
>     u8 bit = to_sensor_dev_attr(attr)->index;
> 
>            ret = sht15_update_status(data);
> 
>            return ret ? ret : sprintf(buf, "%d\n", !!(data->val_status & bit));
> }
> 
> static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, sht15_show_status, NULL,
>                   SHT15_STATUS_LOW_BATTERY);
> static SENSOR_DEVICE_ATTR(humidity1_fault, S_IRUGO, sht15_show_status, NULL,
>                   SHT15_STATUS_LOW_BATTERY);
> static SENSOR_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR, sht15_show_status,
>                   sht15_store_heater, SHT15_STATUS_HEATER);

Nice trick, thanks.

> > +static ssize_t sht15_store_heater(struct device *dev,
> > +                                 struct device_attribute *attr,
> > +                                 const char *buf, size_t count)
> > +{
> > +       int ret;
> > +       struct sht15_data *data = dev_get_drvdata(dev);
> > +       long value;
> > +       u8 status;
> > +
> > +       if (strict_strtol(buf, 10, &value))
> > +               return -EINVAL;
> > +
> > +       status = data->val_status;
> > +       if (!!value)
> > +               status |= SHT15_STATUS_HEATER;
> > +       else
> > +               status &= ~SHT15_STATUS_HEATER;
> > +
> > +       mutex_lock(&data->read_lock);
> > +       ret = sht15_send_status(data, status);
> > +       mutex_unlock(&data->read_lock);
> > +
> You read status prior to acquiring the lock. So it could have changed before it gets saved.
> I think you might want to acquire the lock before reading the status value from val_status.

It makes sense.

Thanks for your constructive comments.
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
