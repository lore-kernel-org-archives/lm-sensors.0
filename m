From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 13:17:32 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: pcf8574 driver cleanup
Message-Id: <20050604131743.1a13baad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I found a possible cleanup in the pcf8574 driver. We don't need to store
the read value in our private data structure, as we then never use it
again. I asked Aurelien and he is fine with the change. Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/pcf8574.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc5.orig/drivers/i2c/chips/pcf8574.c	2005-05-25 20:55:47.000000000 +0200
+++ linux-2.6.12-rc5/drivers/i2c/chips/pcf8574.c	2005-06-04 08:15:46.000000000 +0200
@@ -57,7 +57,7 @@
 struct pcf8574_data {
 	struct i2c_client client;
 
-	u8 read, write;			/* Register values */
+	u8 write;			/* Remember last written value */
 };
 
 static int pcf8574_attach_adapter(struct i2c_adapter *adapter);
@@ -79,9 +79,7 @@
 static ssize_t show_read(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8574_data *data = i2c_get_clientdata(client);
-	data->read = i2c_smbus_read_byte(client); 
-	return sprintf(buf, "%u\n", data->read);
+	return sprintf(buf, "%u\n", i2c_smbus_read_byte(client));
 }
 
 static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);


-- 
Jean Delvare
