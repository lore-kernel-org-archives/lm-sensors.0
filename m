From: Olof Johansson <olof@lixom.net>
Date: Tue, 23 Oct 2007 22:53:23 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm90: Quiet down error messages when
Message-Id: <20071023225323.GA9467@lixom.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The commit "hwmon/lm90: Add support for the Maxim MAX6680/MAX6681"
added a number of new addresses to probe for lm90 devices, which for me
resulted in a bunch of these during boot (26 of them!):

Register 0xfe read failed (-1)
Register 0xfe read failed (-1)
Register 0xfe read failed (-1)

I.e. one for every failed probe -- 3 busses, 9 addresses.

No other hwmon driver prints debug info like this, so let's just get
rid of it.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 960df9f..b21ca19 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -470,11 +470,8 @@ static int lm90_read_reg(struct i2c_client* client, u8 reg, u8 *value)
  	} else
  		err = i2c_smbus_read_byte_data(client, reg);
 
-	if (err < 0) {
-		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
-			 reg, err);
+	if (err < 0)
 		return err;
-	}
 	*value = err;
 
 	return 0;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
