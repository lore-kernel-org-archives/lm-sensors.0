From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:09:54 +0000
Subject: [lm-sensors] [PATCH 02/25] hwmon: Clarify the W83627THF VID
Message-Id: <20051126201056.18f3a2fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Content-Disposition: inline; filename=hwmon-w83627thf-vid-documentation-update.patch

This patch clarifies the W83627THF VID documentation.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83627hf |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- linux-2.6.15-rc1.orig/Documentation/hwmon/w83627hf	2005-10-28 18:23:39.000000000 +0200
+++ linux-2.6.15-rc1/Documentation/hwmon/w83627hf	2005-11-13 09:06:41.000000000 +0100
@@ -54,13 +54,16 @@
 use the w83781d driver. However this is not the preferred method
 now that this ISA driver has been developed.
 
-Technically, the w83627thf does not support a VID reading. However, it's
-possible or even likely that your mainboard maker has routed these signals
-to a specific set of general purpose IO pins (the Asus P4C800-E is one such
-board). The w83627thf driver now interprets these as VID. If the VID on
-your board doesn't work, first see doc/vid in the lm_sensors package. If
-that still doesn't help, email us at lm-sensors@lm-sensors.org.
+The w83627_HF_ uses pins 110-106 as VID0-VID4. The w83627_THF_ uses the
+same pins as GPIO[0:4]. Technically, the w83627_THF_ does not support a
+VID reading. However the two chips have the identical 128 pin package. So,
+it is possible or even likely for a w83627thf to have the VID signals routed
+to these pins despite their not being labeled for that purpose. Therefore,
+the w83627thf driver interprets these as VID. If the VID on your board
+doesn't work, first see doc/vid in the lm_sensors package[1]. If that still
+doesn't help, you may just ignore the bogus VID reading with no harm done.
 
-For further information on this driver see the w83781d driver
-documentation.
+For further information on this driver see the w83781d driver documentation.
+
+[1] http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/vid
 

-- 
Jean Delvare
