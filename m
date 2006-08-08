From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Aug 2006 14:08:16 +0000
Subject: [lm-sensors] [PATCH 3/5] it87: Prevent overflow on fan clock
Message-Id: <20060808160816.13732803.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it87: Prevent overflow on fan clock divider write

The highest possible clock divider for fan1 and fan2 is 128.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-08 13:02:41.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-08 13:40:06.000000000 +0200
@@ -197,7 +197,7 @@
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	while ((val >>= 1) != 0)
+	while (answer < 7 && (val >>= 1))
 		answer++;
 	return answer;
 }
@@ -578,7 +578,7 @@
 
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int i, min[3];
 	u8 old;
 


-- 
Jean Delvare

