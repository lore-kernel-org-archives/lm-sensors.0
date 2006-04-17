From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 17 Apr 2006 17:46:35 +0000
Subject: [lm-sensors] vt1211 driver (was hwmon/pc87360 as a platform
Message-Id: <191fb4ca0604171046o3746b050o9f6ac520c7d121b0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4443BC76.3060905@gmail.com>
In-Reply-To: <4443BC76.3060905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Thanks for the review!

> + * Reading 1                      temp3       Intel thermal diode
> + * Reading 3                      temp1       internal thermal diode
>
> Intel or internal ??

Intel *and* internal, just as the comment says.

> + * ------------------------------------------------------------------------ */
>
> Im not sure how Jean feels about 'code-fences' like --------------,
> but Id like them to not exceed 79 columns.
> my editor, emacs, has 80 column window by default,
> and its sticking in a line-wrap.
> Just one less char, and the wrap goes away.

I *like* them :-) I'll fix the length issue.

> +static struct vt1211_data *vt1211_update_device(struct device *dev)
> +{
> +       struct vt1211_data *data = dev_get_drvdata(dev);
> +       int ix, val;
> +
> +       mutex_lock(&data->update_lock);
> +
> +       /* registers cache is refreshed after 1 second */
> +       if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> +
> +               /* voltage (in) registers */
> +               for (ix = 0; ix <= 6; ix++) {
>
>
> here and elsewhere, ARRAY_SIZE() instead of numeric constants

OK.

> +               /* temp registers */
> +               for (ix = 1; ix <= 7; ix++) {
>
> why start at 1 ?
> you could instead build the offset into your SENSOR_ATTR_{TEMP,FAN}
> initializations, then you dont need runtime -1

I think it's more clear this way. I like the callback numbers to match
the sysfs numbers. In fact when I first looked at the driver, I had a
hard time figuring out what was going on because of the offsetting.

> +#define SHOW_IN_INPUT  0
> +#define SHOW_SET_IN_MIN        1
> +#define SHOW_SET_IN_MAX        2
> +#define SHOW_IN_ALARM  3
>
> FWIW, I like these combo callbacks

Me too. It shrinks the source down and makes it more readable.

> +       case SHOW_IN_ALARM:
> +               return sprintf(buf, "%d\n", ISVOLT(ix, data->uch_config) &
> +                              (ix = 0 ? data->alarms >> 11 :
> +                               ix = 1 ? data->alarms >>  0 :
> +                               ix = 2 ? data->alarms >>  1 :
> +                               ix = 3 ? data->alarms >>  3 :
> +                               ix = 4 ? data->alarms >>  8 :
> +                               ix = 5 ? data->alarms >>  2 :
>
> maybe a const lookup table is better here,
> esp for doc'g the mapping.

Yep, good idea. Will fix.

> +       case SHOW_SET_PWM_FREQUENCY:
> +               tmp = data->pwm_clk & 7;
> +               return sprintf(buf, "%d\n",
> +                              (tmp = 1 ? 45000 : tmp = 2 ? 22500 :
> +                               tmp = 3 ? 11250 : tmp = 4 ?  5630 :
> +                               tmp = 5 ?  2800 : tmp = 6 ?  1400 :
> +                               tmp = 7 ?   700 : 90000));
>
>
> another map, this time with very magic numbers.

Not very magic, just copied from the datasheet.

> +static ssize_t set_pwm_auto_point_pwm(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t count)
> +{
> +       struct vt1211_data *data = dev_get_drvdata(dev);
> +       struct sensor_device_attribute_2 *sensor_attr_2 > +                                               to_sensor_dev_attr_2(attr);
> +       int ix = sensor_attr_2->index;
> +       int ap = sensor_attr_2->nr;
> +       long val = simple_strtol(buf, NULL, 10);
> +       if (ap = 2 || ap = 3) {
>
> comment why only 2,3 ??

0 and 4 are hard-wired in the chip and not programmable.

> +static int __init vt1211_device_add(unsigned short address)
> +{
> +       struct resource res = {
> +               .start  = address,
> +               .end    = address + 0x7f,
> +               .flags  = IORESOURCE_IO,
> +       };
> +       int err;
> +
>
>
> Im curious, how many functional units does your SIO device have ?
> are you mapping them all in 1 block ?

The vt1211 has 12 logical units (which map to different base
addresses) but the driver only deals with one of them (HW monitor).
The size of the HW monitor register space is 0x80 and it's mapped to
0xec00 (default).


...juerg

