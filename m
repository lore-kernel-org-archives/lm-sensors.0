From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Feb 2011 15:49:04 +0000
Subject: [lm-sensors] [PATCH v2 0/5] hwmon: (w83627ehf) Add support for
Message-Id: <1297352949-25602-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch series adds support for NCT6775F and NCT6776F to the
w83627ehf driver. It also includes some cleanup and adds support for
the fourth temperature sensor on W83677HG-B.

v2:
- W83677HG-B does share the AUXTIN/VIN3 pin, so we can not skip this check.
- Cosmetic changes to fix a couple of checkpatch errors and to undo some
  unnecessary formatting changes in patch 5.
- Patch 1 introduced a bug in temp_to_reg which was fixed in a later patch.
  Modified code to not introduce the bug in the first place.
- Two dev_dbg messages were changed to dev_info for testing. Changed back
  to dev_dbg.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
