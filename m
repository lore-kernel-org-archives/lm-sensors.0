From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test5
Message-Id: <1064526609700@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1064526609144@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1325.5.2, 2003/09/24 15:01:39-07:00, greg@kroah.com

[PATCH] I2C: remove unneeded #defines in the eeprom chip driver.


 drivers/i2c/chips/eeprom.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Thu Sep 25 14:49:30 2003
+++ b/drivers/i2c/chips/eeprom.c	Thu Sep 25 14:49:30 2003
@@ -47,13 +47,6 @@
 /* EEPROM registers */
 #define EEPROM_REG_CHECKSUM	0x3f
 
-/* EEPROM memory types: */
-#define ONE_K			1
-#define TWO_K			2
-#define FOUR_K			3
-#define EIGHT_K			4
-#define SIXTEEN_K		5
-
 /* Size of EEPROM in bytes */
 #define EEPROM_SIZE		256
 

