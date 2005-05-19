From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [PATCH 2.6] Class of scx200_acb
Message-Id: <20040701211758.27f136a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This is needed for the scx200_acb to accept hardware monitoring chips.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

--- linux-2.6.7-mm5/drivers/i2c/busses/scx200_acb.c.orig	Thu Jul  1 20:22:17 2004
+++ linux-2.6.7-mm5/drivers/i2c/busses/scx200_acb.c	Thu Jul  1 20:34:47 2004
@@ -458,6 +458,7 @@
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
+	adapter->class = I2C_CLASS_HWMON;
 
 	init_MUTEX(&iface->sem);
 


-- 
Jean Delvare
http://khali.linux-fr.org/
