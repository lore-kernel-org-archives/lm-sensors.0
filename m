From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814543859@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1081981453937@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.30, 2004/04/14 13:10:38-07:00, khali@linux-fr.org

[PATCH] I2C: Fix voltage rounding in asb100

This one line patch fixes voltage rounding in the asb100 chip driver.
It's very similar to a patch I submitted for the lm80 a few days ago.


 drivers/i2c/chips/asb100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:13 2004
+++ b/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:13 2004
@@ -124,7 +124,7 @@
 static u8 IN_TO_REG(unsigned val)
 {
 	unsigned nval = SENSORS_LIMIT(val, ASB100_IN_MIN, ASB100_IN_MAX);
-	return nval / 16;
+	return (nval + 8) / 16;
 }
 
 static unsigned IN_FROM_REG(u8 reg)

