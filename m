From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:26:22 +0000
Subject: [lm-sensors] [PATCH 06/14] it87: Prevent overflow on fan clock
Message-Id: <20060828142622.4e6c9492.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-div-to-reg-overflow.patch

it87: Prevent overflow on fan clock divider write

The highest possible clock divider for fan1 and fan2 is 128.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-25 19:15:34.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-25 19:15:37.000000000 +0200
@@ -198,7 +198,7 @@
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	while ((val >>= 1) != 0)
+	while (answer < 7 && (val >>= 1))
 		answer++;
 	return answer;
 }
@@ -562,7 +562,7 @@
 
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int i, min[3];
 	u8 old;
 

-- 
Jean Delvare

