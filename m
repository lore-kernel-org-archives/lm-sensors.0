From: "Charles Spirakis" <bezaur@gmail.com>
Date: Mon, 03 Sep 2007 21:49:54 +0000
Subject: Re: [lm-sensors] [PATCH] update w83791d driver with new sysfs
Message-Id: <5bfe43f80709031449nefb0473s4577f62e8d278ea7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
In-Reply-To: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean --

Thank you for taking the time to review my code! I always find your
reviews to be very useful and appreciate your help in making the code
base better for everyone.

Below are some comments/questions:

>
> > Signed-off by: Charles Spirakis <bezaur@gmail.com>
>
> Note: should be "Signed-off-by" with two dashes.
>
Oops. Will do.

> >
> >  W83791D TODO:
> >  ---------------
> > -Provide a patch for per-file alarms and beep enables as defined in the hwmon
> > -     documentation (Documentation/hwmon/sysfs-interface)
> >  Provide a patch for smart-fan control (still need appropriate motherboard/fans)
>
> A few lines above in this document, is written:
>
> *** NOTE: It is the responsibility of user-space code to handle the fact
> that the beep enable and alarm bits are in different positions when using that
> feature of the chip.
>
> Maybe it would be good to mention that this problem doesn't exist when
> using the new individual alarm and beep files?
>
Yes. I'll clean that up to better describe the legacy vs.
new/preferred interface.

> > +     struct sensor_device_attribute *sensor_attr > > +                                             to_sensor_dev_attr(attr);
> > +     struct w83791d_data *data = w83791d_update_device(dev);
> > +     int bitnr = sensor_attr->index;
> > +
> > +     return sprintf(buf, "%d\n", (data->beep_mask >> bitnr) & 1);
> > +}
>
> Some times ago, Mark M. Hoffman proposed a more compact alternative to
> retrieve the index value:
>
>         int bitnr = to_sensor_dev_attr(attr)->index;
>
> You may want to use this.
I will update. I'm assuming you want me to update all uses in the
driver and not just the new ones?

>
> > +static ssize_t store_beep(struct device *dev, struct device_attribute *attr,
> > +                     const char *buf, size_t count)
> > +{
> > +     struct sensor_device_attribute *sensor_attr > > +                                             to_sensor_dev_attr(attr);
> > +     struct i2c_client *client = to_i2c_client(dev);
> > +     struct w83791d_data *data = w83791d_update_device(dev);
>
> We normally don't call the big update function in write callbacks. This
> function reads dozens of register values which you don't need here,
> this will make the write very slow. The preferred way is to read just
> the register(s) you need. This should be fairly easy in your case.
The big update function (w83791d_update_device) allows itself to read
the hardware at most once every 3 seconds.

I initially put this call in each of the read/write routines so that
(1) it makes sure that we have recent values if it has been a long
time since the last call (2) it keeps the hardware read access
confined to one routine and (3) it allowed all of the other routines
to simply deal with driver variables instead of the actual hardware
and (4) regardless of the frequency or order of the calls from
user-mode, the values from the hardware would all be from roughly the
same point in time and grabbed, at most, once every 3 seconds.

Did you want me to update this for all of the code in the driver?

>
> > +     int bitnr = sensor_attr->index;
> > +     long val = simple_strtol(buf, NULL, 10) ? 1 : 0;
> > +     long beep_bit = val ? (1 << bitnr) : 0;
>
> More simply written val << bitnr.
WIll do.

> > +
> > +     /* In theory, based on the bit we changed we only need to update
> > +        one register, but why bother, this isn't time critical code... */
> > +     for (i = 0; i < 3; i++) {
> > +             w83791d_write(client, W83791D_REG_BEEP_CTRL[i], (val & 0xff));
> > +             val >>= 8;
> > +     }
>
> I agree that this isn't time critical, but I2C transactions can be slow
> and selecting the right byte is really easy:
>
>         int bytenr = bitnr / 8;
>         w83791d_write(client, W83791D_REG_BEEP_CTRL[bytenr],
>                       (data->beep_mask >> (bytenr * 8)) & 0xff);
>
> So maybe you can do it after all?
Will do.

> >
> > +static struct sensor_device_attribute sda_fan_beep[] = {
> > +     SENSOR_ATTR(fan1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 6),
> > +     SENSOR_ATTR(fan2_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 7),
> > +     SENSOR_ATTR(fan3_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 11),
> > +     SENSOR_ATTR(fan4_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 21),
> > +     SENSOR_ATTR(fan5_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 22)
>
> Please add a trailing comma, and below too (4 times total.)
Will do.

> > +
> > +/* vim: set ts=8 sw=8 twx sts=0 noet ai cin cino= formatoptions=croql: */
>
> I'd venture that you did not really want this to be part of your patch?
I use vi and I've seen it in some of the other drivers and it seemed
like a good idea at the time :) I will remove.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
