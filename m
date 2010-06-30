From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 30 Jun 2010 15:50:41 +0000
Subject: [lm-sensors] [PATCH v6 0/3] hwmon: Driver for SMM665 Six-Channel
Message-Id: <1277913044-28322-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

This patchset adds support for the monitoring features of the Summit
Microelectronics SMM665 Six-Channel Active DC Output Controller/Monitor.

------

v2 changes:
- Added (untested) support for SMM465, SMM764, and SMM766.
- Added vref module parameter to support non-default values of VREF_ADC.
- Added an explanation describing what the chip does with _min and _max limit
  values.
- Removed alarm sysfs files (since the chip does not report alarm status in a
  register, alarm detection was implemented by comparing limits with ADC readings,
  which can as well be done in userland).
- Replaced register enums with defines.
- Made limit variable names better readable.
- Removed retries from smm665_read_adc().
- Check error reply from i2c_smbus_read_byte_data() and only accept ENXIO
  when expecting NACK.
- Explained reason for byte swap after reading ADC registers in some more detail.
- Added debug messages to display the error reason when reading ADC registers
  failed.

v3 changes:
- Return error codes from smm665_read_adc().
- Abort after first error in smm665_update_device() and return error code.
- Return ADC read errors to user.
- Added inX_lcrit and inX_crit attributes for min/max critical voltages.
- Added tempX_lcrit attribute for critical low temperature.
- Updated sysfs-interface to document support for new attributes.

v4 changes:
- Added missing unlock in error handling of smm665_update_device().
- Fixed minor style issue in MAINTAINERS
- Removed update to sysfs-interface from patchset since it has already
  been applied.
- Added lcrit and crit attributes to driver documentation.

v5 changes:
- Removed obsolete comment
- Added datasheet links to driver documentation.

v6 changes:
- Renamed fault attributes to crit_alarm, to reflect that the conditions
  occur if critical limits were reached or exceeded and not due to a faulty
  sensor.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
