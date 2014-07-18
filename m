From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 18 Jul 2014 08:02:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max1668) Make max1668_addr_list array const
Message-Id: <1405670558.6632.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/max1668.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index e3ed0a5..7ca8899 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -30,7 +30,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short max1668_addr_list[] = {
+static const unsigned short max1668_addr_list[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /* max1668 registers */
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
