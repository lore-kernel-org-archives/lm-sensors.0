From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 10 Nov 2005 04:55:24 +0000
Subject: [lm-sensors] [PATCH 2.6.14-mm1] hwmon: w83627thf documentation
Message-Id: <20051110035507.GB31576@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch clarifies the w83627thf VID documentation.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

--- linux-2.6.14-mm1.orig/Documentation/hwmon/w83627hf
+++ linux-2.6.14-mm1/Documentation/hwmon/w83627hf
@@ -54,13 +54,16 @@ If you really want i2c accesses for thes
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
Mark M. Hoffman
mhoffman@lightlink.com

