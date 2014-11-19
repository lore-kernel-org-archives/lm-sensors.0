From: Arnaud Ebalard <arno@natisbad.org>
Date: Wed, 19 Nov 2014 21:52:36 +0000
Subject: [lm-sensors] [PATCHv0] hwmon: g762: fix call to devm_hwmon_device_register_with_groups()
Message-Id: <3b385cc3fdf1884f8902c015c7fa40b7133fd7b8.1416433516.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


g762_remove() needs to first call hwmon_device_unregister() and then
g762_of_clock_disable(). For that reason, it is not possible to
convert it to devm_hwmon_device_register_with_groups() and the
the non device managed version must be used.

This is correctly stated in commit message for 398e16db6262 ("hwmon:
(g762) Convert to hwmon_device_register_with_groups") but the
associated changes do in fact introduce a call to the device managed
version of the function.

This patch fixes that typo by switching to the non devm_ version.

Fixes: 398e16db6262 ("hwmon: (g762) Convert to hwmon_device_register_with_groups")
Cc: stable@vger.kernel.org (3.17+)
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/hwmon/g762.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 6aac695b1688..9b55e673b67c 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -1084,10 +1084,8 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (ret)
 		goto clock_dis;
 
-	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
-								 client->name,
-								 data,
-								 g762_groups);
+	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+							    data, g762_groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
 		goto clock_dis;
-- 
2.1.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
