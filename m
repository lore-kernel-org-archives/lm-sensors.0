From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:33 +0000
Subject: [lm-sensors] [PATCH] i2c: Extend ds1337 initialization
Message-Id: <11365852532253@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Extend ds1337 initialization

Add code to handle case where board firmware does not start the
RTC.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
CC: James Chapman <jchapman at katalix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit f9e8957937ebf60d22732a5ca9130f48a7603f60
tree c36adb2b1c9e3ef69bf598ee3084966ef7085596
parent 2e3e13f8e9d9b2111404cdccaa4e1b988b70acce
author Michael Burian <dynmail1 at gassner-waagen.at> Mon, 07 Nov 2005 22:30:14 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:20 -0800

 drivers/i2c/chips/ds1337.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
index 02682fb..1822895 100644
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -337,13 +337,38 @@ exit:
 
 static void ds1337_init_client(struct i2c_client *client)
 {
-	s32 val;
+	u8 status, control;
 
-	/* Ensure that device is set in 24-hour mode */
-	val = i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
-	if ((val >= 0) && (val & (1 << 6)))
-		i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
-					  val & 0x3f);
+	/* On some boards, the RTC isn't configured by boot firmware.
+	 * Handle that case by starting/configuring the RTC now.
+	 */
+	status = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
+	control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+
+	if ((status & 0x80) || (control & 0x80)) {
+		/* RTC not running */
+		u8 buf[16];
+		struct i2c_msg msg[1];
+
+		dev_dbg(&client->dev, "%s: RTC not running!\n", __FUNCTION__);
+
+		/* Initialize all, including STATUS and CONTROL to zero */
+		memset(buf, 0, sizeof(buf));
+		msg[0].addr = client->addr;
+		msg[0].flags = 0;
+		msg[0].len = sizeof(buf);
+		msg[0].buf = &buf[0];
+
+		i2c_transfer(client->adapter, msg, 1);
+	} else {
+		/* Running: ensure that device is set in 24-hour mode */
+		s32 val;
+
+		val = i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
+		if ((val >= 0) && (val & (1 << 6)))
+			i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
+						  val & 0x3f);
+	}
 }
 
 static int ds1337_detach_client(struct i2c_client *client)


