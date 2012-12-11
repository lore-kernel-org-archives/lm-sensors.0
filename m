From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Dec 2012 20:55:53 +0000
Subject: [lm-sensors] [PATCH v5 00/11] hwmon: Driver for Nuvoton NCT6775F, NCT6776F, and NCT6779D
Message-Id: <1355259364-14293-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This driver will replace the w83627ehf driver for NCT6775F and NCT6776F,
and provides support for NCT6779D.

v5:
- Review fedback
  - Documentation fixes
  - Split patch into several parts to simplify review. 
  - Updated attribute names
- Improved support for thermal and speed cruise modes
- Dropped pwmX_interpolate (or pwmX_step_enable) since I could not get it
  to work on any of the chips.
- Added power management support
- Added support for fanX_pulses attribute
- Improved fan divider selection
- Removed unused defines
- 'valid' is now bool
- Removed __devinit/__devexit

v4:
- Fix "temp" array size (reported by smatch)
- Fix whitespace errors reported by "git am" (but not by checkpatch).
- Order register definition data by chip type
- Improve parameter alignment

v3:
- Variables pwm_temp, REG_TEMP_MON, and NCT6775_REG_TEMP_MON are not used,
  drop it.

v2:
- superio region access protection
- Add support for pwmX_step_enable attribute
- Improved documentation

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
