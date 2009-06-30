From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 30 Jun 2009 02:32:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Message-Id: <20090630023234.GD10652@dtor-d630.eng.vmware.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A448926.1030701@samsung.com> <5d5443650906260322n3c4f5f79r3290ebce2e331234@mail.gmail.com>
In-Reply-To: <5d5443650906260322n3c4f5f79r3290ebce2e331234@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Fri, Jun 26, 2009 at 03:52:21PM +0530, Trilok Soni wrote:
> Hi Minkyu,
>=20
> Adding linux-input ML, as driver is using linux input subsystem.
>=20
> On Fri, Jun 26, 2009 at 2:09 PM, Minkyu Kang<mk7.kang@samsung.com> wrote:
> > The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
> > This patch adds support the GP2A002 sensor
> >
> > Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> > Signed-off-by: Suchang Woo <suchang.woo@samsung.com>
> > ---
> > =A0drivers/hwmon/Kconfig =A0 =A0| =A0 =A07 +
> > =A0drivers/hwmon/Makefile =A0 | =A0 =A01 +
> > =A0drivers/hwmon/gp2ap002.c | =A0471 ++++++++++++++++++++++++++++++++++=
++++++++++++
> > =A0include/linux/gp2ap002.h | =A0 21 ++
> > =A04 files changed, 500 insertions(+), 0 deletions(-)
> > =A0create mode 100644 drivers/hwmon/gp2ap002.c
> > =A0create mode 100644 include/linux/gp2ap002.h
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 2d50166..cc4e200 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1017,6 +1017,13 @@ config SENSORS_APPLESMC
> > =A0 =A0 =A0 =A0 =A0Say Y here if you have an applicable laptop and want=
 to experience
> > =A0 =A0 =A0 =A0 =A0the awesome power of applesmc.
> >
> > +config SENSORS_GP2AP002
> > + =A0 =A0 =A0 tristate "GP2AP002 series Proximity/Ambient Sensor"
> > + =A0 =A0 =A0 depends on HWMON && I2C
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 This driver provides support for Proximity/Ambient Se=
nsor.
> > +
> > +
> > =A0config HWMON_DEBUG_CHIP
> > =A0 =A0 =A0 =A0bool "Hardware Monitoring Chip debugging messages"
> > =A0 =A0 =A0 =A0default n
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b793dce..5dd1671 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_FSCPOS) =A0+=3D fscpos.o
> > =A0obj-$(CONFIG_SENSORS_G760A) =A0 =A0+=3D g760a.o
> > =A0obj-$(CONFIG_SENSORS_GL518SM) =A0+=3D gl518sm.o
> > =A0obj-$(CONFIG_SENSORS_GL520SM) =A0+=3D gl520sm.o
> > +obj-$(CONFIG_SENSORS_GP2AP002) +=3D gp2ap002.o
> > =A0obj-$(CONFIG_SENSORS_ULTRA45) =A0+=3D ultra45_env.o
> > =A0obj-$(CONFIG_SENSORS_HDAPS) =A0 =A0+=3D hdaps.o
> > =A0obj-$(CONFIG_SENSORS_I5K_AMB) =A0+=3D i5k_amb.o
> > diff --git a/drivers/hwmon/gp2ap002.c b/drivers/hwmon/gp2ap002.c
> > new file mode 100644
> > index 0000000..6861584
> > --- /dev/null
> > +++ b/drivers/hwmon/gp2ap002.c
> > @@ -0,0 +1,471 @@
> > +/*
> > + * =A0gp2ap002.c - Proximity/Ambient light sensor
> > + *
> > + * =A0Copyright (C) 2009 Samsung Electronics
> > + * =A0Minkyu Kang <mk7.kang@samsung.com>
> > + * =A0Suchang Woo <suchang.woo@samsung.com>
> > + * =A0Kyungmin Park <kyungmin.park@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/mutex.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +#include <linux/input.h>
> > +#include <linux/gp2ap002.h>
> > +
> > +#define GP2AP002_PROX =A0 =A0 =A0 =A0 =A00x00 =A0 =A0/* Read Only */
> > +#define GP2AP002_GAIN =A0 =A0 =A0 =A0 =A00x01
> > +#define GP2AP002_HYS =A0 =A0 =A0 =A0 =A0 0x02
> > +#define GP2AP002_CYCLE =A0 =A0 =A0 =A0 0x03
> > +#define GP2AP002_OPMOD =A0 =A0 =A0 =A0 0x04
> > +#define GP2AP002_CON =A0 =A0 =A0 =A0 =A0 0x06
> > +
> > +#define PROX_VO_NO_DETECT =A0 =A0 =A0(0 << 0)
> > +#define PROX_VO_DETECT =A0 =A0 =A0 =A0 (1 << 0)
> > +
> > +#define GAIN_LED0_SMALL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0 << 3)
> > +#define GAIN_LED0_LARGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
> > +
> > +#define HYS_HYSD =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 7)
> > +#define HYS_HYSC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
> > +#define HYS_HYSC0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 5)
> > +#define HYS_HYSF3 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
> > +#define HYS_HYSF2 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> > +#define HYS_HYSF1 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> > +#define HYS_HYSF0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> > +
> > +#define OPMOD_SSD_SHUTDOWN =A0 =A0 (0 << 0)
> > +#define OPMOD_SSD_OPERATING =A0 =A0(1 << 0)
> > +#define OPMOD_VCON_NORMAL =A0 =A0 =A0(0 << 1)
> > +#define OPMOD_VCON_IRQ =A0 =A0 =A0 =A0 (1 << 1)
> > +
> > +#define CON_OCON1 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
> > +#define CON_OCON0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
> > +
> > +#define GP2AP002_MAX_LUX =A0 =A0 =A0 10
> > +
> > +static int lux_table[GP2AP002_MAX_LUX] =3D {
> > + =A0 =A0 =A0 1, 165, 288, 497, 869, 1532, 2692, 4692, 8280, 100000,
> > +};
> > +
> > +struct gp2ap002_chip {
> > + =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;
> > + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> > + =A0 =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*idev;
> > + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
> > + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock;
> > +
> > + =A0 =A0 =A0 void (*power_enable)(int onoff);
> > + =A0 =A0 =A0 int (*get_adc)(void);
> > + =A0 =A0 =A0 int vo_gpio;
> > +
> > + =A0 =A0 =A0 /* Proximity */
> > + =A0 =A0 =A0 int enable;
> > + =A0 =A0 =A0 int mode;
> > + =A0 =A0 =A0 int vo;
> > + =A0 =A0 =A0 /* Ambient Light */
> > + =A0 =A0 =A0 int adc;
> > + =A0 =A0 =A0 int level;
> > +};
> > +
> > +static int gp2ap002_write_reg(struct i2c_client *client, int reg, u8 v=
alue)
> > +{
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, reg, value);
> > +
> > + =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: err %d\n", __f=
unc__, ret);
> > +
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static int gp2ap002_read_reg(struct i2c_client *client, int reg)
> > +{
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(client, reg);
> > +
> > + =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: err %d\n", __f=
unc__, ret);
> > +
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static void gp2ap002_get_vo(struct gp2ap002_chip *chip)
> > +{
> > + =A0 =A0 =A0 if (chip->mode =3D OPMOD_VCON_IRQ) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->vo =3D gp2ap002_read_reg(chip->clie=
nt,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GP2AP002_=
PROX) & PROX_VO_DETECT;
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->vo =3D !gpio_get_value(chip->vo_gpi=
o);
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static void gp2ap002_get_adc(struct gp2ap002_chip *chip)
> > +{
> > + =A0 =A0 =A0 if (chip->get_adc)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->adc =3D chip->get_adc();
> > +}
> > +
> > +static void gp2ap002_get_level(struct gp2ap002_chip *chip)
> > +{
> > + =A0 =A0 =A0 int i;
> > +
> > + =A0 =A0 =A0 gp2ap002_get_adc(chip);
> > +
> > + =A0 =A0 =A0 for (i =3D 0; i < GP2AP002_MAX_LUX; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lux_table[i] > chip->adc) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->level =3D i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static void gp2ap002_set_mode(struct gp2ap002_chip *chip, int enable)
> > +{
> > + =A0 =A0 =A0 if (enable =3D chip->enable)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > + =A0 =A0 =A0 chip->enable =3D enable;
> > + =A0 =A0 =A0 chip->vo =3D 0;
> > +
> > + =A0 =A0 =A0 gp2ap002_write_reg(chip->client, GP2AP002_OPMOD, OPMOD_SS=
D_SHUTDOWN);
> > +
> > + =A0 =A0 =A0 if (enable) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gp2ap002_write_reg(chip->client, GP2AP002=
_OPMOD,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPMOD_SSD=
_OPERATING | chip->mode);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gp2ap002_get_vo(chip);
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static void gp2ap002_set_enable(struct gp2ap002_chip *chip, const char=
 *buf)
> > +{

simple_strtoul() here please.

> > + =A0 =A0 =A0 if (!strncmp(buf, "1", 1))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gp2ap002_set_mode(chip, 1);
> > + =A0 =A0 =A0 else if (!strncmp(buf, "0", 1))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gp2ap002_set_mode(chip, 0);
> > +}
> > +
> > +static void gp2ap002_update_data(struct gp2ap002_chip *chip)
> > +{
> > + =A0 =A0 =A0 gp2ap002_get_vo(chip);
> > + =A0 =A0 =A0 enable_irq(chip->client->irq);
> > +}
> > +
> > +static void gp2ap002_work(struct work_struct *work)
> > +{
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D container_of(work,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gp2ap002_chip, wor=
k);
> > +
> > + =A0 =A0 =A0 mutex_lock(&chip->lock);

What exactly do we protect here? I don't see any concurrency...

> > +
> > + =A0 =A0 =A0 gp2ap002_update_data(chip);
> > +
> > + =A0 =A0 =A0 input_report_abs(chip->idev, ABS_DISTANCE, chip->vo);
> > + =A0 =A0 =A0 input_sync(chip->idev);
> > +
> > + =A0 =A0 =A0 mutex_unlock(&chip->lock);
> > +}
> > +
> > +static irqreturn_t gp2ap002_irq(int irq, void *data)
> > +{
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D data;
> > +
> > + =A0 =A0 =A0 if (!work_pending(&chip->work)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(irq);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&chip->work);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&chip->client->dev, "work pending=
\n");
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return IRQ_HANDLED;
> > +}
> > +
> > +#define GP2AP002_OUTPUT(name, field) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > +static ssize_t gp2ap002_show_##name(struct device *dev, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *buf)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > +{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D dev_get_drvdata(dev); =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 gp2ap002_get_##name(chip); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 return sprintf(buf, "%d\n", chip->field); =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > +} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > +static SENSOR_DEVICE_ATTR(name, S_IRUGO, gp2ap002_show_##name, NULL, 0=
);
> > +
> > +#define GP2AP002_INPUT(name, field) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > +static ssize_t gp2ap002_store_##name(struct device *dev, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 struct device_attribute *attr, const char *buf, size_t co=
unt) =A0 \
> > +{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D dev_get_drvdata(dev); =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 if (!count) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL; =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 gp2ap002_set_##name(chip, buf); =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 return count; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > +} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > +static ssize_t gp2ap002_show_##name(struct device *dev, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *attr, char *buf)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > +{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D dev_get_drvdata(dev); =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\
> > + =A0 =A0 =A0 return sprintf(buf, "%d\n", chip->field); =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > +} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> > +static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gp2ap002_show_##name, gp2ap002_store_##na=
me, 0);
> > +
> > +GP2AP002_OUTPUT(vo, vo);
> > +GP2AP002_INPUT(enable, enable);
> > +GP2AP002_OUTPUT(adc, adc);
> > +GP2AP002_OUTPUT(level, level);
> > +
> > +static struct attribute *proximity_attributes[] =3D {
> > + =A0 =A0 =A0 &sensor_dev_attr_vo.dev_attr.attr,
> > + =A0 =A0 =A0 &sensor_dev_attr_enable.dev_attr.attr,
> > + =A0 =A0 =A0 NULL
> > +};
> > +
> > +static struct attribute *ambient_attributes[] =3D {
> > + =A0 =A0 =A0 &sensor_dev_attr_adc.dev_attr.attr,
> > + =A0 =A0 =A0 &sensor_dev_attr_level.dev_attr.attr,
> > + =A0 =A0 =A0 NULL
> > +};
> > +
> > +static const struct attribute_group proximity_group =3D {
> > + =A0 =A0 =A0 .name =3D "proximity",
> > + =A0 =A0 =A0 .attrs =3D proximity_attributes,
> > +};
> > +
> > +static const struct attribute_group ambient_group =3D {
> > + =A0 =A0 =A0 .name =3D "ambient",
> > + =A0 =A0 =A0 .attrs =3D ambient_attributes,
> > +};
> > +
> > +static void gp2ap002_unregister_input_device(struct gp2ap002_chip *chi=
p)
> > +{
> > + =A0 =A0 =A0 struct i2c_client *client =3D chip->client;
> > +
> > + =A0 =A0 =A0 if (client->irq > 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(client->irq, chip);
> > +

I don't see the work being shut off here. That means that it can still
try to enable freed irq or even cause oops if kevend is backed up...

Overall this driver could benefit from threaded IRQ facility I think.

> > + =A0 =A0 =A0 input_unregister_device(chip->idev);
> > + =A0 =A0 =A0 input_free_device(chip->idev);
>=20
> Please see comment below.
>=20
> > +}
> > +
> > +static int gp2ap002_register_input_device(struct gp2ap002_chip *chip)
> > +{
> > + =A0 =A0 =A0 struct i2c_client *client =3D chip->client;
> > + =A0 =A0 =A0 struct input_dev *idev;
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 idev =3D chip->idev =3D input_allocate_device();
> > + =A0 =A0 =A0 if (!idev) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "allocating input d=
evice is failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_alloc;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 idev->name =3D "GP2AP002 OpticalSensor";
>=20
> maybe idev->phys also good to add.
>=20
> > + =A0 =A0 =A0 idev->id.bustype =3D BUS_I2C;
> > + =A0 =A0 =A0 idev->dev.parent =3D &client->dev;
> > + =A0 =A0 =A0 idev->evbit[0] =3D BIT_MASK(EV_ABS);
> > +
> > + =A0 =A0 =A0 input_set_abs_params(idev, ABS_DISTANCE, 0, 1, 0, 0);
> > +
> > + =A0 =A0 =A0 input_set_drvdata(idev, chip);
> > +
> > + =A0 =A0 =A0 ret =3D input_register_device(idev);
> > + =A0 =A0 =A0 if (ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "registering input =
device is failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_reg;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (client->irq > 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long irq_flag =3D IRQF_DISABLED;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chip->mode =3D OPMOD_VCON_IRQ)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_flag |=3D IRQF_TRIGGE=
R_FALLING;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_flag |=3D IRQF_TRIGGE=
R_FALLING | IRQF_TRIGGER_RISING;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(client->irq, gp2ap002=
_irq, irq_flag,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "GP2AP002=
 OpticalSensor", chip);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "ca=
n't get IRQ %d, ret %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 client->irq, ret);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_irq;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return 0;
> > +
> > +error_irq:
> > + =A0 =A0 =A0 input_unregister_device(idev);
> > +error_reg:
> > + =A0 =A0 =A0 input_free_device(idev);
>=20
> Please put idev=3DNULL after input_unregister_device call, as idev is
> ref-counted and input_free_device is not required after
> input_unregister_device.
>=20
> > +error_alloc:
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +
> > +static int gp2ap002_probe(struct i2c_client *client,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_devi=
ce_id *id)
> > +{
>=20
>=20
> __devinit.
>=20
> > + =A0 =A0 =A0 struct i2c_adapter *adapter =3D to_i2c_adapter(client->de=
v.parent);
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip;
> > + =A0 =A0 =A0 struct gp2ap002_platform_data *pdata;
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE=
))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> > +
> > + =A0 =A0 =A0 chip =3D kzalloc(sizeof(struct gp2ap002_chip), GFP_KERNEL=
);
> > + =A0 =A0 =A0 if (!chip)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > +
> > + =A0 =A0 =A0 pdata =3D client->dev.platform_data;
> > +
> > + =A0 =A0 =A0 chip->client =3D client;
> > + =A0 =A0 =A0 i2c_set_clientdata(client, chip);
> > +
> > + =A0 =A0 =A0 chip->dev =3D hwmon_device_register(&client->dev);
> > + =A0 =A0 =A0 if (IS_ERR(chip->dev)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Register=
ing to hwmon device is failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(chip->dev);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_hwmon;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 ret =3D sysfs_create_group(&client->dev.kobj, &proximity_=
group);
> > + =A0 =A0 =A0 if (ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Creating=
 proximity attribute group failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_sysfs1;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 ret =3D sysfs_create_group(&client->dev.kobj, &ambient_gr=
oup);
> > + =A0 =A0 =A0 if (ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Creating=
 light attribute group failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_sysfs2;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 ret =3D gp2ap002_register_input_device(chip);
> > + =A0 =A0 =A0 if (ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Registering input =
device is failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_input;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 chip->power_enable =A0 =A0 =A0=3D pdata->power_enable;
> > + =A0 =A0 =A0 chip->get_adc =A0 =A0 =A0 =A0 =A0 =3D pdata->get_adc;
> > + =A0 =A0 =A0 chip->vo_gpio =A0 =A0 =A0 =A0 =A0 =3D pdata->vo_gpio;
> > + =A0 =A0 =A0 chip->mode =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D pdata->prox_mod=
e;
> > +
> > + =A0 =A0 =A0 INIT_WORK(&chip->work, gp2ap002_work);

We have already registered IRQ but only initializing work here, this
makes me uneasy... Are we certain that chip is disabled and will not
raise IRQ here?

> > + =A0 =A0 =A0 mutex_init(&chip->lock);
> > +
> > + =A0 =A0 =A0 if (chip->power_enable)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->power_enable(0);
> > +
> > + =A0 =A0 =A0 gp2ap002_set_mode(chip, pdata->enable);
> > +
> > + =A0 =A0 =A0 return 0;
> > +
> > +error_input:
> > + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &ambient_group);
> > +error_sysfs2:
> > + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &proximity_group);
> > +error_sysfs1:
> > + =A0 =A0 =A0 hwmon_device_unregister(chip->dev);
> > +error_hwmon:
> > + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> > + =A0 =A0 =A0 kfree(chip);
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static int __exit gp2ap002_remove(struct i2c_client *client)

__devexit.

> > +{
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D i2c_get_clientdata(client);
> > +
> > + =A0 =A0 =A0 gp2ap002_unregister_input_device(chip);
> > + =A0 =A0 =A0 hwmon_device_unregister(chip->dev);
> > +
> > + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &proximity_group);
> > + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &ambient_group);
> > +
> > + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> > +
> > + =A0 =A0 =A0 if (chip->power_enable)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->power_enable(0);
> > +
> > + =A0 =A0 =A0 kfree(chip);
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +
> > +static int gp2ap002_suspend(struct i2c_client *client, pm_message_t me=
sg)
> > +{
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D i2c_get_clientdata(client);
> > + =A0 =A0 =A0 gp2ap002_set_mode(chip, 0);
> > +
>=20
> cancel_work_sync ?
>=20
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static int gp2ap002_resume(struct i2c_client *client)
> > +{
> > + =A0 =A0 =A0 struct gp2ap002_chip *chip =3D i2c_get_clientdata(client);
> > + =A0 =A0 =A0 gp2ap002_set_mode(chip, 1);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +#else
> > +
> > +#define gp2ap002_suspend NULL
> > +#define gp2ap002_resume NULL
> > +
> > +#endif /* CONFIG_PM */
> > +
> > +static const struct i2c_device_id gp2ap002_id[] =3D {
> > + =A0 =A0 =A0 { "GP2AP002", 0 },
> > + =A0 =A0 =A0 { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, gp2ap002_id);
> > +
> > +static struct i2c_driver gp2ap002_i2c_driver =3D {
> > + =A0 =A0 =A0 .driver =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "GP2AP002",
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D gp2ap002_probe,
> > + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(gp2ap002_remove),

__devexit_p()

> > + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D gp2ap002_suspend,
> > + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D gp2ap002_resume,
> > + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D gp2ap002_id,
> > +};
> > +
> > +static int __init gp2ap002_init(void)
> > +{
> > + =A0 =A0 =A0 return i2c_add_driver(&gp2ap002_i2c_driver);
> > +}
> > +module_init(gp2ap002_init);
> > +
> > +static void __exit gp2ap002_exit(void)
> > +{
> > + =A0 =A0 =A0 i2c_del_driver(&gp2ap002_i2c_driver);
> > +}
> > +module_exit(gp2ap002_exit);
> > +
> > +MODULE_AUTHOR("Minkyu Kang <mk7.kang@samsung.com>");
> > +MODULE_DESCRIPTION("GP2AP002 Proximity/Ambient Light Sensor driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/gp2ap002.h b/include/linux/gp2ap002.h
> > new file mode 100644
> > index 0000000..b6a950b
> > --- /dev/null
> > +++ b/include/linux/gp2ap002.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * =A0Copyright (C) 2009 Samsung Electronics
> > + * =A0Minkyu Kang <mk7.kang@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __GP2AP002_H_
> > +#define __GP2AP002_H_
> > +
> > +struct gp2ap002_platform_data {
> > + =A0 =A0 =A0 int (*get_adc)(void);
> > + =A0 =A0 =A0 void (*power_enable)(int);
> > + =A0 =A0 =A0 int vo_gpio;
> > + =A0 =A0 =A0 int prox_mode;
> > + =A0 =A0 =A0 int enable;
> > +};
> > +
> > +#endif
> > --
--=20
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
