From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:34 +0000
Subject: [lm-sensors] [PATCH] i2c: Remove duplicate rtc8564 BCD macros
Message-Id: <1136585254153@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Remove duplicate rtc8564 BCD macros

Remove duplicate of BCD macros.

Signed-off-by: Nicolas Kaiser <nikai at nikai.net>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 7e94436942a7517d08c0cd1a8831122a0fea289e
tree f67263807fb5ce39796dc75525323a2c6753c143
parent 5b319400f5e2cd31a82b38405856ff2b46a9bb83
author Nicolas Kaiser <nikai at nikai.net> Sat, 26 Nov 2005 20:15:23 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:21 -0800

 drivers/i2c/chips/rtc8564.c |   36 +++++++++++++++++-------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
index 916cdc1..26e498d 100644
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -14,6 +14,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -52,9 +53,6 @@ static inline u8 _rtc8564_ctrl2(struct i
 #define CTRL1(c) _rtc8564_ctrl1(c)
 #define CTRL2(c) _rtc8564_ctrl2(c)
 
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
-
 static int debug;;
 module_param(debug, int, S_IRUGO | S_IWUSR);
 
@@ -224,16 +222,16 @@ static int rtc8564_get_datetime(struct i
 		return ret;
 
 	/* century stored in minute alarm reg */
-	dt->year = BCD_TO_BIN(buf[RTC8564_REG_YEAR]);
-	dt->year += 100 * BCD_TO_BIN(buf[RTC8564_REG_AL_MIN] & 0x3f);
-	dt->mday = BCD_TO_BIN(buf[RTC8564_REG_DAY] & 0x3f);
-	dt->wday = BCD_TO_BIN(buf[RTC8564_REG_WDAY] & 7);
-	dt->mon = BCD_TO_BIN(buf[RTC8564_REG_MON_CENT] & 0x1f);
+	dt->year = BCD2BIN(buf[RTC8564_REG_YEAR]);
+	dt->year += 100 * BCD2BIN(buf[RTC8564_REG_AL_MIN] & 0x3f);
+	dt->mday = BCD2BIN(buf[RTC8564_REG_DAY] & 0x3f);
+	dt->wday = BCD2BIN(buf[RTC8564_REG_WDAY] & 7);
+	dt->mon = BCD2BIN(buf[RTC8564_REG_MON_CENT] & 0x1f);
 
-	dt->secs = BCD_TO_BIN(buf[RTC8564_REG_SEC] & 0x7f);
+	dt->secs = BCD2BIN(buf[RTC8564_REG_SEC] & 0x7f);
 	dt->vl = (buf[RTC8564_REG_SEC] & 0x80) = 0x80;
-	dt->mins = BCD_TO_BIN(buf[RTC8564_REG_MIN] & 0x7f);
-	dt->hours = BCD_TO_BIN(buf[RTC8564_REG_HR] & 0x3f);
+	dt->mins = BCD2BIN(buf[RTC8564_REG_MIN] & 0x7f);
+	dt->hours = BCD2BIN(buf[RTC8564_REG_HR] & 0x3f);
 
 	_DBGRTCTM(2, *dt);
 
@@ -255,18 +253,18 @@ rtc8564_set_datetime(struct i2c_client *
 
 	buf[RTC8564_REG_CTRL1] = CTRL1(client) | RTC8564_CTRL1_STOP;
 	buf[RTC8564_REG_CTRL2] = CTRL2(client);
-	buf[RTC8564_REG_SEC] = BIN_TO_BCD(dt->secs);
-	buf[RTC8564_REG_MIN] = BIN_TO_BCD(dt->mins);
-	buf[RTC8564_REG_HR] = BIN_TO_BCD(dt->hours);
+	buf[RTC8564_REG_SEC] = BIN2BCD(dt->secs);
+	buf[RTC8564_REG_MIN] = BIN2BCD(dt->mins);
+	buf[RTC8564_REG_HR] = BIN2BCD(dt->hours);
 
 	if (datetoo) {
 		len += 5;
-		buf[RTC8564_REG_DAY] = BIN_TO_BCD(dt->mday);
-		buf[RTC8564_REG_WDAY] = BIN_TO_BCD(dt->wday);
-		buf[RTC8564_REG_MON_CENT] = BIN_TO_BCD(dt->mon) & 0x1f;
+		buf[RTC8564_REG_DAY] = BIN2BCD(dt->mday);
+		buf[RTC8564_REG_WDAY] = BIN2BCD(dt->wday);
+		buf[RTC8564_REG_MON_CENT] = BIN2BCD(dt->mon) & 0x1f;
 		/* century stored in minute alarm reg */
-		buf[RTC8564_REG_YEAR] = BIN_TO_BCD(dt->year % 100);
-		buf[RTC8564_REG_AL_MIN] = BIN_TO_BCD(dt->year / 100);
+		buf[RTC8564_REG_YEAR] = BIN2BCD(dt->year % 100);
+		buf[RTC8564_REG_AL_MIN] = BIN2BCD(dt->year / 100);
 	}
 
 	ret = rtc8564_write(client, 0, buf, len);


