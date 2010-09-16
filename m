From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 01:52:23 +0000
Subject: [lm-sensors] [PATCH v3 0/7] hwmon: Add support for MAX6695/6696 to
Message-Id: <1284601950-7381-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patchset cleans up the lm90 driver and adds support for
Maxim MAX6695/6696 temperature sensors.

In detail,
- Add support for tempX_emergency_alarm ABI attribute
- Introduce device feature bits to reduce runtime overhead
- Introduce function to delete sysfs files
- Simplify calculations in set_temp11()
- Introduce 3rd set of upper temperature limits (named 'emergency' limits)
- Add max6659 support for those limits, and add support for max6659 address 0x4e
- Add max6695/96 support

The patchset depends on the previously submitted lm90 driver cleanup patch.

v2 changes:
- Split patch into multiple parts
- Add support for max6659 address 0x4e and extra features
- Improved max6695/96 device detection code
- max6695/96 does not support extended external limits, so don't try to
  read them for the 3rd sensor
- Other changes to address review feedback
  - Updated Documentation/hwmon/lm90 and drivers/hwmon/Kconfig.
  - Fixed alert_alarms comment
  - remote offset register not supported on max6658 (fixed comment)
  - rewrote set_temp11()
  - Added tempX_emergency_alarm attribute
  - Some code alignment fixes

v3 changes:
- Express bit masks using shift values instead of hex constants
- Replaced tabs after #define with space
- Negated LM90_HAVE_REM_LIMIT_EXT test
- Reordered patches 5 and 6 (introduce max6659 first, then its extra features)
- Clarified that only max6696 permits multiple I2C addresses
- Use max6696 instead of max6695 in chips enum to avoid mixup with max6659
- Fixed register index for temp3_crit_hyst
- Moved lm90_select_remote_channel() to avoid forward declaration of
  lm90_read_reg()
- Added comment indicating that lm90_select_remote_channel() must be called with
  update lock held
- Added tempX_emergency_hyst attribute

Patches unchanged in v3 are listed as v2 patches and are resubmitted for clarity.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
