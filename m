From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 08:30:20 +0000
Subject: [lm-sensors] [PATCH] Drivers: hwmon: adm1031: fixed indent coding
Message-Id: <1321605020-13458-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed indent coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/hwmon/adm1031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 0683e6b..70fb6ac 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -976,7 +976,7 @@ static void adm1031_init_client(struct i2c_client *client)
 
 	read_val = adm1031_read_value(client, ADM1031_REG_CONF1);
 	if ((read_val | ADM1031_CONF1_MONITOR_ENABLE) != read_val) {
-	    adm1031_write_value(client, ADM1031_REG_CONF1, read_val |
+		adm1031_write_value(client, ADM1031_REG_CONF1, read_val |
 				ADM1031_CONF1_MONITOR_ENABLE);
 	}
 
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
