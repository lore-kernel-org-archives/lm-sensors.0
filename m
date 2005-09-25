From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:45:34 +0000
Subject: [lm-sensors] [PATCH] (8/13) hwmon: Minor w83l785ts optimization
Message-Id: <20050925164503.47b7f438.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Using s8 instead of u8 to store temperature register values saves a
few instructions on sysfs file read. The very same was done for
several other drivers a while ago (lm63, lm83, lm90...)

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/w83l785ts.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/hwmon/w83l785ts.c	2005-09-25 14:47:06.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/w83l785ts.c	2005-09-25 14:49:45.000000000 +0200
@@ -74,7 +74,7 @@
  * The W83L785TS-S uses signed 8-bit values.
  */
 
-#define TEMP_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)
+#define TEMP_FROM_REG(val)	((val) * 1000)
 
 /*
  * Functions declaration
@@ -112,7 +112,7 @@
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp[2]; /* 0: input
+	s8 temp[2]; /* 0: input
 		       1: critical limit */
 };
 

-- 
Jean Delvare
