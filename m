From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 08:19:45 +0000
Subject: [lm-sensors] [PATCH 34/34] Drivers: hwmon: adm1031: fixed a coding
Message-Id: <1321604385-13240-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/hwmon/adm1031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 6e80cf0..0bd2ae7 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -230,7 +230,7 @@ static const auto_chan_table_t auto_channel_select_table_adm1030 = {
  */
 static int
 get_fan_auto_nearest(struct adm1031_data *data,
-		     int chan, u8 val, u8 reg, u8 * new_reg)
+		     int chan, u8 val, u8 reg, u8 *new_reg)
 {
 	int i;
 	int first_match = -1, exact_match = -1;
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
