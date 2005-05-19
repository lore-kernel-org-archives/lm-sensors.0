From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: [PATCH 2.6] I2C: Recognize new revision of the ADT7463 chip
Message-Id: <20050318232011.2baa8e11.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch to the lm85 driver adds recognition of a new revision
of the ADT7463 chip.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-mm3/drivers/i2c/chips/lm85.c.orig	2005-03-13 20:03:28.000000000 +0100
+++ linux-2.6.11-mm3/drivers/i2c/chips/lm85.c	2005-03-18 23:03:42.000000000 +0100
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


-- 
Jean Delvare
