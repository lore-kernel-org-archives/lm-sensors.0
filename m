From: curt@cumulusnetworks.com
Date: Thu, 08 Aug 2013 19:11:03 +0000
Subject: [lm-sensors] [PATCH 1/1] hwmon: (adt7470) Fix incorrect return code check
Message-Id: <1375989063-24337-1-git-send-email-curt@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Curt Brune <curt@cumulusnetworks.com>

In adt7470_write_word_data(), which writes two bytes using
i2c_smbus_write_byte_data(), the return codes are incorrectly AND-ed
together when they should be OR-ed together.

The return code of i2c_smbus_write_byte_data() is zero for success.

The upshot is only the first byte was ever written to the hardware.
The 2nd byte was never written out.

I noticed that trying to set the fan speed limits was not working
correctly on my system.  Setting the fan speed limits is the only
code that uses adt7470_write_word_data().  After making the change
the limit settings work and the alarms work also.

Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
---
 drivers/hwmon/adt7470.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 0f34bca..6099f50 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -215,7 +215,7 @@ static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
 					  u16 value)
 {
 	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
-	       && i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
+	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
 }
 
 static void adt7470_init_client(struct i2c_client *client)
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
