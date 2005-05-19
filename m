From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814522824@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814522020@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.21, 2004/04/09 12:06:02-07:00, greg@kroah.com

[PATCH] I2C: minor bugfixes for the pcf8591.c driver and formatting cleanups.


 drivers/i2c/chips/pcf8591.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:13:11 2004
+++ b/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:13:11 2004
@@ -125,8 +125,7 @@
 	unsigned int value;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
-	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255);
-	{
+	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
 		data->aout = value;
 		i2c_smbus_write_byte_data(client, data->control, data->aout);
 	}
@@ -235,9 +234,9 @@
 	/* OK, this is not exactly good programming practice, usually. But it is
 	   very code-efficient in this case. */
 
-      exit_kfree:
+exit_kfree:
 	kfree(new_client);
-      exit:
+exit:
 	return err;
 }
 
@@ -277,8 +276,7 @@
 
 	down(&data->update_lock);
 
-	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel)
-	{
+	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel) {
 		data->control = (data->control & ~PCF8591_CONTROL_AICH_MASK)
 			      | channel;
 		i2c_smbus_write_byte(client, data->control);

