From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [PATCH] I2C update for 2.6.6
Message-Id: <10845773584101@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10845773583910@kroah.com>
References: <10845773562431@kroah.com>
In-Reply-To: <10845773562431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1587.15.18, 2004/05/14 15:00:02-07:00, dsaxena@plexity.net

[PATCH] I2C: Missed ixp42x -> ixp4xx conversion

Forgot to include this with my original patch a few weeks ago...


 include/linux/i2c-id.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Fri May 14 16:18:19 2004
+++ b/include/linux/i2c-id.h	Fri May 14 16:18:19 2004
@@ -222,7 +222,7 @@
 #define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
 #define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
 #define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
-#define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
+#define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
 

