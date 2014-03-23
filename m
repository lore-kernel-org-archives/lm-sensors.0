From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Date: Sun, 23 Mar 2014 20:37:31 +0000
Subject: [lm-sensors] [RFC V1 0/3] da9063: Addition of HWMON support for DA9063
Message-Id: <cover.1395607051.git.stwiss.opensource@diasemi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, Lee Jones <lee.jones@linaro.org>, Rob Landley <rob@landley.net>, Samuel Ortiz <sameo@linux.intel.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, LINUX-DOC <linux-doc@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LM-SENSORS <lm-sensors@lm-sensors.org>, Mark Brown <broonie@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>

From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

This patch series covers hardware monitoring support for the DA9063 PMIC.

There are three patches in this set:
 - Add a new HWMON driver component
 - Minor MFD core and platform data changes for HWMON
 - Documentation

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (3):
  hwmon: da9063: HWMON driver
  mfd: da9063: Add HWMON dependencies
  Documentation: hwmon: New information for DA9063

 Documentation/hwmon/da9063           |   67 +++++
 drivers/hwmon/Kconfig                |   10 +
 drivers/hwmon/Makefile               |    1 +
 drivers/hwmon/da9063-hwmon.c         |  456 ++++++++++++++++++++++++++++++++++
 drivers/mfd/da9063-core.c            |   13 +-
 include/linux/mfd/da9063/core.h      |    3 +
 include/linux/mfd/da9063/pdata.h     |   18 ++
 include/linux/mfd/da9063/registers.h |   34 +++
 8 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hwmon/da9063
 create mode 100644 drivers/hwmon/da9063-hwmon.c

-- 
end-of-patch for RFC V1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
