From: Tiberiu Breana <tiberiu.a.breana@intel.com>
Date: Tue, 22 Mar 2016 11:41:03 +0000
Subject: [lm-sensors] [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sensors
Message-Id: <1458646865-6416-1-git-send-email-tiberiu.a.breana@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4586F61A4A291F4DA44D32824E7C0F4023568E0D@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4023568E0D@IRSMSX109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch set adds support for the MAX31722/MAX31723 temperature sensors /
thermostats.
Patch 1 adds basic support and power management.
Patch 2 adds alarm support.

A discussion of whether this belongs in hwmon vs iio can be found here:
http://www.spinics.net/lists/linux-iio/msg23463.html

Tiberiu Breana (2):
  hwmon: (max31722) Add support for MAX31722/MAX31723 temperature
    sensors
  hwmon: (max31722) Add alarm support

 Documentation/hwmon/max31722 |  41 +++++
 drivers/hwmon/Kconfig        |  11 ++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/max31722.c     | 422 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 475 insertions(+)
 create mode 100644 Documentation/hwmon/max31722
 create mode 100644 drivers/hwmon/max31722.c

-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
