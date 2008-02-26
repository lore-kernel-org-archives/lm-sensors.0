From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 26 Feb 2008 13:52:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asb100) Remove some dead code
Message-Id: <20080226135205.GB2842@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


commit 8e5dcb2c1d3951acd02349fee743834b92ee5def
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Tue Feb 26 08:48:49 2008 -0500

    hwmon: (asb100) Remove some dead code
    
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 84712a2..fe2eea4 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -953,12 +953,8 @@ static void asb100_write_value(struct i2c_client *client, u16 reg, u16 value)
 static void asb100_init_client(struct i2c_client *client)
 {
 	struct asb100_data *data = i2c_get_clientdata(client);
-	int vid = 0;
 
-	vid = asb100_read_value(client, ASB100_REG_VID_FANDIV) & 0x0f;
-	vid |= (asb100_read_value(client, ASB100_REG_CHIPID) & 0x01) << 4;
 	data->vrm = vid_which_vrm();
-	vid = vid_from_reg(vid, data->vrm);
 
 	/* Start monitoring */
 	asb100_write_value(client, ASB100_REG_CONFIG,
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
