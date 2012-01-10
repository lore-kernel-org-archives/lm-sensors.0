From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 19:55:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm80) fixed checkpatch errors
Message-Id: <1326225332.2649.95.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326206976-7846-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-10 at 14:43 -0500, Frans Meulenbroeks wrote:
> Oops, forgot to cc the list.
> 
> ---------- Forwarded message ----------
> From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> Date: 2012/1/10
> Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm80) fixed checkpatch
> errors
> To: guenter.roeck@ericsson.com
> 
> 
> 
> 
> 2012/1/10 Guenter Roeck <guenter.roeck@ericsson.com>
>         On Tue, 2012-01-10 at 13:50 -0500, Frans Meulenbroeks wrote:
>         >
>         >
>         > 2012/1/10 Guenter Roeck <guenter.roeck@ericsson.com>
>         >         Hi Frans,
>         >
>         >         On Tue, 2012-01-10 at 09:49 -0500, Frans
>         Meulenbroeks wrote:
>         >         > fixed:
>         >         > WARNING: simple_strtol is obsolete, use kstrtol
>         instead
>         >         > WARNING: simple_strtoul is obsolete, use kstrtoul
>         instead
>         >         >
>         >         > Signed-off-by: Frans Meulenbroeks
>         >         <fransmeulenbroeks@gmail.com>
>         >         > ---
>         >         >  drivers/hwmon/lm80.c |   20 ++++++++++++++++----
>         >         >  1 files changed, 16 insertions(+), 4 deletions(-)
>         >         >
>         >         > diff --git a/drivers/hwmon/lm80.c
>         b/drivers/hwmon/lm80.c
>         >         > index 616f470..18e5ea4 100644
>         >         > --- a/drivers/hwmon/lm80.c
>         >         > +++ b/drivers/hwmon/lm80.c
>         >         > @@ -185,7 +185,10 @@ static ssize_t
>         set_in_##suffix(struct
>         >         device *dev, \
>         >         >       int nr = to_sensor_dev_attr(attr)->index; \
>         >         >       struct i2c_client *client >         to_i2c_client(dev); \
>         >         >       struct lm80_data *data >         i2c_get_clientdata(client); \
>         >         > -     long val = simple_strtol(buf, NULL, 10); \
>         >         > +     long val; \
>         >         > +     int err = kstrtol(buf, 10, &val); \
>         >         > +     if (err < 0) \
>         >         > +             return err; \
>         >         >  \
>         >         >       mutex_lock(&data->update_lock);\
>         >         >       data->value[nr] = IN_TO_REG(val); \
>         >         > @@ -226,7 +229,10 @@ static ssize_t
>         set_fan_min(struct
>         >         device *dev, struct device_attribute *attr,
>         >         >       int nr = to_sensor_dev_attr(attr)->index;
>         >         >       struct i2c_client *client >         to_i2c_client(dev);
>         >         >       struct lm80_data *data >         i2c_get_clientdata(client);
>         >         > -     long val = simple_strtoul(buf, NULL, 10);
>         >         > +     long val;
>         >         > +     int err = kstrtol(buf, 10, &val);
>         >         > +     if (err < 0)
>         >         > +             return err;
>         >         >
>         >
>         >         You replaced simple_strtoul() with kstrtol(). Should
>         have been
>         >         unsigned
>         >         long and kstrtoul(). No need to resubmit, I fixed
>         that. Queued
>         >         for -rc2.
>         >
>         >         Thanks,
>         >         Guenter
>         >
>         > Hi  Guenter,
>         >
>         > The change was on two places and intentional.
>         >
>         > The original code reads:
>         > long val = simple_strtoul(buf, NULL, 10);
>         > I feel this is a flaw and that simple_strtol should have
>         been used
>         > here (and eventually kstrtol.
>         > (or alternately the variable should have been an unsigned
>         long)
>         >
>         
>         Frans,
>         
>         I am lost. Why, and what do you think is the flaw ? You said
>         yourself in
>         the other thread that negative values don't make sense here.
>         Why do you
>         want to successfully parse negative values if they are not
>         supported.?
>         
>         I'll drop the two patches for now until that is resolved.
>         
>         
> Hi Guenter,
> 
> Actually I misread your original email.
> 
> You wrote:
> >
> >         You replaced simple_strtoul() with kstrtol(). Should have
> been
> >         unsigned
> >         long and kstrtoul(). No need to resubmit, I fixed that.
> Queued
> 
> 
> Actually I overlooked that you changed long to unsigned long too. 
> That is also why I wrote:
> 
> > (or alternately the variable should have been an unsigned long)
> 
> 
> I just had the impression that you only changed simple_strol into
> kstrtoul without changing the var.
> 
> Your change to kstrtoul and changing val to unsigned long at the same
> time is of course ok.
> 
> Apologies for the confusion caused. 
> Please apply with your fixes.
> 
Ok, makes sense. Done.

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
