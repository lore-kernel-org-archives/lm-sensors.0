From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 17 Feb 2011 19:00:12 +0000
Subject: [lm-sensors] [PATCH v4 0/5] hwmon: PMBus device driver
Message-Id: <1297969217-9564-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, Greg Schnorr <gschnorr@cisco.com>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

This patchset adds support for hardware monitoring features of PMBus devices.

---
I did not get significant feedback from the previous submission, so here it is
again with extended audience. Only change since v3 is a minor fix in Kconfig.

I understand this is a large patch set. Question is if it would make sense
to create its own subdirectory for pmbus devices, and to split pmbus.c and
pmbus_core.c into more files. I'd be more than happy to do that if it helps
for the review process.

There is still some work to be done. Fan support is only rudimentary,
and the PHASE command is still not supported. However, the driver
is now stable enough to be useful, so it is worth going ahead.

v4 changes:
- Fixed PMBUS entry in Kconfig

v3 changes:
  Tested with real hardware (bmr453, bmr454, ltc2978, max8688, max16064,
  max34441).
  Changes are too numerous to count. Lots of bug fixes. Code was completely
  rearranged to permit addition of chips without having to modify the core
  pmbus driver. Split main driver into pmbus_core.c for core support and
  pmbus.c as front-end driver to support generic PMBus chips.
  Support for additional chips can now be added by writing small front-end
  drivers which basically describe chip capabilities.

v2 changes:
- Calculate maximum number of attributes / sensors / booleans / labels instead
  of using defines
- Increased maximum number of supported pages to the PMBus maximum of 32.
- Replaced most fixed size arrays with dynamically allocated arrays/structures.
- Added comments and clarifications
- Renamed local defines to start with PB_ or PMBUS_ prefix
- Removed pages module parameter. Replaced with code to auto-detect the number
  of supported pages.
- Split probe code into several functions to make it better readable
- Replaced _fault attributes with _lcrit_alarm and _crit_alarm attributes
- Several other minor changes to address review feedback
- PMBus emulator: Fixed fault status detection code. Also use more reasonable
  power limits (eg 200W instead of 2kW).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
