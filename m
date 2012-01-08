From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 Jan 2012 19:03:53 +0000
Subject: Re: [lm-sensors] [PATCH 17/17] drivers/hwmon/i5k_amb.c: fix
Message-Id: <20120108190353.GC23747@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 08, 2012 at 01:41:00PM -0500, Frans Meulenbroeks wrote:
> Guenter, as your reply was not to the list I haven't cc-ed the list either, but
> see below
> 
Not on purpose. Must have hit "reply" instead of "reply all". Copying the list now.

> Frans
> 
> 2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>
> 
>     Hi Frans,
> 
>     On Sun, Jan 08, 2012 at 12:48:17PM -0500, Frans Meulenbroeks wrote:
>     >
>     >
>     > 2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>
>     >
>     >     Hi Frans,
>     >
>     >     On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks wrote:
>     >     > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
>     >     > ---
>     >     >  drivers/hwmon/i5k_amb.c |   15 ++++++++++++---
>     >     >  1 files changed, 12 insertions(+), 3 deletions(-)
>     >     >
>     >     > diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
>     >     > index d22f241..c516bdc 100644
>     >     > --- a/drivers/hwmon/i5k_amb.c
>     >     > +++ b/drivers/hwmon/i5k_amb.c
>     >     > @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct device
>     *dev,
>     >     >  {
>     >     >       struct sensor_device_attribute *attr = to_sensor_dev_attr
>     (devattr);
>     >     >       struct i5k_amb_data *data = dev_get_drvdata(dev);
>     >     > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
>     >     > +     unsigned long temp;
>     >     > +     int ret = kstrtoul(buf, 10, &temp) / 500;
>     >
>     >     This divides the error code by 500, not temp.
>     >
>     >     > +     if (ret < 0)
>     >     > +             return ret;
>     >     >
>     >     >       if (temp > 255)
>     >     >               temp = 255;
>     >     > @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct device
>     *dev,
>     >     >  {
>     >     >       struct sensor_device_attribute *attr = to_sensor_dev_attr
>     (devattr);
>     >     >       struct i5k_amb_data *data = dev_get_drvdata(dev);
>     >     > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
>     >     > +     unsigned long temp;
>     >     > +     int ret = kstrtoul(buf, 10, &temp) / 500;
>     >
>     >     Same here.
>     >
>     >     > +     if (ret < 0)
>     >     > +             return ret;
>     >     >
>     >     >       if (temp > 255)
>     >     >               temp = 255;
>     >     > @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct device
>     *dev,
>     >     >  {
>     >     >       struct sensor_device_attribute *attr = to_sensor_dev_attr
>     (devattr);
>     >     >       struct i5k_amb_data *data = dev_get_drvdata(dev);
>     >     > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
>     >     > +     unsigned long temp;
>     >     > +     int ret = kstrtoul(buf, 10, &temp) / 500;
>     >
>     >     and here.
>     >
>     >     Guenter
>     >
>     >
>     > Yes of course!
>     > That is one of the risks of these edits. At some point too much autopilot
>     > creeps in.
>     > I'll send an update. There are not otehr places that hae this issue.
>     >
>     > BTW, there is one other thing with this code that might be questionalble
>     and
>     > that is the fact that temp is an unsigned long.
>     > Is it not possible with this sensor to have a temp < 0 (I'm assuming temp
>     is
>     > degrees C or maybe F).
> 
>     Usually that is reflected by the variable type and the conversion function.
>     With unsigned long and kstrtoul(), negative values are not accepted,
>     so that is commonly used if the sensor only supports non-negative
>     temperatures.
>     Which is exactly what happens here.
> 
>     Am I missing something ?
> 
> 
> Nope. I've no idea what sensors support negative temperatures and which not.
> I expected it somehow to be more standardised.
> 
Yes, that would be nice. Not the case, unfortunately. If it were, we would not need
that many drivers.... even where a standard exists, its interpretation varies widely.
Just look at the pmbus drivers.

> 
>     > This might also be an issue on other places. (actually I seem to recall
>     having
>     > seen a place where the var was signed and the conversion function was
>     unsigned
>     > (or the other way around))
>     >
>     Usually both should match. If you notice a mismatch, please let us know.
> 
> 
> adm9240.c:      unsigned long val = simple_strtol(buf, NULL, 10);
> adm9240.c:      unsigned long val = simple_strtol(buf, NULL, 10);
> f71805f.c:      unsigned long val = simple_strtol(buf, NULL, 10);
> lm77.c: long val = simple_strtoul(buf, NULL, 10);
> lm80.c: long val = simple_strtoul(buf, NULL, 10);
> lm80.c: long val = simple_strtoul(buf, NULL, 10); \
>  
> and these:
> abituguru.c:    int mask = simple_strtoul(buf, NULL, 10);
> abituguru.c:    int mask = simple_strtoul(buf, NULL, 10);
> max6650.c:      int rpm = simple_strtoul(buf, NULL, 10);
> max6650.c:      int pwm = simple_strtoul(buf, NULL, 10);
> max6650.c:      int mode = simple_strtoul(buf, NULL, 10);
> max6650.c:      int div = simple_strtoul(buf, NULL, 10);
> thmc50.c:       int tmp = simple_strtoul(buf, NULL, 10);
> vt8231.c:       int val = simple_strtoul(buf, NULL, 10);
> 
> and a lot of these:
> adm1031.c:      int val = simple_strtol(buf, NULL, 10);
> where I would probably have preferred long
> 
All worth looking into and not clean.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
