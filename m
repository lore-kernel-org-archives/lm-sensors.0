From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 30 Jul 2015 16:18:25 +0000
Subject: [lm-sensors] [PATCH 00/27] Export I2C and OF module aliases in missing drivers
Message-Id: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdw>

Hello,

Short version:

This series add the missing MODULE_DEVICE_TABLE() for OF and I2C tables
to export that information so modules have the correct aliases built-in
and autoloading works correctly.

Longer version:

Currently it's mandatory for I2C drivers to have an I2C device ID table
regardless if the device was registered using platform data or OF. This
is because the I2C core needs an I2C device ID table for two reasons:

1) Match the I2C client with a I2C device ID so a struct i2c_device_id
   is passed to the I2C driver probe() function.

2) Export the module aliases from the I2C device ID table so userspace
   can auto-load the correct module. This is because i2c_device_uevent
   always reports a MODALIAS of the form i2c:<client->name>.

Lee Jones posted a patch series [0] to solve 1) by allowing the I2C
drivers to have a probe() function that does not get a i2c_device_id.

The problem is that his series didn't take into account 2) so if that
was merged and the I2C ID table is removed from all the drivers that
don't needed it, module auto-loading will break for those.

But even now there are many I2C drivers were module auto-loading is
not working because of the fact that the I2C core always reports the
MODALIAS as i2c:<client->name> and many developers didn't expect this.

I've identified I2C drivers with 3 types of different issues:

a) Those that have an i2c_table but are not exported. The match works
   and the correct i2c_device_id is passed on probe but since the ID
   table is not exported, module auto-load won't work.

b) Those that have a of_table but are not exported. This is currently
   not an issue since even when the of_table is used to match the dev
   with the driver, an OF modalias is not reported by the I2C core.
   But if the I2C core is changed to report the MODALIAS of the form
   of:N*T*C as it's made by other subsystems, then module auto-load
   will break for these drivers.

c) Those that don't have a of_table but should since are OF drivers
   with DT bindings doc for them. Since the I2C core does not report
   a OF modalias and since i2c_device_match() fallbacks to match the
   device part of the compatible string with the I2C device ID table,
   many OF drivers don't have an of_table to match. After all having
   a I2C device ID table is mandatory so it works without a of_table.

So, in order to not make mandatory to have a I2C device ID table, at
least a) and b) needs to be addressed, this series does that.

c) should be fixed too since it seems wrong that a driver with a DT
binding document, does not have a OF table and export it to modules.

Also stripping the vendor part from the compatible string to match
with the I2C devices ID table and reporting only the device name to
user-space doesn't seem to be correct. I've identified at least two
drivers that have the same name on their I2C device ID table so the
manufacturer prefix is important. But I've not tried to fix c) yet
since that is not so easy to automate due drivers not having all the
information (i.e: the device name can match a documented compatible
string device part but without the vendor prefix is hard to tell).

I split the changes so the patches in this series are independent and
can be picked individually by subsystem maintainers. Patch #27 changes
the logic of i2c_device_uevent() to report an OF modalias if the device
was registered using OF. But this patch is included in the series only
as an RFC for illustration purposes since changing that without fixing
c) will break module auto-loading for the drivers of devices registered
with OF but that don't have a of_match_table.

Although arguably, those drivers were relying on the assumption that a
MODALIAS=i2c:<foo> would always be reported even for the OF case which
is not the true on other subsystems.

[0]: https://lkml.org/lkml/2014/8/28/283

Best regards,
Javier


Javier Martinez Canillas (27):
  mfd: stw481x: Export I2C module alias information
  spi: xcomm: Export I2C module alias information
  iio: Export I2C module alias information in missing drivers
  [media] Export I2C module alias information in missing drivers
  macintosh: therm_windtunnel: Export I2C module alias information
  misc: eeprom: Export I2C module alias information in missing drivers
  Input: Export I2C module alias information in missing drivers
  power: Export I2C module alias information in missing drivers
  i2c: core: Export I2C module alias information in dummy driver
  backlight: tosa: Export I2C module alias information
  [media] staging: media: lirc: Export I2C module alias information
  usb: phy: isp1301: Export I2C module alias information
  ALSA: ppc: keywest: Export I2C module alias information
  hwmon: (nct7904) Export I2C module alias information
  regulator: fan53555: Export I2C module alias information
  mfd: Export OF module alias information in missing drivers
  iio: Export OF module alias information in missing drivers
  hwmon: (g762) Export OF module alias information
  extcon: Export OF module alias information in missing drivers
  ASoC: Export OF module alias information in missing codec drivers
  rtc: Export OF module alias information in missing drivers
  macintosh: therm_windtunnel: Export OF module alias information
  leds: Export OF module alias information in missing drivers
  [media] smiapp: Export OF module alias information
  Input: touchscreen - Export OF module alias information
  regulator: isl9305: Export OF module alias information
  i2c: (RFC, don't apply) report OF style modalias when probing using DT

 drivers/extcon/extcon-rt8973a.c         | 1 +
 drivers/extcon/extcon-sm5502.c          | 1 +
 drivers/hwmon/g762.c                    | 1 +
 drivers/hwmon/nct7904.c                 | 1 +
 drivers/i2c/i2c-core.c                  | 9 +++++++++
 drivers/iio/accel/mma8452.c             | 1 +
 drivers/iio/accel/stk8312.c             | 1 +
 drivers/iio/accel/stk8ba50.c            | 1 +
 drivers/iio/light/cm32181.c             | 1 +
 drivers/iio/light/cm3232.c              | 1 +
 drivers/iio/light/cm36651.c             | 1 +
 drivers/iio/light/gp2ap020a00f.c        | 1 +
 drivers/iio/light/stk3310.c             | 1 +
 drivers/input/misc/gp2ap002a00f.c       | 1 +
 drivers/input/touchscreen/egalax_ts.c   | 1 +
 drivers/input/touchscreen/goodix.c      | 1 +
 drivers/input/touchscreen/mms114.c      | 1 +
 drivers/leds/leds-pca963x.c             | 1 +
 drivers/leds/leds-tca6507.c             | 1 +
 drivers/macintosh/therm_windtunnel.c    | 2 ++
 drivers/media/i2c/ir-kbd-i2c.c          | 1 +
 drivers/media/i2c/s5k6a3.c              | 1 +
 drivers/media/i2c/smiapp/smiapp-core.c  | 1 +
 drivers/mfd/rt5033.c                    | 1 +
 drivers/mfd/stw481x.c                   | 1 +
 drivers/mfd/tps65217.c                  | 1 +
 drivers/mfd/tps65218.c                  | 1 +
 drivers/misc/eeprom/eeprom.c            | 1 +
 drivers/misc/eeprom/max6875.c           | 1 +
 drivers/power/bq24190_charger.c         | 1 +
 drivers/power/rt5033_battery.c          | 2 +-
 drivers/regulator/fan53555.c            | 1 +
 drivers/regulator/isl9305.c             | 1 +
 drivers/rtc/rtc-ab-b5ze-s3.c            | 1 +
 drivers/rtc/rtc-isl12022.c              | 1 +
 drivers/rtc/rtc-isl12057.c              | 1 +
 drivers/spi/spi-xcomm.c                 | 1 +
 drivers/staging/media/lirc/lirc_zilog.c | 1 +
 drivers/usb/phy/phy-isp1301.c           | 1 +
 drivers/video/backlight/tosa_bl.c       | 1 +
 sound/ppc/keywest.c                     | 1 +
 sound/soc/codecs/da9055.c               | 1 +
 sound/soc/codecs/wm8510.c               | 1 +
 sound/soc/codecs/wm8523.c               | 1 +
 sound/soc/codecs/wm8580.c               | 1 +
 45 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
