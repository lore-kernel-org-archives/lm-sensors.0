From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <1089850026355@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10898500251206@kroah.com>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1784.13.3, 2004/07/08 16:06:41-07:00, khali@linux-fr.org

[PATCH] I2C: Class of scx200_acb

This is needed for the scx200_acb to accept hardware monitoring chips.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/scx200_acb.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	2004-07-14 17:00:29 -07:00
+++ b/drivers/i2c/busses/scx200_acb.c	2004-07-14 17:00:29 -07:00
@@ -458,6 +458,7 @@
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
+	adapter->class = I2C_CLASS_HWMON;
 
 	init_MUTEX(&iface->sem);
 

