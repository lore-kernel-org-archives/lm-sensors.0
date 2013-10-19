From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 19 Oct 2013 09:12:22 +0000
Subject: [lm-sensors] [patch] hwmon: (w83793) Clean up a signedness issue
Message-Id: <20131019091222.GF9312@longonot.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

We cap the upper bound of "mtimeout" but since it's signed we should
check for negative values as well.  The mistake is harmless.  But I have
changed it to unsigned as a cleanup.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index b6470ec..9d63d71 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1199,7 +1199,8 @@ static void w83793_init_client(struct i2c_client *client)
 
 static int watchdog_set_timeout(struct w83793_data *data, int timeout)
 {
-	int ret, mtimeout;
+	unsigned int mtimeout;
+	int ret;
 
 	mtimeout = DIV_ROUND_UP(timeout, 60);
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
