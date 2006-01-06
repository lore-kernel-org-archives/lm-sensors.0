From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: W83627THF VID fixes
Message-Id: <11365852533127@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: W83627THF VID fixes

This patch fixes the VID reading; no cpu0_vid and vrm files created if
the chip is w83627thf and GPIO5 not enabled.

Signed-off-by: Yuan Mu <ymu at winbond.com.tw>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit dd149c52223cfb05cdefb0755d3c2793e8d33ede
tree 78b0b51586442c66b0d4b948564a6d4863b29766
parent 9c516ef496c857aa4b1b41dc313010f11d39c496
author Yuan Mu <ymu at winbond.com.tw> Sat, 26 Nov 2005 20:13:18 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:20 -0800

 drivers/hwmon/w83627hf.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index bbb3dcd..27cfde1 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1122,11 +1122,10 @@ static int w83627hf_detect(struct i2c_ad
 	if (kind != w83697hf)
 		device_create_file_temp(new_client, 3);
 
-	if (kind != w83697hf)
+	if (kind != w83697hf && data->vid != 0xff) {
 		device_create_file_vid(new_client);
-
-	if (kind != w83697hf)
 		device_create_file_vrm(new_client);
+	}
 
 	device_create_file_fan_div(new_client, 1);
 	device_create_file_fan_div(new_client, 2);
@@ -1232,7 +1231,7 @@ static int w83627thf_read_gpio5(struct i
 
 	/* Make sure the pins are configured for input
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
-	sel = superio_inb(W83627THF_GPIO5_IOSR);
+	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
 		dev_dbg(&client->dev, "GPIO5 not configured for VID "
 			"function\n");
@@ -1323,19 +1322,18 @@ static void w83627hf_init_client(struct 
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
 	} else if (w83627thf = data->type) {
-		data->vid = w83627thf_read_gpio5(client) & 0x3f;
+		data->vid = w83627thf_read_gpio5(client);
 	}
 
 	/* Read VRM & OVT Config only once */
 	if (w83627thf = data->type || w83637hf = data->type) {
 		data->vrm_ovt = 
 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
-		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
-	} else {
-		/* Convert VID to voltage based on default VRM */
-		data->vrm = vid_which_vrm();
 	}
 
+	/* Convert VID to voltage based on VRM */
+	data->vrm = vid_which_vrm();
+
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
 		if (!(tmp & BIT_SCFG1[i - 1])) {


