From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Thu, 07 Apr 2011 17:44:03 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: (sht15) Support for all SHT15
Message-Id: <1302198246-22212-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The SHT15 sensor supports several functionalities such as i/o
checksumming, an embedded heater for dew point cross-validation, two
resolution settings and a device-specific feature known as OTP reload.
This set of patches brings the ability to use these features.

The first patch is a general clean-up of the code, including fixes for the
probe function (mainly clean-up of the error path).

The second patch adds support to read/change the status register, through
several sysfs attributes or the platform data structure.

The third patch adds support for CRC calculation.

Jerome Oufella (1):
  hwmon: (sht15) add checksum validation support

Vivien Didelot (2):
  hwmon: (sht15) general code clean-up
  hwmon: (sht15) add support for the status register

 Documentation/hwmon/sht15 |   68 +++++
 drivers/hwmon/sht15.c     |  728 +++++++++++++++++++++++++++++++++++----------
 include/linux/sht15.h     |   18 +-
 3 files changed, 659 insertions(+), 155 deletions(-)
 create mode 100644 Documentation/hwmon/sht15


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
