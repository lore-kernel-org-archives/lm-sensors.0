From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734162392@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030922232846.GA800@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1153.85.1, 2003/08/27 15:24:53-07:00, greg@kroah.com

[PATCH] I2C: added new id for Radeon driver.

As requested by kronos@kronoz.cjb.net


 include/linux/i2c-id.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Mon Sep 22 16:17:15 2003
+++ b/include/linux/i2c-id.h	Mon Sep 22 16:17:15 2003
@@ -100,7 +100,7 @@
 #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
-
+#define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
 
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/

