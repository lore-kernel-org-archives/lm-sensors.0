From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:28 +0000
Subject: [lm-sensors] [PATCH 05/17] drivers/hwmon/adt7475.c: fix checkpatch
Message-Id: <1326039820-11147-5-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/adt7475.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index b5fcd87..761cbf3 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1232,7 +1232,7 @@ static void adt7475_remove_files(struct i2c_client *client,
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	static const char *names[] = {
+	static const char * const names[] = {
 		[adt7473] = "ADT7473",
 		[adt7475] = "ADT7475",
 		[adt7476] = "ADT7476",
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
