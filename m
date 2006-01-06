From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: Clarify the W83627THF VID documentation
Message-Id: <11365852531963@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Clarify the W83627THF VID documentation

This patch clarifies the W83627THF VID documentation.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 5b319400f5e2cd31a82b38405856ff2b46a9bb83
tree ab22b0738f072128dc428f16aa37b0aa89934cc4
parent dd149c52223cfb05cdefb0755d3c2793e8d33ede
author Mark M. Hoffman <mhoffman at lightlink.com> Sat, 26 Nov 2005 20:10:56 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:20 -0800

 Documentation/hwmon/w83627hf |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/w83627hf b/Documentation/hwmon/w83627hf
index 78f37c2..5d23776 100644
--- a/Documentation/hwmon/w83627hf
+++ b/Documentation/hwmon/w83627hf
@@ -54,13 +54,16 @@ If you really want i2c accesses for thes
 use the w83781d driver. However this is not the preferred method
 now that this ISA driver has been developed.
 
-Technically, the w83627thf does not support a VID reading. However, it's
-possible or even likely that your mainboard maker has routed these signals
-to a specific set of general purpose IO pins (the Asus P4C800-E is one such
-board). The w83627thf driver now interprets these as VID. If the VID on
-your board doesn't work, first see doc/vid in the lm_sensors package. If
-that still doesn't help, email us at lm-sensors at lm-sensors.org.
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
 


