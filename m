From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Jun 2012 20:56:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Fix compile warning
Message-Id: <1339620986-14314-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following compile warning may be seen if the driver is compiled with
-Wuninitialized:

drivers/hwmon/w83781d.c: warning: 'sc_addr[1]' may be used uninitialized in this
function [-Wuninitialized]

While this is a false positive, it is annoying in nightly builds, and may help
to conceal real problems. The current code is quite tricky, and and it is easy
to rearrage the code to make the problem disappear. So fix it.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83781d.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index b03d54a..a82f508 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -867,6 +867,7 @@ w83781d_detect_subclients(struct i2c_client *new_client)
 	struct i2c_adapter *adapter = new_client->adapter;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 	enum chips kind = data->type;
+	int num_adapter = 1;
 
 	id = i2c_adapter_id(adapter);
 
@@ -891,6 +892,7 @@ w83781d_detect_subclients(struct i2c_client *new_client)
 	}
 
 	if (kind != w83783s) {
+		num_adapter = 2;
 		if (force_subclients[0] = id &&
 		    force_subclients[1] = address) {
 			sc_addr[1] = force_subclients[3];
@@ -906,7 +908,7 @@ w83781d_detect_subclients(struct i2c_client *new_client)
 		}
 	}
 
-	for (i = 0; i <= 1; i++) {
+	for (i = 0; i < num_adapter; i++) {
 		data->lm75[i] = i2c_new_dummy(adapter, sc_addr[i]);
 		if (!data->lm75[i]) {
 			dev_err(&new_client->dev, "Subclient %d "
@@ -917,8 +919,6 @@ w83781d_detect_subclients(struct i2c_client *new_client)
 				goto ERROR_SC_3;
 			goto ERROR_SC_2;
 		}
-		if (kind = w83783s)
-			break;
 	}
 
 	return 0;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
