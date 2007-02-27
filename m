From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 17:28:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: Only call vid_which_vrm() when needed
Message-Id: <20070227182858.2ed88b4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some hardware monitoring drivers create the VID/VRM interface files
conditionally depending on the chip model or configuration. We should
only call vid_which_vrm() when we are actually going to create the
files. Not only it is more logical and efficient that way, but it also
prevents printing unnecessary warnings such as the one reported here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018954.html

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/lm87.c     |    2 +-
 drivers/hwmon/w83627hf.c |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.21-rc1.orig/drivers/hwmon/w83627hf.c	2007-02-25 15:53:06.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/w83627hf.c	2007-02-27 17:52:49.000000000 +0100
@@ -1181,12 +1181,16 @@ static int w83627hf_detect(struct i2c_ad
 					&dev_attr_temp3_type)))
 			goto ERROR4;
 
-	if (kind != w83697hf && data->vid != 0xff)
+	if (kind != w83697hf && data->vid != 0xff) {
+		/* Convert VID to voltage based on VRM */
+		data->vrm = vid_which_vrm();
+
 		if ((err = device_create_file(&new_client->dev,
 					&dev_attr_cpu0_vid))
 		 || (err = device_create_file(&new_client->dev,
 					&dev_attr_vrm)))
 			goto ERROR4;
+	}
 
 	if (kind = w83627thf || kind = w83637hf || kind = w83687thf)
 		if ((err = device_create_file(&new_client->dev,
@@ -1420,9 +1424,6 @@ static void w83627hf_init_client(struct 
 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
 	}
 
-	/* Convert VID to voltage based on VRM */
-	data->vrm = vid_which_vrm();
-
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
 		if (!(tmp & BIT_SCFG1[i - 1])) {
--- linux-2.6.21-rc1.orig/drivers/hwmon/lm87.c	2007-02-09 09:17:47.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/lm87.c	2007-02-27 18:10:10.000000000 +0100
@@ -747,6 +747,7 @@ static int lm87_detect(struct i2c_adapte
 	}
 
 	if (!(data->channel & CHAN_NO_VID)) {
+		data->vrm = vid_which_vrm();
 		if ((err = device_create_file(&new_client->dev,
 					&dev_attr_cpu0_vid))
 		 || (err = device_create_file(&new_client->dev,
@@ -779,7 +780,6 @@ static void lm87_init_client(struct i2c_
 	u8 config;
 
 	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
-	data->vrm = vid_which_vrm();
 
 	config = lm87_read_value(client, LM87_REG_CONFIG);
 	if (!(config & 0x01)) {


-- 
Jean Delvare

