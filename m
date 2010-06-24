From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 24 Jun 2010 22:00:57 +0000
Subject: [lm-sensors] [PATCH v3 0/4] hwmon: Driver for SMM665 Six-Channel
Message-Id: <1277416861-32494-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@xenotime.net>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

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

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
