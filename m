From: Axel Lin <axel.lin@gmail.com>
Date: Mon, 08 Nov 2010 05:11:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7470) Return proper error code
Message-Id: <1289193093.682.1.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, "Darrick J. Wong" <djwong@us.ibm.com>, lm-sensors@lm-sensors.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/adt7470.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 9e77571..87d92a5 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1286,8 +1286,10 @@ static int adt7470_probe(struct i2c_client *client,
 	init_completion(&data->auto_update_stop);
 	data->auto_update = kthread_run(adt7470_update_thread, client,
 					dev_name(data->hwmon_dev));
-	if (IS_ERR(data->auto_update))
+	if (IS_ERR(data->auto_update)) {
+		err = PTR_ERR(data->auto_update);
 		goto exit_unregister;
+	}
 
 	return 0;
 
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
