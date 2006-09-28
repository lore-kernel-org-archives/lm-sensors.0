From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:28 +0000
Subject: [lm-sensors] [PATCH 8/39] it87: Prevent overflow on fan clock
Message-Id: <11594837643683-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

it87: Prevent overflow on fan clock divider write

The highest possible clock divider for fan1 and fan2 is 128.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/it87.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 0317e44..fc75fcb 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -198,7 +198,7 @@ #define PWM_FROM_REG(val) (((val)&0x7f) 
 static int DIV_TO_REG(int val)
 {
 	int answer = 0;
-	while ((val >>= 1) != 0)
+	while (answer < 7 && (val >>= 1))
 		answer++;
 	return answer;
 }
@@ -563,7 +563,7 @@ static ssize_t set_fan_div(struct device
 
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int i, min[3];
 	u8 old;
 
-- 
1.4.2.1


