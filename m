From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 05 Mar 2009 17:58:16 +0000
Subject: [lm-sensors] [PATCH] lm90: Update Documentation/hwmon/lm90 to
Message-Id: <20090305175816.GF6502@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090302210106.GD6550@plum> <20090305152517.4e0b8983@hyperion.delvare> <20090305154729.GL6550@plum> <20090305174418.02fd9593@hyperion.delvare>
In-Reply-To: <20090305174418.02fd9593@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Oops, forgot this piece.
---
Update Documentation/hwmon/lm90 to add max6648/92 support.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/lm90 |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index 0e84117..ab36eb0 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -42,6 +42,11 @@ Supported chips:
     Addresses scanned: I2C 0x4e
     Datasheet: Publicly available at the Maxim website
                http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+  * Maxim MAX6648/MAX6692
+    Prefix: 'max6646'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/getds.cfm/qv_pk/3500
   * Maxim MAX6649
     Prefix: 'max6646'
     Addresses scanned: I2C 0x4c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
