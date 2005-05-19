From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <1101860019530@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11018600192512@kroah.com>
References: <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2223.2.8, 2004/11/24 14:34:51-08:00, greg@kroah.com

[PATCH] I2C: make fixup_fan_min static in adm1026 driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1026.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c	2004-11-30 16:00:48 -08:00
+++ b/drivers/i2c/chips/adm1026.c	2004-11-30 16:00:48 -08:00
@@ -914,7 +914,7 @@
 fan_offset(8);
 
 /* Adjust fan_min to account for new fan divisor */
-void fixup_fan_min(struct device *dev, int fan, int old_div)
+static void fixup_fan_min(struct device *dev, int fan, int old_div)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);

