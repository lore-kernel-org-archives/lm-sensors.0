From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH 2.6] I2C: keywest class
Message-Id: <20040822225059.3cd4171f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This is needed for iBook2 owners to be able to use their ADM1030
hardware monitoring chip. Successfully tested by one user.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

--- linux-2.6.8.1/drivers/i2c/busses/i2c-keywest.c.orig	2004-07-24 22:39:04.000000000 +0200
+++ linux-2.6.8.1/drivers/i2c/busses/i2c-keywest.c	2004-08-17 21:03:23.000000000 +0200
@@ -618,6 +618,8 @@
 		chan->iface = iface;
 		chan->chan_no = i;
 		chan->adapter.id = I2C_ALGO_SMBUS;
+		if (i=1)
+			chan->adapter.class = I2C_CLASS_HWMON;
 		chan->adapter.algo = &keywest_algorithm;
 		chan->adapter.algo_data = NULL;
 		chan->adapter.client_register = NULL;


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
