From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 01 Oct 2010 11:46:47 +0000
Subject: [lm-sensors] [RFC PATCH 0/9] lis3 accelerator feature update
Message-Id: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch set is done to top of 2.6.36-RC5

Changes are tested only with I2C interface using 8bit sensor since I don't
have other possibilities.

I send this as RFC since changes may affect functionalities or use cases
which I can't test or I don't know to exist. 

Description about the changes:

0001:
Add support for pm_runtime framework for lis3 core driver and lis3-i2c
interface code. hp_accel and spi should not be affected by the changes.
When either input device or freefall device is opened, chip is powered up.
When a sysfs entry is accessed, chip is powered up and scheduled power down
is requested to happen within 5 seconds.
I'm not familiar enough how pm_runtime works with spi or acpi interfaces, so
those are not changed. And I don't have any change to test changes to those
areas.

0002:
Regulator frame work support added. Regulators are controlled based on
pm_runtime state transitions. Chip register context is stored at power down
and restored at power up. Regulators are controlled only when I2C interface is
used since the implementation requires pm_runtime support.

0003:
Interrupt control is cleaned up little bit. The need for threaded interrupt
is controlled by the input layer open / close function. In the interrupt,
only one check is needed instead of several one.

Also platform information is copied to lis3_dev structure to shorten access
in interrupt code.

Interrupt handling for the WU blocks doesn't check interrupt source anymore.
It is not necessary since interrupt handler is called only when WU unit causes
an interrupt.

0004:
It is possible to use input interface purely under threshold interrupt control
by setting polling interval to 0. In that case, it may take a long time
when coordinates are updated after the input device open. Applications can see
totally outdated information. Coordinates are now refreshed at the device open.

0005:
We have faced sometimes situation where lis3 powerup fails somehow. BOOT
bit is set at device init to force boot sequence. This way lis3 recovers
from the failed boot.
Also data ready interrupts are enabled at init (reset default value). They
have been removed if the module is unloaded and loaded back.

0006:
Add some missing parameters to 8bit chip platform data.
Chip interrupt generation features can now be controlled better. It
is also possible to configure interrupts at both rising and falling edges.
With some fancy interrupt configuration, this gives fresh coordinates
at the beginning and end of the acceleration event.

0007:
Set lower default fuzziness for 8bit device. Original value was from 12bit
device which is much more sensitive than the 8 bit device.

0008:
Interface driver can provide block read function to reduce number of individual
bus operations. With I2C this reduces number of interrupts about 60-70%
and makes access little bit faster due to reduced amount transactions.

0009:
Selftest is enhanced to test also IRQ lines in 8bit device.
This is done by enabling data_ready interrupt during selftest and
calculating number of received interrupts during the test.

Samu Onkalo (9):
  hwmon: lis3: pm_runtime support
  hwmon: lis3: regulator control
  hwmon: lis3: Cleanup interrupt handling
  hwmon: lis3: Update coordinates at polled device open
  hwmon: lis3: Power on corrections
  hwmon: lis3: New parameters to platform data
  hwmon: lis3: Adjust fuzziness for 8 bit device
  hwmon: lis3: use block read to access data registers
  hwmon: lis3: Enhance lis3 selftest with IRQ line test

 drivers/hwmon/lis3lv02d.c     |  303 ++++++++++++++++++++++++++++++++++-------
 drivers/hwmon/lis3lv02d.h     |   25 ++++
 drivers/hwmon/lis3lv02d_i2c.c |  102 ++++++++++++--
 drivers/hwmon/lis3lv02d_spi.c |    2 +-
 include/linux/lis3lv02d.h     |    7 +-
 5 files changed, 375 insertions(+), 64 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
