From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 17 Sep 2008 22:21:31 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: applesmc: Specified number of bytes
Message-Id: <48D182EB.60407@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

At one single place in the code, the specified number of bytes to read
and the actual number of bytes read differ by one. This one-liner
patch fixes that inconsistency.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b06b8e0..b401975 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -325,7 +325,7 @@ static int applesmc_get_key_type(char* key, char* type)
 			return -EIO;
 	}

-	outb(5, APPLESMC_DATA_PORT);
+	outb(6, APPLESMC_DATA_PORT);

 	for (i = 0; i < 6; i++) {
 		if (__wait_status(0x05))
-- 
1.5.4.3



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
