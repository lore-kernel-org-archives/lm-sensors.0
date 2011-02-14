From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 Feb 2011 19:35:33 +0000
Subject: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support for
Message-Id: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch series adds support for NCT6775F and NCT6776F to the
w83627ehf driver. It also includes some cleanup and adds support for
the fourth temperature sensor on W83677HG-B.

v4:
- Store rpm instead of raw fan speed readings
- For NCT6775F, increase fan divisor if the fan speed reads 0
  [ On NCT6775F, fan speed readings can return 0 instead of 0xff if the
    fan divisor value is too low ]
- Separate changes into more patches to simplify review

v3:
- Documentation: Remove references to datasheets which no longer exist
- Documentation: Add information about limits of SmartFan IV support.
- SmartFan III mode is not supported on NCT6776F, so remove related attributes
  and refuse to configure it.
- (additional patch) Improve support for chips with 16-bit fan count registers

v2:
- W83677HG-B does share the AUXTIN/VIN3 pin, so we can not skip this check.
- Cosmetic changes to fix a couple of checkpatch errors and to undo some
  unnecessary formatting changes in patch 5.
- Patch 1 introduced a bug in temp_to_reg which was fixed in a later patch.
  Modified code to not introduce the bug in the first place.
- Two dev_dbg messages were changed to dev_info for testing. Changed back
  to dev_dbg.

The patched driver can be downloaded as stand-alone driver from
	http://www.roeck-us.net/linux/drivers/w83627ehf/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
