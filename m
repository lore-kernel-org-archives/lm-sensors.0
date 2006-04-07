From: bezaur@gmail.com (Charles Spirakis)
Date: Fri, 07 Apr 2006 02:54:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <5bfe43f80604061954m315e846ev66c399726495be47@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean --

Thanks for taking the time to look this over. I long ago learned the
value of code reviews and got another reminder on this one  :)

In general, I have no issues with the changes you are proposing. I do
have a couple of questions/comments (below):

On 4/5/06, Jean Delvare <khali at linux-fr.org> wrote:
...
> In a more general way, you may want to take a look at the recent
> changes which were made to the w83792d driver, and see if they could
> apply to your code too.
I'll grab an older kernel tree and compare this file with a recent git
tree. Are there more changes that are not yet in git20 that I should
be aware of? Should I be comparing against a different tree (like the
-mm tree) or is there a special lmsensor archive/tree?

>
> > +#define show_fan_reg(reg) \
> > +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> > +                             char *buf) \
> > +{ \
> > +     struct sensor_device_attribute *sensor_attr = \
> > +                                             to_sensor_dev_attr(attr); \
> > +     int nr = sensor_attr->index - 1; \
>
> You could define the sysfs files attribute differently so that you
> don't need to apply that offset on every access to every file. That
> would be both shorter and more efficient.
I was following what the w83792d driver was doing in this regard.
Also, having the index start with one was a little easier mentally
during debugging for the fans and temps as the sysfs names starts with
one. I will change to zero based...

>
> > +     default:
> > +             dev_warn(dev, "store_fan_div: Unexpected nr seen: %d\n", nr);
> > +             count = -EINVAL;
> > +             goto err_exit;
>
> This is so unexpected that this just cannot happen, unless you have an
> internal (code) error. So this part should either not exist at all (now
> that the driver is working) or be only compiled in in debug mode.
Will #ifdef  DEBUG this. Having this saved me much grief during
debugging and I'd hate to make a code change in the future that falls
through and not notice it...

> > +     /* A few vars need to be filled upon startup */
> > +     for (i = 1; i <= NUMBER_OF_FANIN; i++) {
> > +             data->fan_min[i - 1] = w83791d_read(new_client,
> > +                                             W83791D_REG_FAN_MIN[i]);
> > +     }
>
> Isn't it a nice off-by-one I'm spotting here? Please fix!
Guilty your honor. I throw myself upon the mercy of the court...

>
> +       for (i = 0; i < 2; i++) {
> +               device_create_file(dev, &sda_beep_ctrl[i].dev_attr);
> +       }
>
> You could use ARRAY_SIZE(sda_beep_ctrl) instead of hardcoding 2. This
> is easier to understand for the reader, and more robust to future
> changes too. I'm not sure if this array really adds anything though.
It seemed like the array structure "grouped" things a bit and provided
some consistency given all the other "groups" were now arrays
(voltage, fan, temp). I can go either way on this if you have a
preference.

> > +     temp2_cfg = w83791d_read(client, W83791D_REG_TEMP2_CONFIG);
> > +     temp3_cfg = w83791d_read(client, W83791D_REG_TEMP3_CONFIG);
> > +     w83791d_write(client, W83791D_REG_TEMP2_CONFIG, temp2_cfg & 0xe6);
> > +     w83791d_write(client, W83791D_REG_TEMP3_CONFIG, temp3_cfg & 0xe6);
>
> What are these doing? This needs a comment. Also note that you could do
> with a single temporary variable (or even without one.)
>
It is making sure the two temp sensors are enabled while preserving
the reserved bits (the w83792 driver is doing this also). If you reset
the chip the HW takes care of this. Guess I can remove the code and
assume the BIOS is doing the right thing when reset=0...

> OK, that's it. Please fix the issues I mentioned (or explain why you
> won't if you don't agree with my comments.) Then resubmit the driver,
> and I should accept it and get it merged. Thanks for the good work!
>
> Other things which need to be done about this driver:
>
> * Userspace part. Does libsensors handle this driver properly already?
I'm using sensors 2.9.2 and the corresponding libsensors and things
seem to work. I can update to the latest release to verify.

>
> * Linux 2.4. For now the W83791D chip is handled by the w83781d driver.
> This might be a bit confusing to the user that we have a dedicated
> driver in 2.6 and not in 2.4. OTOH I don't have the time to split
> support to a separate driver myself. If anyone wants to do it, this is
> welcome, but probably not required.
>
> * sensors-detect needs to be updated, as for now it points the W83791D
> owners to the w83781d driver regardless of the kernel version. Patch
> anyone?
Yes, it detects the w83791d correctly and tells you to load the w83781d driver:

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0540'
    Busdriver `i2c-i801', I2C address 0x2c (and 0x48 0x49)
    Chip `Winbond W83791D' (confidence: 7)

I haven't looked at that code/scripts, but I can update depending on
how you want to handle it (check for 2.4 vs. 2.6 and output as
appropriate?)

-- charles

