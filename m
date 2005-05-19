From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] I2C: Recognize new revision of the ADT7463 chip
Message-Id: <111231139374@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113921804@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2338, 2005/03/31 14:29:05-08:00, khali@linux-fr.org

[PATCH] I2C: Recognize new revision of the ADT7463 chip

This simple patch to the lm85 driver adds recognition of a new revision
of the ADT7463 chip.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/lm85.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2005-03-31 15:17:25 -08:00
+++ b/drivers/i2c/chips/lm85.c	2005-03-31 15:17:25 -08:00
@@ -74,6 +74,7 @@
 #define	LM85_VERSTEP_LM85B		0x62
 #define	LM85_VERSTEP_ADM1027		0x60
 #define	LM85_VERSTEP_ADT7463		0x62
+#define	LM85_VERSTEP_ADT7463C		0x6A
 #define	LM85_VERSTEP_EMC6D100_A0        0x60
 #define	LM85_VERSTEP_EMC6D100_A1        0x61
 
@@ -1089,7 +1090,8 @@
 		    && verstep = LM85_VERSTEP_ADM1027 ) {
 			kind = adm1027 ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
-		    && verstep = LM85_VERSTEP_ADT7463 ) {
+		    && (verstep = LM85_VERSTEP_ADT7463
+			 || verstep = LM85_VERSTEP_ADT7463C) ) {
 			kind = adt7463 ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
 		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC ) {

