From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Jul 2015 20:26:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7802) Fix integer overflow seen when writing voltage limits
Message-Id: <1436041578-14411-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Writing a large value into a voltage limit attribute can result
in an overflow due to an auto-conversion from unsigned long to
unsigned int.

Cc: Constantine Shulyupin <const@MakeLinux.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct7802.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 658bc91033a2..457b0f2678a4 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -262,7 +262,7 @@ abort:
 }
 
 static int nct7802_write_voltage(struct nct7802_data *data, int nr, int index,
-				 unsigned int voltage)
+				 unsigned long voltage)
 {
 	int shift = 8 - REG_VOLTAGE_LIMIT_MSB_SHIFT[index - 1][nr];
 	int err;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
