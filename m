From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Date: Wed, 11 Mar 2009 17:11:37 +0000
Subject: [lm-sensors] [PATCH] hwmon/f75375s.c: remove unnecessary
Message-Id: <200903111711.n2BHBbPs024221@pogo.cesa.opbu.xerox.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

f75375_probe calls i2c_get_clientdata to initialize the data pointer,
but there isn't yet any client data to get, and the value is never
used before the variable is assigned a new value seven lines later.

The call doesn't hurt anything and wastes only a couple of cycles.
The reason to fix it is because this module serves as an example to
hackers writing new hwmon drivers, and this part of the example is
confusing.

Signed-off-by: Andrew Klossner <andrew@cesa.opbu.xerox.com>
---
 drivers/hwmon/f75375s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 1692de3..18a1ba8 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -617,7 +617,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 static int f75375_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	struct f75375_data *data = i2c_get_clientdata(client);
+	struct f75375_data *data;
 	struct f75375s_platform_data *f75375s_pdata = client->dev.platform_data;
 	int err;
 
-- 
1.6.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
