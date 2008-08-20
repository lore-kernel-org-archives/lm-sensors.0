From: Ben Hutchings <bhutchings@solarflare.com>
Date: Wed, 20 Aug 2008 20:15:04 +0000
Subject: [lm-sensors] [PATCH 1/3] lm87: Fix masking of config register in
Message-Id: <171f5b16f9df789450dd058265aabd548337c9ea.1219263169.git.bhutchings@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm87_init_client() conditionally sets the Start bit and clears the
INT#_Clear bit in the Config 1 register.  The condition should be that
either of these bits needs changing, but currently it checks the
(self-clearing) Initialization bit instead of INT#_Clear.

Fix the condition and also ensure we never set the Initialization bit.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 21970f0..0fecbfd 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -867,11 +867,11 @@ static void lm87_init_client(struct i2c_client *client)
 			lm87_write_value(client, LM87_REG_IN_MAX(0), 0xFF);
 		}
 	}
-	if ((config & 0x81) != 0x01) {
-		/* Start monitoring */
+
+	/* Make sure Start is set and INT#_Clear is clear */
+	if ((config & 0x09) != 0x01)
 		lm87_write_value(client, LM87_REG_CONFIG,
-				 (config & 0xF7) | 0x01);
-	}
+				 (config & 0x77) | 0x01);
 }
 
 static int lm87_remove(struct i2c_client *client)

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
