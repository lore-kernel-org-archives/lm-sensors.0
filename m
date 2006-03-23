From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 28/36] i2c: Fix i2c-ite name initialization
Message-Id: <11431538312811-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Properly set the name member of the i2c_adapter structure of the ite
i2c adapter driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/i2c-ite.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

f8d6d9f52b4977f5427e2cb782521611a823c108
diff --git a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
index 5f5d294..d82e6da 100644
--- a/drivers/i2c/busses/i2c-ite.c
+++ b/drivers/i2c/busses/i2c-ite.c
@@ -200,9 +200,7 @@ static struct i2c_adapter iic_ite_ops = 
 	.owner		= THIS_MODULE,
 	.id		= I2C_HW_I_IIC,
 	.algo_data	= &iic_ite_data,
-	.dev		= {
-		.name	= "ITE IIC adapter",
-	},
+	.name		= "ITE IIC adapter",
 };
 
 /* Called when the module is loaded.  This function starts the
-- 
1.2.4



