From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 16 Mar 2011 18:44:07 +0000
Subject: [lm-sensors] [RFC PATCH 0/3] Support for all SHT15 features
Message-Id: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The SHT15 sensor supports several functionalities such as i/o
checksumming, an embedded heater for dew point cross-validation, two
resolution settings and a device-specific feature known as OTP reload.
This set of patches brings the ability to use these features.

The first patch adds support for CRC calculation.

The second patch adds the ability to read the status register through
several sysfs attributes.

The last one adds support to change the status register, through
those individual sysfs attributes.

Jerome Oufella (1):
  hwmon: sht15: add checksum validation support

Vivien Didelot (2):
  hwmon: sht15: add support for reading the status register
  hwmon: sht15: add support for writing the status register

 drivers/hwmon/sht15.c |  525 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 499 insertions(+), 26 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
