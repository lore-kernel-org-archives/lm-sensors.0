From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 08 Feb 2012 17:56:10 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (f75375s) Fix bit shifting in f75375_write16
Message-Id: <1328723771-22163-4-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Nikolaus Schulz <schulz@macnetix.de>

In order to extract the high byte of the 16-bit word, shift the word to
the right, not to the left.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
Cc: stable@kernel.org
---
 drivers/hwmon/f75375s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index b3eef44..0aabaaf 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -172,7 +172,7 @@ static inline void f75375_write8(struct i2c_client *client, u8 reg,
 static inline void f75375_write16(struct i2c_client *client, u8 reg,
 		u16 value)
 {
-	int err = i2c_smbus_write_byte_data(client, reg, (value << 8));
+	int err = i2c_smbus_write_byte_data(client, reg, (value >> 8));
 	if (err)
 		return;
 	i2c_smbus_write_byte_data(client, reg + 1, (value & 0xFF));
-- 
1.7.9


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
