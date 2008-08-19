From: Ben Hutchings <bhutchings@solarflare.com>
Date: Tue, 19 Aug 2008 15:01:57 +0000
Subject: [lm-sensors] [PATCH 1/2] lm87: Fix masking of config register in
Message-Id: <20080819150156.GH7908@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm87_init_client() does:

	if ((config & 0x81) != 0x01) {
		/* Start monitoring */
		lm87_write_value(client, LM87_REG_CONFIG,
				 (config & 0xF7) | 0x01);
	}

This means that if the Start bit is clear or the Initialization bit is
set we set the Start bit and clear the INT#_Clear bit.  I think this
should actually clear the Initialization bit and that 0xF7 is a typo
for 0x7F.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 21970f0..ddad6fc 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -870,7 +870,7 @@ static void lm87_init_client(struct i2c_client *client)
 	if ((config & 0x81) != 0x01) {
 		/* Start monitoring */
 		lm87_write_value(client, LM87_REG_CONFIG,
-				 (config & 0xF7) | 0x01);
+				 (config & ~0x80) | 0x01);
 	}
 }
 
-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
