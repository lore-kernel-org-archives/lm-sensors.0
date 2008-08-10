From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 10 Aug 2008 21:08:36 +0000
Subject: [lm-sensors] [2.6 patch] make ad7414_update_device() static
Message-Id: <20080810210836.GA5480@cs181140183.pp.htv.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch makes the needlessly global ad7414_update_device() static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
aa3c1d5758663dffa995ae2a0a21fa7b172c371c 
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index ce8d94f..bfda8c8 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -69,7 +69,7 @@ static inline int ad7414_write(struct i2c_client *client, u8 reg, u8 value)
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-struct ad7414_data *ad7414_update_device(struct device *dev)
+static struct ad7414_data *ad7414_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ad7414_data *data = i2c_get_clientdata(client);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
