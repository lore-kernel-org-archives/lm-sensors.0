From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC PATCH driver pcf8574 not quite right
Message-Id: <5egc41pajhqqmdjingp9utu2m9gd24si4q@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

pcf8574 tried to write an untested value to the chip, one 
way to 'fix' this is simply force the value to byte range.

Who knows proper fix please?

Cheers,
Grant.

--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8574.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm3x/drivers/i2c/chips/pcf8574.c	2005-03-27 12:31:05.000000000 +1000
@@ -97,8 +97,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
-	data->write = simple_strtoul(buf, NULL, 10);
+	unsigned long val = simple_strtoul(buf, NULL, 10) & 0xff;
+
+	down(&data->update_lock);
+	data->write = val;
 	i2c_smbus_write_byte(client, data->write);
+	up(&data->update_lock);
 	return count;
 }
 
