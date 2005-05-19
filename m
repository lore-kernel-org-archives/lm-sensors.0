From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH 2.6] probe fewer addresses for asb100 (sensors) driver
Message-Id: <20050102212501.GA17759@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

This patch limits SMBus scanning for the asb100 sensor chip
to just one address - the only one we've ever seen in practice.

Signed-off-by Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.10-mmh/drivers/i2c/chips/asb100.c
=================================--- linux-2.6.10-mmh.orig/drivers/i2c/chips/asb100.c	2005-01-02 16:17:07.127720911 -0500
+++ linux-2.6.10-mmh/drivers/i2c/chips/asb100.c	2005-01-02 16:17:16.098274578 -0500
@@ -56,8 +56,7 @@
 #define ASB100_VERSION "1.0.0"
 
 /* I2C addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-					0x2e, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
 /* ISA addresses to scan (none) */
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };

-- 
Mark M. Hoffman
mhoffman@lightlink.com
