From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Sep 2007 22:13:43 +0000
Subject: Re: [lm-sensors] [PATCH] update w83791d driver with new sysfs
Message-Id: <20070904001343.3a2bc2e3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
In-Reply-To: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Mon, 3 Sep 2007 14:49:54 -0700, Charles Spirakis wrote:
> Below are some comments/questions:
> (...)
> > > +     struct sensor_device_attribute *sensor_attr > > > +                                             to_sensor_dev_attr(attr);
> > > +     struct w83791d_data *data = w83791d_update_device(dev);
> > > +     int bitnr = sensor_attr->index;
> > > +
> > > +     return sprintf(buf, "%d\n", (data->beep_mask >> bitnr) & 1);
> > > +}
> >
> > Some times ago, Mark M. Hoffman proposed a more compact alternative to
> > retrieve the index value:
> >
> >         int bitnr = to_sensor_dev_attr(attr)->index;
> >
> > You may want to use this.
>
> I will update. I'm assuming you want me to update all uses in the
> driver and not just the new ones?

You're assuming wrong ;) Your patch shouldn't mix a new feature with
cleanups. If you want to update all the other uses, that's fine with
me, but that would be a separate patch. This is completely optional, of
course.

> > > +static ssize_t store_beep(struct device *dev, struct device_attribute *attr,
> > > +                     const char *buf, size_t count)
> > > +{
> > > +     struct sensor_device_attribute *sensor_attr > > > +                                             to_sensor_dev_attr(attr);
> > > +     struct i2c_client *client = to_i2c_client(dev);
> > > +     struct w83791d_data *data = w83791d_update_device(dev);
> >
> > We normally don't call the big update function in write callbacks. This
> > function reads dozens of register values which you don't need here,
> > this will make the write very slow. The preferred way is to read just
> > the register(s) you need. This should be fairly easy in your case.
> The big update function (w83791d_update_device) allows itself to read
> the hardware at most once every 3 seconds.
> 
> I initially put this call in each of the read/write routines so that
> (1) it makes sure that we have recent values if it has been a long
> time since the last call (2) it keeps the hardware read access
> confined to one routine and (3) it allowed all of the other routines
> to simply deal with driver variables instead of the actual hardware
> and (4) regardless of the frequency or order of the calls from
> user-mode, the values from the hardware would all be from roughly the
> same point in time and grabbed, at most, once every 3 seconds.
> 
> Did you want me to update this for all of the code in the driver?

No, just for store_beep(). I just double-checked your driver and you do
_not_ call the update function for any other write callback, only for
read callbacks (and that's OK).

The rationale is that writes typically happen at boot time ("sensors
-s" is run from an init script). At this point in time, the user
doesn't want to read the sensor values, so putting all the values in
the cache is not useful. We only have to write a few settings. In many
cases we can write the values directly to the registers. Only in a few
cases we need to read from the registers first (like is the case for
the beep mask.) We want to avoid increasing the boot time by one second
or so because we read a bunch of registers we don't even need.

> > > +
> > > +/* vim: set ts=8 sw=8 twx sts=0 noet ai cin cino= formatoptions=croql: */
> >
> > I'd venture that you did not really want this to be part of your patch?
>
> I use vi and I've seen it in some of the other drivers and it seemed
> like a good idea at the time :) I will remove.

Not everyone uses vi ;) And these settings should really be set at the
tree level, not for each file individually.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
