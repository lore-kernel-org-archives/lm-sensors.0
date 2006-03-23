From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 29/36] i2c: Cleanup isp1301_omap
Message-Id: <11431538313450-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop unused rogue i2c driver ID and nonsensical i2c class.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/chips/isp1301_omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

c006705e0f6a195d122be8d5344a4257c269f559
diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 1251c7f..e6f1ab7 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -1635,8 +1635,6 @@ static struct i2c_driver isp1301_driver 
 	.driver = {
 		.name	= "isp1301_omap",
 	},
-	.id		= 1301,		/* FIXME "official", i2c-ids.h */
-	.class		= I2C_CLASS_HWMON,
 	.attach_adapter	= isp1301_scan_bus,
 	.detach_client	= isp1301_detach_client,
 };
-- 
1.2.4



