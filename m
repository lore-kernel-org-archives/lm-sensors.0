From: Simon Guinot <simon@sequanux.org>
Date: Thu, 21 Oct 2010 14:06:27 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <20101021140626.GQ29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2365097002716015987=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101021064145.GA25095@ericsson.com>
In-Reply-To: <20101021064145.GA25095@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============2365097002716015987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
Content-Disposition: inline


--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thanks for your comments.

On Wed, Oct 20, 2010 at 11:41:45PM -0700, Guenter Roeck wrote:
> Hi Simon,
>=20
> looking much better. Bunch of additional comments inline.
>=20
> On Wed, Oct 20, 2010 at 12:37:26PM -0400, Simon Guinot wrote:
> > This patch adds hwmon support for the GPIO connected fan.
> >=20
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> >=20
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > ---
> >  drivers/hwmon/Kconfig    |    9 +
> >  drivers/hwmon/Makefile   |    1 +
> >  drivers/hwmon/gpio-fan.c |  557 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/gpio-fan.h |   36 +++
> >  4 files changed, 603 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/gpio-fan.c
> >  create mode 100644 include/linux/gpio-fan.h
> >=20
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4d4d09b..af318a1 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -368,6 +368,15 @@ config SENSORS_FSCHMD
> >           This driver can also be built as a module.  If so, the module
> >           will be called fschmd.
> >=20
> > +config SENSORS_GPIO_FAN
> > +       tristate "GPIO fan"
> > +       depends on GENERIC_GPIO
> > +       help
> > +         If you say yes here you get support for the GPIO connected fa=
n.
> > +
>=20
> "for GPIO connected fans.". Can be more than one.

My bad English...

>=20
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called gpio-fan.
> > +
> >  config SENSORS_G760A
> >         tristate "GMT G760A"
> >         depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e3c2484..5df7e4a 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_SENSORS_F71805F) +=3D f71805f.o
> >  obj-$(CONFIG_SENSORS_F71882FG) +=3D f71882fg.o
> >  obj-$(CONFIG_SENSORS_F75375S)  +=3D f75375s.o
> >  obj-$(CONFIG_SENSORS_FSCHMD)   +=3D fschmd.o
> > +obj-$(CONFIG_SENSORS_GPIO_FAN) +=3D gpio-fan.o
>=20
> "gp" is alphabetically after "g7". Please move.

It was the original place...

Ok, I have been confused with the Kconfig "sequence" order: put
SENSORS_GPIO_FAN before SENSORS_G760A seems wrong to me.

Why we don't have to respect the alphabetical order for Kconfig ?

>=20
> >  obj-$(CONFIG_SENSORS_G760A)    +=3D g760a.o
> >  obj-$(CONFIG_SENSORS_GL518SM)  +=3D gl518sm.o
> >  obj-$(CONFIG_SENSORS_GL520SM)  +=3D gl520sm.o
> > diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> > new file mode 100644
> > index 0000000..e3131a6
> > --- /dev/null
> > +++ b/drivers/hwmon/gpio-fan.c
> > @@ -0,0 +1,557 @@
> > +/*
> > + * gpio-fan.c - Hwmon driver for GPIO connected fan.
> > + *
> > + * Copyright (C) 2010 LaCie
> > + *
> > + * Author: Simon Guinot <sguinot@lacie.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/err.h>
> > +#include <linux/mutex.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio-fan.h>
> > +
> > +struct gpio_fan_data {
> > +       struct platform_device  *pdev;
> > +       struct device           *hwmon_dev;
> > +       struct mutex            lock; /* lock GPIOs operations. */
> > +       int                     num_ctrl;
> > +       unsigned                *ctrl;
> > +       int                     num_speed;
> > +       struct gpio_fan_speed   *speed;
> > +       int                     speed_index;
> > +#ifdef CONFIG_PM
> > +       int                     resume_speed;
> > +#endif
> > +       int                     pwm_enable;
>=20
> I would prefer a bool here. After all, that is what it is.

As automatic fan speed control is not supported, it make sense.

>=20
> > +       struct gpio_fan_alarm   *alarm;
> > +       struct work_struct      alarm_work;
> > +};
> > +
> > +/*
> > + * Alarm GPIO.
> > + */
> > +
> > +static void fan_alarm_notify(struct work_struct *ws)
> > +{
> > +       struct gpio_fan_data *fan_data =3D
> > +               container_of(ws, struct gpio_fan_data, alarm_work);
> > +
> > +       sysfs_notify(&fan_data->pdev->dev.kobj, NULL, "fan1_alarm");
> > +       kobject_uevent(&fan_data->pdev->dev.kobj, KOBJ_CHANGE);
> > +}
> > +
> > +static irqreturn_t fan_alarm_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_id;
> > +
> > +       schedule_work(&fan_data->alarm_work);
> > +
> > +       return IRQ_NONE;
> > +}
> > +
> > +static ssize_t show_fan_alarm(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       struct gpio_fan_alarm *alarm =3D fan_data->alarm;
> > +       int value =3D gpio_get_value(alarm->gpio);
> > +
> > +       if (alarm->active_low)
> > +               value =3D !value;
> > +
> > +       return sprintf(buf, "%d\n", value);
> > +}
> > +
> > +static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
> > +
> > +static int fan_alarm_init(struct gpio_fan_data *fan_data,
> > +                         struct gpio_fan_alarm *alarm)
> > +{
> > +       int err;
> > +       int alarm_irq;
> > +       struct platform_device *pdev =3D fan_data->pdev;
> > +
> > +       fan_data->alarm =3D alarm;
> > +
> > +       err =3D gpio_request(alarm->gpio, "GPIO fan alarm");
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D gpio_direction_input(alarm->gpio);
> > +       if (err)
> > +               goto err_free_gpio;
> > +
> > +       err =3D device_create_file(&pdev->dev, &dev_attr_fan1_alarm);
> > +       if (err)
> > +               goto err_free_gpio;
> > +
> > +       alarm_irq =3D gpio_to_irq(alarm->gpio);
> > +       if (alarm_irq < 0)
> > +               return 0;
> > +
> This confused me for a bit, so it may confuse others.=20
> Please add a note indicating that the above is not an error condition.

Ok.

>=20
> > +       INIT_WORK(&fan_data->alarm_work, fan_alarm_notify);
> > +       set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
> > +       err =3D request_irq(alarm_irq, fan_alarm_irq_handler, IRQF_SHAR=
ED,
> > +                         "GPIO fan alarm", fan_data);
> > +       if (err)
> > +               goto err_free_sysfs;
> > +
> > +       return 0;
> > +
> > +err_free_sysfs:
> > +       device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
> > +err_free_gpio:
> > +       gpio_free(alarm->gpio);
> > +
> > +       return err;
> > +}
> > +
> > +static void fan_alarm_free(struct gpio_fan_data *fan_data)
> > +{
> > +       struct platform_device *pdev =3D fan_data->pdev;
> > +       int alarm_irq =3D gpio_to_irq(fan_data->alarm->gpio);
> > +
> > +       if (alarm_irq >=3D 0)
> > +               free_irq(alarm_irq, fan_data);
> > +       device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
> > +       gpio_free(fan_data->alarm->gpio);
> > +}
> > +
> > +/*
> > + * Control GPIOs.
> > + */
> > +
> Please add a note indicating that the function must be called with the lo=
ck held
> except during initialization.
> Such as "Must be called with data->update_lock held, except during initia=
lization".

Ok.

>=20
> > +static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_va=
l)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < fan_data->num_ctrl; i++)
> > +               gpio_set_value(fan_data->ctrl[i], (ctrl_val >> i) & 1);
> > +}
> > +
> > +static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
> > +{
> > +       int i;
> > +       int ctrl_val =3D 0;
> > +
> > +       for (i =3D 0; i < fan_data->num_ctrl; i++) {
> > +               int value;
> > +
> > +               value =3D gpio_get_value(fan_data->ctrl[i]);
> > +               ctrl_val |=3D (value << i);
> > +       }
> > +       return ctrl_val;
> > +}
> > +
>=20
> 	"Must be called with data->update_lock held, except during initializatio=
n".

Ok.

>=20
> > +static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_in=
dex)
> > +{
> > +       if (fan_data->speed_index =3D=3D speed_index)
> > +               return;
> > +
> > +       __set_fan_ctrl(fan_data, fan_data->speed[speed_index].ctrl_val);
> > +       fan_data->speed_index =3D speed_index;
> > +}
> > +
> > +static int get_fan_speed(struct gpio_fan_data *fan_data)
>=20
> get_fan_speed_index() might be a better name. The function doesn't
> really return the speed, but an index to the speed table.

I am not sure how useful is the information provided by the '_index'
suffix. Add '_index' here force to add '_index' everywhere and make
long function names...

Anyway, I will change this.

>=20
> > +{
> > +       int ctrl_val =3D __get_fan_ctrl(fan_data);
> > +       int i;
> > +
> > +       for (i =3D 0; i < fan_data->num_speed; i++)
> > +               if (fan_data->speed[i].ctrl_val =3D=3D ctrl_val)
> > +                       return i;
> > +
> > +       dev_warn(&fan_data->pdev->dev,
> > +                "missing speed array entry for GPIO value %d\n", ctrl_=
val);
> > +
> 	0x%x might be better here.

Yes.

>=20
> > +       return -EINVAL;
> > +}
> > +
> > +static int rpm_to_speed(struct gpio_fan_data *fan_data, int rpm)
>=20
> rpm_to_speed_index would avoid confusion.
>=20
> > +{
> > +       struct gpio_fan_speed *speed =3D fan_data->speed;
> > +       int speed_index =3D fan_data->num_speed - 1; /* Maximum speed */
>=20
> You don't really need speed_index here.
>=20
> > +       int i;
> > +
> > +       for (i =3D 0; i < fan_data->num_speed; i++)
> > +               if (speed[i].rpm >=3D rpm) {
>=20
> Would it make more sense to return the closest rpm instead ?
>=20
> For example, if one sets a value of 1900, and the closest value
> in the table is 1800, it might make more sense to set the speed
> to 1800 and not to, say, 3000, if that is the next value.

On the other hand, you can set rpm to 500 and the closest value could be
0 and the fan stop (or don't start). That's a disturbing experience.
If you agree, I prefer to set the upper speed.

>=20
> No strong opinion, though. One might as well argue that it is safer
> to run at the higher speed.
>=20

Some fans have problems with the low speeds and needs a little boost to
start up.

> > +                       speed_index =3D i;
> > +                       break;
>=20
> 	return i;
>=20
> > +               }
> > +       return speed_index;
>=20
> 	return fan_data->num_speed - 1;

Yes.

>=20
> > +}
> > +
> > +static ssize_t show_pwm(struct device *dev,
> > +                       struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       u8 pwm =3D DIV_ROUND_CLOSEST(fan_data->speed_index * 255,
> > +                                  fan_data->num_speed - 1);
> > +
> > +       return sprintf(buf, "%d\n", pwm);
> > +}
> > +
> > +static ssize_t set_pwm(struct device *dev, struct device_attribute *at=
tr,
> > +                      const char *buf, size_t count)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       unsigned long pwm;
> > +       int speed_index;
> > +       int ret =3D count;
> > +
> > +       if (strict_strtoul(buf, 10, &pwm) || pwm > 255)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&fan_data->lock);
> > +
> > +       if (fan_data->pwm_enable !=3D 1) {
>=20
> 	if (!fan_data->pwm_enable) {
>=20
> > +               ret =3D -EPERM;
> > +               goto exit_unlock;
> > +       }
> > +
> > +       speed_index =3D DIV_ROUND_UP(pwm * (fan_data->num_speed - 1), 2=
55);
>=20
> The combination of DIV_ROUND_UP() and DIV_ROUND_CLOSEST() causes inconsis=
tency.
>=20
> Assume num_speed =3D 8, pwm is set to 128.
>=20
> set: 128 * (8 - 1) / 255 =3D 3.513 =3D=3D> 4
> get: 4 * 255 / (8 - 1) =3D 145.7 =3D=3D> 146
> set: 146 * (8 - 1) / 255 =3D 4.007 =3D=3D> 5
> get: 5 * 255 / (8 - 1) =3D 182.142 =3D=3D> 182
> set: 182 * (8 - 1) / 255 =3D 4.996 =3D=3D> 5
>=20
> Unless there is a really good reason to use DIV_ROUND_UP(), you might
> want to use DIV_ROUND_CLOSEST() instead.

This choice is coherent with the rpm interface one and the reason is the
same: start the fan even with a low value. In your example, 36 is first
speed threshold.

>=20
> > +       set_fan_speed(fan_data, speed_index);
> > +
> > +exit_unlock:
> > +       mutex_unlock(&fan_data->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static ssize_t show_pwm_enable(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +
> > +       return sprintf(buf, "%d\n", fan_data->pwm_enable);
> > +}
> > +
> > +static ssize_t set_pwm_enable(struct device *dev, struct device_attrib=
ute *attr,
> > +                             const char *buf, size_t count)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       unsigned long val;
> > +
> > +       if (strict_strtoul(buf, 10, &val) || val > 1)
> > +               return -EINVAL;
> > +
> > +       if (fan_data->pwm_enable =3D=3D val)
> > +               return count;
> > +
> > +       mutex_lock(&fan_data->lock);
> > +
> > +       fan_data->pwm_enable =3D val;
> > +
> > +       /* Disable manual control mode: set fan at full speed. */
> > +       if (val =3D=3D 0)
> > +               set_fan_speed(fan_data, fan_data->num_speed - 1);
> > +
> > +       mutex_unlock(&fan_data->lock);
> > +
> > +       return count;
> > +}
> > +
> > +static ssize_t show_pwm_mode(struct device *dev,
> > +                            struct device_attribute *attr, char *buf)
> > +{
> > +       return sprintf(buf, "0\n");
> > +}
> > +
> > +static ssize_t show_rpm_min(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +
> > +       return sprintf(buf, "%d\n", fan_data->speed[0].rpm);
> > +}
> > +
> > +static ssize_t show_rpm_max(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +
> > +       return sprintf(buf, "%d\n",
> > +                      fan_data->speed[fan_data->num_speed - 1].rpm);
> > +}
> > +
> > +static ssize_t show_rpm(struct device *dev,
> > +                       struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +
> > +       return sprintf(buf, "%d\n", fan_data->speed[fan_data->speed_ind=
ex].rpm);
> > +}
> > +
> > +static ssize_t set_rpm(struct device *dev, struct device_attribute *at=
tr,
> > +                      const char *buf, size_t count)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       unsigned long rpm;
> > +       int ret =3D count;
> > +
> > +       if (strict_strtoul(buf, 10, &rpm))
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&fan_data->lock);
> > +
> > +       if (fan_data->pwm_enable !=3D 1) {
>=20
> 	if (!fan_data->pwm_enable) {

Ok.

>=20
> > +               ret =3D -EPERM;
> > +               goto exit_unlock;
> > +       }
> > +
> > +       set_fan_speed(fan_data, rpm_to_speed(fan_data, rpm));
> > +
> > +exit_unlock:
> > +       mutex_unlock(&fan_data->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm);
> > +static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
> > +                  show_pwm_enable, set_pwm_enable);
> > +static DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL);
> > +static DEVICE_ATTR(fan1_min, S_IRUGO, show_rpm_min, NULL);
> > +static DEVICE_ATTR(fan1_max, S_IRUGO, show_rpm_max, NULL);
> > +static DEVICE_ATTR(fan1_input, S_IRUGO, show_rpm, NULL);
> > +static DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, show_rpm, set_rpm);
> > +
> > +static struct attribute *gpio_fan_ctrl_attributes[] =3D {
> > +       &dev_attr_pwm1.attr,
> > +       &dev_attr_pwm1_enable.attr,
> > +       &dev_attr_pwm1_mode.attr,
> > +       &dev_attr_fan1_input.attr,
> > +       &dev_attr_fan1_target.attr,
> > +       &dev_attr_fan1_min.attr,
> > +       &dev_attr_fan1_max.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group gpio_fan_ctrl_group =3D {
> > +       .attrs =3D gpio_fan_ctrl_attributes,
> > +};
> > +
> > +static int fan_ctrl_init(struct gpio_fan_data *fan_data,
> > +                        struct gpio_fan_platform_data *pdata)
> > +{
> > +       struct platform_device *pdev =3D fan_data->pdev;
> > +       int num_ctrl =3D pdata->num_ctrl;
> > +       unsigned *ctrl =3D pdata->ctrl;
> > +       int i, err;
> > +
> > +       for (i =3D 0; i < num_ctrl; i++) {
> > +               err =3D gpio_request(ctrl[i], "GPIO fan control");
> > +               if (err)
> > +                       goto err_free_gpio;
> > +
> > +               err =3D gpio_direction_output(ctrl[i], gpio_get_value(c=
trl[i]));
> > +               if (err) {
> > +                       gpio_free(ctrl[i]);
> > +                       goto err_free_gpio;
> > +               }
> > +       }
> > +
> > +       err =3D sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_grou=
p);
> > +       if (err)
> > +               goto err_free_gpio;
> > +
> > +       fan_data->num_ctrl =3D num_ctrl;
> > +       fan_data->ctrl =3D ctrl;
> > +       fan_data->num_speed =3D pdata->num_speed;
> > +       fan_data->speed =3D pdata->speed;
> > +       fan_data->pwm_enable =3D 1; /* Enable manual fan speed control.=
 */
>=20
> 	fan_data->pwm_enable =3D true;

Ok.

>=20
> > +       fan_data->speed_index =3D get_fan_speed(fan_data);
> > +       if (fan_data->speed_index < 0) {
> > +               /* Set fan speed to a known value. */
> > +               set_fan_speed(fan_data, fan_data->num_speed / 2);
> > +               dev_info(&pdev->dev, "set fan speed to %d rpm\n",
> > +                        fan_data->speed[fan_data->speed_index].rpm);
>=20
> I think a safer approach would be to return -ENODEV in this case.
> Better not to try any fan control at all if the GPIO bits report
> an unsupported value. It indicates that something is wrong.

Ok.

>=20
> > +       }
> > +
> > +       return 0;
> > +
> > +err_free_gpio:
> > +       for (i =3D i - 1; i >=3D 0; i--)
> > +               gpio_free(ctrl[i]);
> > +
> > +       return err;
> > +}
> > +
> > +static void fan_ctrl_free(struct gpio_fan_data *fan_data)
> > +{
> > +       struct platform_device *pdev =3D fan_data->pdev;
> > +       int i;
> > +
> > +       sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
> > +       for (i =3D 0; i < fan_data->num_ctrl; i++)
> > +               gpio_free(fan_data->ctrl[i]);
> > +}
> > +
> > +/*
> > + * Platform driver.
> > + */
> > +
> > +static ssize_t show_name(struct device *dev,
> > +                        struct device_attribute *attr, char *buf)
> > +{
> > +       return sprintf(buf, "gpio-fan\n");
> > +}
> > +
> > +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> > +
> > +static int __devinit gpio_fan_probe(struct platform_device *pdev)
> > +{
> > +       int err =3D 0;
> > +       struct gpio_fan_data *fan_data;
> > +       struct gpio_fan_platform_data *pdata =3D pdev->dev.platform_dat=
a;
> > +
> > +       if (!pdata)
> > +               return -EINVAL;
> > +
> > +       fan_data =3D kzalloc(sizeof(struct gpio_fan_data), GFP_KERNEL);
> > +       if (!fan_data)
> > +               return -ENOMEM;
> > +
> > +       fan_data->pdev =3D pdev;
> > +       platform_set_drvdata(pdev, fan_data);
> > +       mutex_init(&fan_data->lock);
> > +
> > +       /* Configure alarm GPIO if available. */
> > +       if (pdata->alarm) {
> > +               err =3D fan_alarm_init(fan_data, pdata->alarm);
> > +               if (err)
> > +                       goto err_free_data;
> > +       }
> > +
> > +       /* Configure control GPIOs if available. */
> > +       if (pdata->ctrl && pdata->num_ctrl) {
>=20
> You might want to check for pdata->num_ctrl > 0 here.
> It could be negative, which would be bad.

Yes.

>=20
> > +               if (!pdata->num_speed || !pdata->speed) {
>=20
> num_speed must be > 1. Otherwise there is a risk of division by zero if i=
t is =3D=3D 1.

Yes.

>=20
> > +                       err =3D -EINVAL;
> > +                       goto err_free_alarm;
> > +               }
> > +               err =3D fan_ctrl_init(fan_data, pdata);
> > +               if (err)
> > +                       goto err_free_alarm;
> > +       }
> > +
> > +       err =3D device_create_file(&pdev->dev, &dev_attr_name);
> > +       if (err)
> > +               goto err_free_ctrl;
> > +
> > +       /* Make this driver part of hwmon class. */
> > +       fan_data->hwmon_dev =3D hwmon_device_register(&pdev->dev);
> > +       if (IS_ERR(fan_data->hwmon_dev)) {
> > +               err =3D PTR_ERR(fan_data->hwmon_dev);
> > +               goto err_remove_name;
> > +       }
> > +
> > +       dev_info(&pdev->dev, "GPIO fan initialized\n");
> > +
> > +       return 0;
> > +
> > +err_remove_name:
> > +       device_remove_file(&pdev->dev, &dev_attr_name);
> > +err_free_ctrl:
> > +       if (fan_data->ctrl)
> > +               fan_ctrl_free(fan_data);
> > +err_free_alarm:
> > +       if (fan_data->alarm)
> > +               fan_alarm_free(fan_data);
> > +err_free_data:
> > +       platform_set_drvdata(pdev, NULL);
> > +       kfree(fan_data);
> > +
> > +       return err;
> > +}
> > +
> > +static int __devexit gpio_fan_remove(struct platform_device *pdev)
> > +{
> > +       struct gpio_fan_data *fan_data =3D platform_get_drvdata(pdev);
> > +
> > +       hwmon_device_unregister(fan_data->hwmon_dev);
> > +       device_remove_file(&pdev->dev, &dev_attr_name);
> > +       if (fan_data->alarm)
> > +               fan_alarm_free(fan_data);
> > +       if (fan_data->ctrl)
> > +               fan_ctrl_free(fan_data);
> > +       kfree(fan_data);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int gpio_fan_suspend(struct platform_device *pdev, pm_message_t=
 state)
> > +{
> > +       struct gpio_fan_data *fan_data =3D platform_get_drvdata(pdev);
> > +
> > +       if (fan_data->ctrl) {
> > +               fan_data->resume_speed =3D fan_data->speed_index;
> > +               set_fan_speed(fan_data, 0);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int gpio_fan_resume(struct platform_device *pdev)
> > +{
> > +       struct gpio_fan_data *fan_data =3D platform_get_drvdata(pdev);
> > +
> > +       if (fan_data->ctrl)
> > +               set_fan_speed(fan_data, fan_data->resume_speed);
> > +
> > +       return 0;
> > +}
> > +#else
> > +#define gpio_fan_suspend NULL
> > +#define gpio_fan_resume NULL
> > +#endif
> > +
> > +static struct platform_driver gpio_fan_driver =3D {
> > +       .probe          =3D gpio_fan_probe,
> > +       .remove         =3D __devexit_p(gpio_fan_remove),
> > +       .suspend        =3D gpio_fan_suspend,
> > +       .resume         =3D gpio_fan_resume,
> > +       .driver =3D {
> > +               .name   =3D "gpio-fan",
> > +       },
> > +};
> > +
> > +static int __init gpio_fan_init(void)
> > +{
> > +       return platform_driver_register(&gpio_fan_driver);
> > +}
> > +
> > +static void __exit gpio_fan_exit(void)
> > +{
> > +       platform_driver_unregister(&gpio_fan_driver);
> > +}
> > +
> > +module_init(gpio_fan_init);
> > +module_exit(gpio_fan_exit);
> > +
> > +MODULE_AUTHOR("Simon Guinot <sguinot@lacie.com>");
> > +MODULE_DESCRIPTION("GPIO FAN driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:gpio-fan");
> > diff --git a/include/linux/gpio-fan.h b/include/linux/gpio-fan.h
> > new file mode 100644
> > index 0000000..0966591
> > --- /dev/null
> > +++ b/include/linux/gpio-fan.h
> > @@ -0,0 +1,36 @@
> > +/*
> > + * include/linux/gpio-fan.h
> > + *
> > + * Platform data structure for GPIO fan driver
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#ifndef __LINUX_GPIO_FAN_H
> > +#define __LINUX_GPIO_FAN_H
> > +
> > +struct gpio_fan_alarm {
> > +       unsigned        gpio;
> > +       unsigned        active_low;
> > +};
> > +
> > +struct gpio_fan_speed {
> > +       int rpm;
> > +       int ctrl_val;
> > +};
> > +
> > +struct gpio_fan_platform_data {
> > +       int                     num_ctrl;
> > +       unsigned                *ctrl;  /* fan control GPIOs. */
> > +       struct gpio_fan_alarm   *alarm; /* fan alarm GPIO. */
> > +       /*
> > +        * Speed conversion array: rpm from/to GPIO bit field.
> > +        * This array _must_ be sorted in ascending rpm order.
> > +        */
> > +       int                     num_speed;
> > +       struct gpio_fan_speed   *speed;
> > +};
> > +
> > +#endif /* __LINUX_GPIO_FAN_H */
> > --
> > 1.6.3.1
> >=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzASOIACgkQgtp0PDeOcDrpOACgmTkgxD9IPEXCYUZHWKH0fQV3
1w4An1Q7dB6z96y8S1YuWKUagorLpsr5
=kKP0
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--


--===============2365097002716015987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2365097002716015987==--
