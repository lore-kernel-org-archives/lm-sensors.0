From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:13 +0000
Subject: [lm-sensors] [PATCH 1/13] [PATCH] i2c: Fix 'ignore' module
Message-Id: <11527468454006-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Mark M. Hoffman <mhoffman at lightlink.com>

This patch fixes a bug in the handling of 'ignore' module parameters of I2C
client drivers.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a45155f..9cb277d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -756,9 +756,9 @@ int i2c_probe(struct i2c_adapter *adapte
 					"parameter for adapter %d, "
 					"addr 0x%02x\n", adap_id,
 					address_data->ignore[j + 1]);
+				ignore = 1;
+				break;
 			}
-			ignore = 1;
-			break;
 		}
 		if (ignore)
 			continue;
-- 
1.4.1


