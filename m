From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:09 +0000
Subject: [lm-sensors] [PATCH 06/17 v2] hwmon: (asus_atk0110) fix checkpatch
Message-Id: <1326047660-20539-6-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
WARNING: line over 80 characters
#1321: FILE: asus_atk0110.c:1321:
+	if (data->rtmp_handle && data->rvlt_handle && data->rfan_handle && !new_if)

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/asus_atk0110.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 00e9851..4000fee 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -1318,7 +1318,8 @@ static int atk_probe_if(struct atk_data *data)
 	 */
 	if (new_if)
 		dev_info(dev, "Overriding interface detection\n");
-	if (data->rtmp_handle && data->rvlt_handle && data->rfan_handle && !new_if)
+	if (data->rtmp_handle &&
+			data->rvlt_handle && data->rfan_handle && !new_if)
 		data->old_interface = true;
 	else if (data->enumerate_handle && data->read_handle &&
 			data->write_handle)
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
