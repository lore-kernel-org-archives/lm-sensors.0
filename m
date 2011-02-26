From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 26 Feb 2011 17:50:45 +0000
Subject: [lm-sensors] [PATCH v5 0/5] hwmon: PMBus device driver
Message-Id: <1298742650-9789-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, Greg Schnorr <gschnorr@cisco.com>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

This patchset adds support for hardware monitoring features of PMBus devices.

---
Post-commit: Check if pmbus_find_attributes() can be rewritten to use tables.
[ I looked into it, but concluded it would be too risky to do that now. So I'll
  try that later and submit as cleanup patch if it works out. ]

v5 changes:
- Added a note to driver documentation stating that fan support will be added
  later.
- max34440: Added comment describing why R=3 instead of 0. Formatting fix.
- Core driver:
  - Added function to check status register
  - Reduced number of times clear status function is called.
  - Added explanation describing when get_status and identify functions are
    needed.
  - Describe pmbus_get_boolean() functionality in more detail.
  - Declared some static arrays as const.
  - No longer export pmbus_read_byte_data(), since it is not used outside
    the core driver.
- Generic pmbus driver:
  - Removed pmbus_entry list. Replaced with API in core driver to retrieve
    pointer to struct pmbus_driver_info from client data.

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
