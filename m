From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:20 +0000
Subject: [lm-sensors] [PATCH 26/82] hwmon: (gl518sm) Fix multi-line comments
Message-Id: <1327017376-20466-27-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gl518sm.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index 8d0f71d..2cf978e 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -588,8 +588,10 @@ exit:
 }
 
 
-/* Called when we have found a new GL518SM.
-   Note that we preserve D4:NoFan2 and D2:beep_enable. */
+/*
+ * Called when we have found a new GL518SM.
+ * Note that we preserve D4:NoFan2 and D2:beep_enable.
+ */
 static void gl518_init_client(struct i2c_client *client)
 {
 	/* Make sure we leave D7:Reset untouched */
@@ -619,9 +621,11 @@ static int gl518_remove(struct i2c_client *client)
 	return 0;
 }
 
-/* Registers 0x07 to 0x0c are word-sized, others are byte-sized
-   GL518 uses a high-byte first convention, which is exactly opposite to
-   the SMBus standard. */
+/*
+ * Registers 0x07 to 0x0c are word-sized, others are byte-sized
+ * GL518 uses a high-byte first convention, which is exactly opposite to
+ * the SMBus standard.
+ */
 static int gl518_read_value(struct i2c_client *client, u8 reg)
 {
 	if ((reg >= 0x07) && (reg <= 0x0c))
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
