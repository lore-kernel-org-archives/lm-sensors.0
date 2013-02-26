From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Feb 2013 18:23:28 +0000
Subject: [lm-sensors] [PATCH v6 00/12] hwmon: Driver for Nuvoton NCT6775F, NCT6776F, and NCT6779D
Message-Id: <1361903020-18526-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

This driver will replace the w83627ehf driver for NCT6775F and NCT6776F,
and provides support for NCT6779D.

This is a resend for most of the series. Patch 04/12 was updated, and patch
12/12 was added.

The driver has been available as standalone driver (https://github.com/groeck/nct6775)
since March 2012. It has been available as Archlinux package since July 2012
(https://aur.archlinux.org/packages.php?IDa127).
At least one inofficial Ubuntu/Debian build is available at Launchpad
(http://ppa.launchpad.net/foresto/extradrivers/ubuntu/dists/quantal/main/source/Sources).
A bug has been submitted in Debian against not having this driver upstream
(http://bugs.debian.org/cgi-bin/bugreport.cgi?bugi9140).

So there is some interest to get the driver upstream, and it does have at least
some level of test coverage. The only missing detail is someone with the time
to review the code. Expanding the audience in the hope of finding one.

v6:
- Spelling fix
- Fix fan register initialization for chips with no fan divisor (NCT6776,
  NCT6779)
- Don't report VID if disabled (NCT6775, NCT6776) or not supported (NCT6779)

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
