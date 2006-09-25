From: bezaur@gmail.com (Charles Spirakis)
Date: Mon, 25 Sep 2006 20:13:40 +0000
Subject: [lm-sensors] [patch] hwmon/w83791d - fix unchecked errs
Message-Id: <5bfe43f80609251313w1a21d4d9qb91f909bd30bda8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45173E99.6050608@gmail.com>
In-Reply-To: <45173E99.6050608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the original code, there was nothing that removed the sysfs files
in the detach. Was that a bug? Or is the removal something new for the
sysfs_create_group() call?  Adding and removing the module before
didn't show any problems (would it show as a kernel memory leak
visible via something like /proc/meminfo?)

I've modified the patch per the discussion below (attached). I have
confirmed the sysfs files are created and the values are accessed
appropriately, but is there a good way to validate the error cases?

-- charles



On 9/25/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Jim,
>
> > replace all unchecked calls to device_create_file with a single group
> > declaration,
> > and one call to sysfs_create_group, and check that one return status.
> >
> > Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>
> >
> > ---
> >
> > compile tested only.  Charles, can you test it for me ? TIA ;-)
> >
> > $ diffstat pc-set/hwmon-unchecked-return-status-fixes-w83791d.patch
> > w83791d.c |   84
> > ++++++++++++++++++++++++++++++++++++++++----------------------
> >  1 files changed, 55 insertions(+), 29 deletions(-)
> >
> > diff -ruNp -X dontdiff -X exclude-diffs 6rlocks-0/drivers/hwmon/w83791d.c w83791d/drivers/hwmon/w83791d.c
> > --- 6rlocks-0/drivers/hwmon/w83791d.c 2006-09-19 23:58:37.000000000 -0600
> > +++ w83791d/drivers/hwmon/w83791d.c   2006-09-24 20:05:04.000000000 -0600
> > @@ -747,6 +747,52 @@ static ssize_t store_vrm_reg(struct devi
> >
> >  static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
> >
> > +#define IN_UNIT_ATTRS(X) \
> > +     &sda_in_input[X].dev_attr.attr, \
> > +     &sda_in_min[X].dev_attr.attr,   \
> > +     &sda_in_max[X].dev_attr.attr
> > +
> > +#define FAN_UNIT_ATTRS(X) \
> > +     &sda_fan_input[X].dev_attr.attr,        \
> > +     &sda_fan_min[X].dev_attr.attr,          \
> > +     &sda_fan_div[X].dev_attr.attr
> > +
> > +#define TEMP_UNIT_ATTRS(X) \
> > +     &sda_temp_input[X].dev_attr.attr,       \
> > +     &sda_temp_max[X].dev_attr.attr,         \
> > +     &sda_temp_max_hyst[X].dev_attr.attr
> > +
> > +static struct attribute *w83791d_attributes[] = {
> > +     IN_UNIT_ATTRS(0),
> > +     IN_UNIT_ATTRS(1),
> > +     IN_UNIT_ATTRS(2),
> > +     IN_UNIT_ATTRS(3),
> > +     IN_UNIT_ATTRS(4),
> > +     IN_UNIT_ATTRS(5),
> > +     IN_UNIT_ATTRS(6),
> > +     IN_UNIT_ATTRS(7),
> > +     IN_UNIT_ATTRS(8),
> > +     IN_UNIT_ATTRS(9),
> > +     FAN_UNIT_ATTRS(0),
> > +     FAN_UNIT_ATTRS(1),
> > +     FAN_UNIT_ATTRS(2),
> > +     FAN_UNIT_ATTRS(3),
> > +     FAN_UNIT_ATTRS(4),
> > +     TEMP_UNIT_ATTRS(0),
> > +     TEMP_UNIT_ATTRS(1),
> > +     TEMP_UNIT_ATTRS(2),
> > +     &dev_attr_alarms.attr,
> > +     &sda_beep_ctrl[0].dev_attr.attr,
> > +     &sda_beep_ctrl[1].dev_attr.attr,
> > +     &dev_attr_cpu0_vid.attr,
> > +     &dev_attr_vrm.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group w83791d_group = {
> > +     .attrs = w83791d_attributes,
> > +};
> > +
> >  /* This function is called when:
> >       * w83791d_driver is inserted (when this module is loaded), for each
> >         available adapter
> > @@ -968,42 +1014,19 @@ static int w83791d_detect(struct i2c_ada
> >       }
> >
> >       /* Register sysfs hooks */
> > +     if ((err = sysfs_create_group(&client->dev.kobj, &w83791d_group)))
> > +             goto error3;
> > +
> > +     /* everythings ready, now register working device */
> >       data->class_dev = hwmon_device_register(dev);
> >       if (IS_ERR(data->class_dev)) {
> >               err = PTR_ERR(data->class_dev);
> > -             goto error3;
> > -     }
> > -
> > -     for (i = 0; i < NUMBER_OF_VIN; i++) {
> > -             device_create_file(dev, &sda_in_input[i].dev_attr);
> > -             device_create_file(dev, &sda_in_min[i].dev_attr);
> > -             device_create_file(dev, &sda_in_max[i].dev_attr);
> > -     }
> > -
> > -     for (i = 0; i < NUMBER_OF_FANIN; i++) {
> > -             device_create_file(dev, &sda_fan_input[i].dev_attr);
> > -             device_create_file(dev, &sda_fan_div[i].dev_attr);
> > -             device_create_file(dev, &sda_fan_min[i].dev_attr);
> > +             goto error4;
> >       }
> >
> > -     for (i = 0; i < NUMBER_OF_TEMPIN; i++) {
> > -             device_create_file(dev, &sda_temp_input[i].dev_attr);
> > -             device_create_file(dev, &sda_temp_max[i].dev_attr);
> > -             device_create_file(dev, &sda_temp_max_hyst[i].dev_attr);
> > -     }
> > -
> > -     device_create_file(dev, &dev_attr_alarms);
> > -
> > -     for (i = 0; i < ARRAY_SIZE(sda_beep_ctrl); i++) {
> > -             device_create_file(dev, &sda_beep_ctrl[i].dev_attr);
> > -     }
> > -
> > -     device_create_file(dev, &dev_attr_cpu0_vid);
> > -     device_create_file(dev, &dev_attr_vrm);
> > -
> >       return 0;
> >
> > -error3:
> > +error4:
> >       if (data->lm75[0] != NULL) {
> >               i2c_detach_client(data->lm75[0]);
> >               kfree(data->lm75[0]);
> > @@ -1012,6 +1035,9 @@ error3:
> >               i2c_detach_client(data->lm75[1]);
> >               kfree(data->lm75[1]);
> >       }
> > +
> > +error3:
> > +     sysfs_remove_group(&client->dev.kobj, &w83791d_group);
>
> Looks broken to me. error3 should remove the subclients, and error4
> should remove the sysfs files, rather than the over way around.
>
> >  error2:
> >       i2c_detach_client(client);
> >  error1:
>
> Also, it misses the sysfs files removal at i2c client deletion time.
>
> Care to submit a fixed patch? Thanks.
>
> --
> Jean Delvare
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_sysfs_error.patch
Type: text/x-patch
Size: 3885 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060925/e22d6f71/attachment-0001.bin 
