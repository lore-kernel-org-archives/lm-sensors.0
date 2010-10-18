From: Simon Guinot <simon@sequanux.org>
Date: Mon, 18 Oct 2010 20:36:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101018203610.GD29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7097407147331999104=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
In-Reply-To: <20101018160830.GB9033@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============7097407147331999104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thanks for your review.

On Mon, Oct 18, 2010 at 09:08:30AM -0700, Guenter Roeck wrote:
> On Sun, Oct 17, 2010 at 11:50:11AM -0400, Simon Guinot wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> >=20
> > This patch adds hwmon support for the GPIO connected fan.
> >=20
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> >=20
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
>=20
> Hi Simon,
>=20
> good start. Bunch of comments inline. Our mailer was nice enough to repla=
ce tabs
> with blanks, thanks to our friends at MicroSomething, so I could not run =
the patch
> through checkpatch.pl. Hope you did that.

Yes, I did.

>=20
> > ---
> >  drivers/hwmon/Kconfig    |    9 +
> >  drivers/hwmon/Makefile   |    1 +
> >  drivers/hwmon/gpio-fan.c |  508 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/gpio-fan.h |   43 ++++
> >  4 files changed, 561 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/gpio-fan.c
> >  create mode 100644 include/linux/gpio-fan.h
> >=20
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4d4d09b..1dc57c1 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -399,6 +399,15 @@ config SENSORS_GL520SM
> >           This driver can also be built as a module.  If so, the module
> >           will be called gl520sm.
> >=20
> > +config SENSORS_GPIO_FAN
> > +       tristate "GPIO fan"
> > +       depends on GENERIC_GPIO
> > +       help
> > +         If you say yes here you get support for the GPIO connected fa=
n.
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called gpio-fan.
> > +
>=20
> Can you move this up a bit, ahead of SENSORS_FSCHMD ? Trying to stay in s=
equence.

Ok.

>=20
> >  config SENSORS_CORETEMP
> >         tristate "Intel Core/Core2/Atom temperature sensor"
> >         depends on X86 && PCI && EXPERIMENTAL
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e3c2484..a793e28 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_SENSORS_FSCHMD)  +=3D fschmd.o
> >  obj-$(CONFIG_SENSORS_G760A)    +=3D g760a.o
> >  obj-$(CONFIG_SENSORS_GL518SM)  +=3D gl518sm.o
> >  obj-$(CONFIG_SENSORS_GL520SM)  +=3D gl520sm.o
> > +obj-$(CONFIG_SENSORS_GPIO_FAN) +=3D gpio-fan.o
> >  obj-$(CONFIG_SENSORS_ULTRA45)  +=3D ultra45_env.o
> >  obj-$(CONFIG_SENSORS_HDAPS)    +=3D hdaps.o
> >  obj-$(CONFIG_SENSORS_I5K_AMB)  +=3D i5k_amb.o
> > diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> > new file mode 100644
> > index 0000000..6cc8205
> > --- /dev/null
> > +++ b/drivers/hwmon/gpio-fan.c
> > @@ -0,0 +1,508 @@
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
> > +       int                     ctrl_val;
> > +       int                     num_speed;
> > +       struct gpio_fan_speed   *speed;
> > +       int                     pwm_enable;
> > +       struct gpio_fan_alarm   *alarm;
> > +       struct work_struct      alarm_work;
> > +       void (*platform_set_ctrl)(int num_ctrl, unsigned *ctrl, int ctr=
l_val);
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
> > +       return IRQ_HANDLED;
> > +}
> You are assuming that the irq does not have to be shared, and
> will always be handled. This may interfer with other drivers
> using the same IRQ for other GPIO pins.

Yes, you are right.

>=20
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
> > +static int __devinit
> > +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *=
alarm)
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
> > +       INIT_WORK(&fan_data->alarm_work, fan_alarm_notify);
> > +       alarm_irq =3D gpio_to_irq(alarm->gpio);
>=20
> gpio_to_irq() can return an error. Please check (I see that other drivers
> often don't check the return value, but that may be platform specific kno=
wledge).
=20
Yes, I have to check the returned value.

>=20
> Also, what happens if the gpio pin does not support interrupts in the fir=
st place ?
> Still need to be able to support alarms that case.

Good idea.

>=20
> > +       set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
> > +       err =3D request_irq(alarm_irq, fan_alarm_irq_handler, 0,
> > +                         "GPIO fan alarm", fan_data);
>=20
> Why not IRQF_SHARED ?

Simply because I have missed that.=20

>=20
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
> > +static void __devexit fan_alarm_free(struct gpio_fan_data *fan_data)
> > +{
> > +       struct platform_device *pdev =3D fan_data->pdev;
> > +
> > +       free_irq(gpio_to_irq(fan_data->alarm->gpio), fan_data);
>=20
> Please check for gpio_to_irq() error return.

Yes.

>=20
> > +       device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
> > +       gpio_free(fan_data->alarm->gpio);
> > +}
> > +
> > +/*
> > + * Control GPIOs.
> > + */
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
> > +static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_va=
l)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < fan_data->num_ctrl; i++) {
> > +               int value =3D !!(ctrl_val & (1 << i));
> > +
> 	value =3D (ctrl_val & (1 >> i));
>     would be much simpler and easier to understand.
>     Actually, you would not need 'value' in the first place.

I will simplify this function.

>=20
> > +               gpio_set_value(fan_data->ctrl[i], value);
> > +       }
> > +}
> > +
> > +static void set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_val)
> > +{
> > +       if (fan_data->platform_set_ctrl)
> > +               fan_data->platform_set_ctrl(fan_data->num_ctrl, fan_dat=
a->ctrl,
> > +                                           ctrl_val);
> > +       else
> > +               __set_fan_ctrl(fan_data, ctrl_val);
> > +
> > +       fan_data->ctrl_val =3D ctrl_val;
> > +}
> > +
> > +static int rpm_to_ctrl(struct gpio_fan_data *fan_data, int rpm)
> > +{
> > +       struct gpio_fan_speed *speed =3D fan_data->speed;
> > +       int num_speed =3D fan_data->num_speed;
> > +       int ctrl_val =3D speed[num_speed - 1].ctrl_val; /* Maximum spee=
d */
> > +       int i;
> > +
> > +       for (i =3D 0; i < num_speed; i++) {
>=20
> 	{ } not needed here.

Ok.

>=20
> > +               if (speed[i].rpm >=3D rpm) {
> > +                       ctrl_val =3D speed[i].ctrl_val;
> > +                       break;
> > +               }
> > +       }
> > +       return ctrl_val;
> > +}
> > +
> > +static int ctrl_to_rpm(struct gpio_fan_data *fan_data, int ctrl_val, i=
nt *rpm)
> > +{
>=20
> Since rpm is presumably always positive, you don't need a pointer to rpm.
> Return value can be rpm or error.

Yes.

>=20
> > +       struct gpio_fan_speed *speed =3D fan_data->speed;
> > +       int num_speed =3D fan_data->num_speed;
> > +       int i;
> > +
> > +       for (i =3D 0; i < num_speed; i++) {
>=20
> 	{ } not needed here.

Yes.

>=20
> > +               if (speed[i].ctrl_val =3D=3D ctrl_val) {
> > +                       *rpm =3D speed[i].rpm;
> > +                       return 0;
> > +               }
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> > +static int pwm_to_rpm(struct gpio_fan_data *fan_data, u8 pwm)
> > +{
> > +       int rpm_min =3D fan_data->speed[0].rpm;
> > +       int rpm_max =3D fan_data->speed[fan_data->num_speed - 1].rpm;
> > +
> > +       return rpm_min + DIV_ROUND_UP((rpm_max - rpm_min), 255) * pwm;
> > +}
> > +
> > +static u8 rpm_to_pwm(struct gpio_fan_data *fan_data, int rpm)
> > +{
> > +       int rpm_min =3D fan_data->speed[0].rpm;
> > +       int rpm_max =3D fan_data->speed[fan_data->num_speed - 1].rpm;
> > +
> > +       return (rpm - rpm_min) / DIV_ROUND_UP((rpm_max - rpm_min), 255);
> > +}
> > +
> > +static ssize_t show_pwm(struct device *dev,
> > +                       struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       int rpm;
> > +       int ret;
> > +
> > +       ret =3D ctrl_to_rpm(fan_data, fan_data->ctrl_val, &rpm);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return sprintf(buf, "%d\n", rpm_to_pwm(fan_data, rpm));
> > +}
> > +
> I don't really understand the value of supporting pwm attributes,
> since you have to convert those to rpm anyway. Why not just stick
> with fan1_input and fan1_target ? This would simplify the code a lot.

I don't know very well the hwmon API. I have simply been fooled by the
sysfs-interface document which claim that fan[1-*]_target only make
sense for a closed-loop fan. Moreover, I was expecting gpio-fan to be
compliant with the fancontrol shell script...

But anyway, you are right. I just don't want the pwm interface.

>=20
> fan1_min and fan1_max should be supported as well, especially
> since the information is provided anyway.

Yes.

>=20
> > +static ssize_t set_pwm(struct device *dev, struct device_attribute *at=
tr,
> > +                      const char *buf, size_t count)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       unsigned long pwm;
> > +       int ctrl_val;
> > +       int ret =3D count;
> > +
> > +       if (strict_strtoul(buf, 10, &pwm) || pwm > 255)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&fan_data->lock);
> > +
> > +       if (fan_data->pwm_enable !=3D 1) {
> > +               ret =3D -EPERM;
> > +               goto exit_unlock;
> > +       }
> > +
> > +       ctrl_val =3D rpm_to_ctrl(fan_data, pwm_to_rpm(fan_data, (u8) pw=
m));
> > +       if (ctrl_val !=3D fan_data->ctrl_val)
> > +               set_fan_ctrl(fan_data, ctrl_val);
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
> > +       int ctrl_val;
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
> > +       if (val =3D=3D 0) {
> > +               ctrl_val =3D fan_data->speed[fan_data->num_speed - 1].c=
trl_val;
> > +               if (ctrl_val !=3D fan_data->ctrl_val)
> > +                       set_fan_ctrl(fan_data, ctrl_val);
> > +       }
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
> > +static ssize_t show_rpm(struct device *dev,
> > +                       struct device_attribute *attr, char *buf)
> > +{
> > +       struct gpio_fan_data *fan_data =3D dev_get_drvdata(dev);
> > +       int ret;
> > +       int rpm;
> > +
> > +       ret =3D ctrl_to_rpm(fan_data, fan_data->ctrl_val, &rpm);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return sprintf(buf, "%d\n", rpm);
> > +}
> > +
> > +static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm);
> > +static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
> > +                  show_pwm_enable, set_pwm_enable);
> > +static DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL);
> > +static DEVICE_ATTR(fan1_input, S_IRUGO, show_rpm, NULL);
> > +
> > +static struct attribute *gpio_fan_ctrl_attributes[] =3D {
> > +       &dev_attr_pwm1.attr,
> > +       &dev_attr_pwm1_enable.attr,
> > +       &dev_attr_pwm1_mode.attr,
> > +       &dev_attr_fan1_input.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group gpio_fan_ctrl_group =3D {
> > +       .attrs =3D gpio_fan_ctrl_attributes,
> > +};
> > +
> > +static int __devinit fan_ctrl_init(struct gpio_fan_data *fan_data,
> > +                                  struct gpio_fan_platform_data *pdata)
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
> > +       fan_data->platform_set_ctrl =3D pdata->set_ctrl;
> > +       fan_data->num_speed =3D pdata->num_speed;
> > +       fan_data->speed =3D pdata->speed;
> > +       fan_data->pwm_enable =3D 1; /* Enable manual fan speed control.=
 */
> > +       if (pdata->get_ctrl)
> > +               fan_data->ctrl_val =3D pdata->get_ctrl(num_ctrl, ctrl);
> > +       else
> > +               fan_data->ctrl_val =3D __get_fan_ctrl(fan_data);
> > +
> > +       return 0;
> > +
> > +err_free_gpio:
> > +       for (i =3D i - 1; i >=3D 0; i--)
> > +               gpio_free(ctrl[i]);
> > +
> This misses the most recently allocated gpio pin if gpio_direction_output=
() failed.

The gpio is freed above while handling the gpio_direction_output() error.

>=20
> > +       return err;
> > +}
> > +
> > +static void __devexit fan_ctrl_free(struct gpio_fan_data *fan_data)
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
> > +               if (!pdata->num_speed || !pdata->speed) {
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
> Might be a good idea to add a notion of which fan was initialized.
> After all, there could be more than one.

dev_info() don't do it for me ? anyway, I will check this too.

>=20
> > +       return 0;
> > +
> > +err_remove_name:
> > +       device_remove_file(&pdev->dev, &dev_attr_name);
> > +err_free_ctrl:
> > +       fan_ctrl_free(fan_data);
>=20
> Might want to check for fan_data->ctrl to be consistent with the code bel=
ow.

Of course...

>=20
> > +err_free_alarm:
> > +       fan_alarm_free(fan_data);
>=20
> This will crash if fan_data->alarm is NULL.

=2E..

>=20
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
> > +static struct platform_driver gpio_fan_driver =3D {
> > +       .probe  =3D gpio_fan_probe,
> > +       .remove =3D __devexit_p(gpio_fan_remove),
> > +       .driver =3D {
> > +               .name =3D "gpio-fan",
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
> > +       return;
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
> > index 0000000..58f0930
> > --- /dev/null
> > +++ b/include/linux/gpio-fan.h
> > @@ -0,0 +1,43 @@
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
> > +       /*
> > +        * This functions can be supplied if some specific operations a=
re
> > +        * required to get/set a fan control (handle a latch enable GPI=
O,
> > +        * prevent from writing some transitional control value, etc...)
> > +        */
> > +       int     (*get_ctrl)(int num_ctrl, unsigned *ctrl);
> > +       void    (*set_ctrl)(int num_ctrl, unsigned *ctrl, int ctrl_val);
>=20
> Not sure if this is a good/useful API. It expects that the called function
> identifies the fan from the ctrl[] array. Not sure how clumsy the resulti=
ng code
> might be. It may be better to leave the API out for now until someone act=
ually
> writes a driver (hint, hint, dns323) using it.

I agree and I will happily throw away the clumsy API :)

Simon

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky8r7oACgkQgtp0PDeOcDqEFQCZAWbuH0avACMmt7mgYuzWIB3F
D1QAnR7CMSaEIoYmo266pt/lk4CWyB2/
=EnEV
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--


--===============7097407147331999104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7097407147331999104==--
