From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: [PATCH 2.6] Make i2c list terminators explicitely unsigned
Message-Id: <20050224222935.5524648c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Shouldn't the i2c list terminators be explicitely declared as unsigned?
I'd hope it to help code analysis tools and possibly avoid false
positives. Coverity's SWAT pointed my attention to these constants.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc4/include/linux/i2c.h.orig	Thu Feb 24 14:23:31 2005
+++ linux-2.6.11-rc4/include/linux/i2c.h	Thu Feb 24 11:36:30 2005
@@ -302,8 +302,8 @@
 };
 
 /* Internal numbers to terminate lists */
-#define I2C_CLIENT_END		0xfffe
-#define I2C_CLIENT_ISA_END	0xfffefffe
+#define I2C_CLIENT_END		0xfffeU
+#define I2C_CLIENT_ISA_END	0xfffefffeU
 
 /* The numbers to use to set I2C bus address */
 #define ANY_I2C_BUS		0xffff


-- 
Jean Delvare
