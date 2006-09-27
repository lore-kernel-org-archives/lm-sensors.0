From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:44 +0000
Subject: [lm-sensors] [PATCH 13/30] i2c-matroxfb: Struct init conversion
Message-Id: <11593189642739-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-matroxfb: Struct init conversion

Convert the struct i2c_algo_bit_data initialization to proper C99
style.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Petr Vandrovec <vandrove at vc.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/video/matrox/i2c-matroxfb.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/matrox/i2c-matroxfb.c b/drivers/video/matrox/i2c-matroxfb.c
index 57abbae..9842042 100644
--- a/drivers/video/matrox/i2c-matroxfb.c
+++ b/drivers/video/matrox/i2c-matroxfb.c
@@ -95,12 +95,13 @@ static struct i2c_adapter matrox_i2c_ada
 
 static struct i2c_algo_bit_data matrox_i2c_algo_template  {
-	NULL,
-	matroxfb_gpio_setsda,
-	matroxfb_gpio_setscl,
-	matroxfb_gpio_getsda,
-	matroxfb_gpio_getscl,
-	10, 10, 100,
+	.setsda		= matroxfb_gpio_setsda,
+	.setscl		= matroxfb_gpio_setscl,
+	.getsda		= matroxfb_gpio_getsda,
+	.getscl		= matroxfb_gpio_getscl,
+	.udelay		= 10,
+	.mdelay		= 10,
+	.timeout	= 100,
 };
 
 static int i2c_bus_reg(struct i2c_bit_adapter* b, struct matrox_fb_info* minfo, 
-- 
1.4.2.1


