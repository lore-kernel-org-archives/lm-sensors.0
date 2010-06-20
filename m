From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 20 Jun 2010 19:19:32 +0000
Subject: [lm-sensors] [PATCH v2 0/3] hwmon: Driver for SMM665 Six-Channel
Message-Id: <1277061575-13831-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patchset adds support for the monitoring features of the Summit
Microelectronics SMM665 Six-Channel Active DC Output Controller/Monitor.

Issues/questions/notes:
- Some of the command register defines are currently unused.
  Keep or remove ?
- Critical/fault voltage limits are not supported by the current sysfs API,
  though available from the chip. Would it make sense to report those values,
  e.g. as inX_min_crit and inX_max_crit or inX_min_fault or inX_max_fault ? 
  Note: This also applies to PMBus chips, so the question will come up again.
- For four-channel chips, Channel E and F readings are reported, but undefined.
  Current approach is to mention this in the documentation.
  An alternative might be to create smm665_attributes dynamically.
  Any opinion which approach is better ?

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

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
