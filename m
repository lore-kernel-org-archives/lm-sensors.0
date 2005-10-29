From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:15:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: Minor w83l785ts optimization
Message-Id: <11305336583396@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Minor w83l785ts optimization

Using s8 instead of u8 to store temperature register values saves a
few instructions on sysfs file read. The very same was done for
several other drivers a while ago (lm63, lm83, lm90...)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/hwmon/w83l785ts.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---
commit cb929eae78ec0b243dbf58039bce4af354f6020c
tree bdd5d708bac06c95c4ff067ff8f21688e9b31143
parent 709439a284bc5b7d42a70fee7119feb186c1ca99
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:45:03 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 drivers/hwmon/w83l785ts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index fcb2c39..db12a62 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -74,7 +74,7 @@ I2C_CLIENT_INSMOD_1(w83l785ts);
  * The W83L785TS-S uses signed 8-bit values.
  */
 
-#define TEMP_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)
+#define TEMP_FROM_REG(val)	((val) * 1000)
 
 /*
  * Functions declaration
@@ -112,7 +112,7 @@ struct w83l785ts_data {
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	u8 temp[2]; /* 0: input
+	s8 temp[2]; /* 0: input
 		       1: critical limit */
 };
 

