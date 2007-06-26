From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 26 Jun 2007 22:54:55 +0000
Subject: Re: [lm-sensors] [PATCH] Add temperature-tracking mode to f71805f
Message-Id: <191fb4ca0706261554w3f6e9b62p19665e7645bd9880@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182285507009@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182285507009@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/25/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Phil,
>
> On Sun, 24 Jun 2007 11:49:39 +0100, Phil Endecott wrote:
> > Jean Delvare wrote:
> > > $ quilt push
> > > Application de hwmon-f71805f-add-temperature-tracking-mode.patch
> > > patching file drivers/hwmon/f71805f.c
> > > Hunk #1 FAILED at 126.
> > > Hunk #2 FAILED at 149.
> > > Hunk #3 FAILED at 180.
> > > Hunk #4 FAILED at 323.
> > > Hunk #5 FAILED at 353.
> > > Hunk #6 FAILED at 728.
> > > Hunk #7 FAILED at 1029.
> > > Hunk #8 FAILED at 1163.
> >
> > Ooops, sorry.  It looks like the start-of-file lines got word-wrapped between the
> > filename and the timestamp somewhere in the email.  I'll try again (below).
>
> Much better, thanks. Patch tested, it work fine for me.
>
> > --- linux-2.6-2.6.21/drivers/hwmon/f71805f.c.orig     2007-06-16 00:10:54.000000000 +0100
> > +++ linux-2.6-2.6.21/drivers/hwmon/f71805f.c  2007-06-19 21:07:26.000000000 +0100
> > @@ -126,6 +126,12 @@
> >  #define F71805F_REG_TEMP_HIGH(nr)    (0x54 + 2 * (nr))
> >  #define F71805F_REG_TEMP_HYST(nr)    (0x55 + 2 * (nr))
> >  #define F71805F_REG_TEMP_MODE                0x01
> > +/* pwm/fan pwmnr from 0 to 2, auto point apnr from 0 to 2 */
> > +/* map fintek numbers to our numbers as follows: 9->0, 5->1, 1->2. */
> > +#define F71805F_REG_PWM_AUTO_POINT_TEMP(pwmnr, apnr) \
> > +     (0xA0 + 0x10 * (pwmnr) + (2-apnr))
> > +#define F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr, apnr) \
> > +     (0xA4 + 0x10 * (pwmnr) + 2 * (2-apnr))
> >
> >  #define F71805F_REG_START            0x00
> >  /* status nr from 0 to 2 */
> > @@ -143,6 +149,11 @@
> >   * Data structures and manipulation thereof
> >   */
> >
> > +struct f71805f_auto_point {
> > +     u8 temp[3];
> > +     u16 fan[3];
> > +};
> > +
> >  struct f71805f_data {
> >       unsigned short addr;
> >       const char *name;
> > @@ -169,6 +180,7 @@
> >       u8 temp_hyst[3];
> >       u8 temp_mode;
> >       unsigned long alarms;
> > +     struct f71805f_auto_point auto_points[3];
> >  };
> >
> >  struct f71805f_sio_data {
> > @@ -311,7 +323,7 @@
> >  static struct f71805f_data *f71805f_update_device(struct device *dev)
> >  {
> >       struct f71805f_data *data = dev_get_drvdata(dev);
> > -     int nr;
> > +     int nr, apnr;
> >
> >       mutex_lock(&data->update_lock);
> >
> > @@ -341,6 +353,18 @@
> >                                             F71805F_REG_TEMP_HYST(nr));
> >               }
> >               data->temp_mode = f71805f_read8(data, F71805F_REG_TEMP_MODE);
> > +             for (nr = 0; nr < 3; nr++) {
> > +                     for (apnr = 0; apnr < 3; apnr++) {
> > +                             data->auto_points[nr].temp[apnr] > > +                                     f71805f_read8(data,
> > +                                     F71805F_REG_PWM_AUTO_POINT_TEMP(nr,
> > +                                                                     apnr));
> > +                             data->auto_points[nr].fan[apnr] > > +                                     f71805f_read16(data,
> > +                                     F71805F_REG_PWM_AUTO_POINT_FAN(nr,
> > +                                                                     apnr));
> > +                     }
> > +             }
> >
> >               data->last_limits = jiffies;
> >       }
> > @@ -704,6 +728,80 @@
> >       return count;
> >  }
> >
> > +static ssize_t show_pwm_auto_channels(struct device *dev,
> > +                                     struct device_attribute *devattr,
> > +                                     char* buf)
> > +{
> > +     struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +     int nr = attr->index;
> > +
> > +     return sprintf(buf, "%d\n", 1<<nr);
> > +}
> > +
> > +static ssize_t show_pwm_auto_point_temp(struct device *dev,
> > +                                     struct device_attribute *devattr,
> > +                                     char* buf)
> > +{
> > +     struct f71805f_data *data = dev_get_drvdata(dev);
> > +     struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +     int pwmnr = attr->nr;
> > +        int apnr  = attr->index;
>
> Broken indentation.
>
> > +
> > +     return sprintf(buf, "%ld\n",
> > +                     temp_from_reg(data->auto_points[pwmnr].temp[apnr]));
> > +}
> > +
> > +static ssize_t set_pwm_auto_point_temp(struct device *dev,
> > +                                     struct device_attribute *devattr,
> > +                                     const char* buf, size_t count)
> > +{
> > +     struct f71805f_data *data = dev_get_drvdata(dev);
> > +     struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +     int pwmnr = attr->nr;
> > +        int apnr  = attr->index;
>
> Here again.
>
> > +     unsigned long val = simple_strtoul(buf, NULL, 10);
>
> Temperatures can be negative -> simple_strtol().
>
> > +
> > +     mutex_lock(&data->update_lock);
> > +     data->auto_points[pwmnr].temp[apnr] = temp_to_reg(val);
> > +     f71805f_write8(data, F71805F_REG_PWM_AUTO_POINT_TEMP(pwmnr, apnr),
> > +                    data->auto_points[pwmnr].temp[apnr]);
> > +     mutex_unlock(&data->update_lock);
> > +
> > +     return count;
> > +}
> > +
> > +static ssize_t show_pwm_auto_point_fan(struct device *dev,
> > +                                     struct device_attribute *devattr,
> > +                                     char* buf)
> > +{
> > +     struct f71805f_data *data = dev_get_drvdata(dev);
> > +     struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +     int pwmnr = attr->nr;
> > +        int apnr  = attr->index;
>
> And again.
>
> > +
> > +     return sprintf(buf, "%ld\n",
> > +                     fan_from_reg(data->auto_points[pwmnr].fan[apnr]));
> > +}
> > +
> > +static ssize_t set_pwm_auto_point_fan(struct device *dev,
> > +                                     struct device_attribute *devattr,
> > +                                     const char* buf, size_t count)
> > +{
> > +     struct f71805f_data *data = dev_get_drvdata(dev);
> > +     struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +     int pwmnr = attr->nr;
> > +        int apnr  = attr->index;
>
> And again. Ahhh, cut'n'paste ;)
>
> > +     unsigned long val = simple_strtoul(buf, NULL, 10);
> > +
> > +     mutex_lock(&data->update_lock);
> > +     data->auto_points[pwmnr].fan[apnr] = fan_to_reg(val);
> > +     f71805f_write16(data, F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr, apnr),
> > +                     data->auto_points[pwmnr].fan[apnr]);
> > +     mutex_unlock(&data->update_lock);
> > +
> > +     return count;
> > +}
> > +
> >  static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
> >                        char *buf)
> >  {
> > @@ -931,6 +1029,58 @@
> >                         show_pwm_freq, set_pwm_freq, 2);
> >  static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
> >
> > +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO,
> > +                                     show_pwm_auto_channels, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IRUGO,
> > +                                     show_pwm_auto_channels, NULL, 1);
> > +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IRUGO,
> > +                                     show_pwm_auto_channels, NULL, 2);
> > +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_fan, S_IRUGO,
> > +                                     show_pwm_auto_channels, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_fan, S_IRUGO,
> > +                                     show_pwm_auto_channels, NULL, 1);
> > +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_fan, S_IRUGO,
> > +                                     show_pwm_auto_channels, NULL, 2);
>
> Not sure what others think about this (Mark? Juerg?) but this (pwm1 to
> fan1 and to temp1, etc.) seems to be the usual mapping for chips where
> the mappings can't be changed, so I wonder what's the benefit of
> creating read-only sysfs files to express it. I think I'd be just as
> happy with no channel files at all (and it's cheaper.) No strong
> opinion though.

I don't find them particularly useful. The static mapping should be
documented in the chip doc.

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
