From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH TRIVIAL] Missed ixp42x -> ixp4xx conversion
Message-Id: <20040513071901.GA834@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forgot to include this with my original patch a few weeks ago...

=== include/linux/i2c-id.h 1.20 vs edited ==--- 1.20/include/linux/i2c-id.h	Sun Feb  8 16:04:20 2004
+++ edited/include/linux/i2c-id.h	Thu May 13 00:20:41 2004
@@ -222,7 +222,7 @@
 #define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
 #define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
 #define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
-#define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
+#define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
 
-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
