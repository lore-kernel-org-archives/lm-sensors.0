From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Request for I2C IDs
Message-Id: <20040531213305.52b1ab12.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118175528.66a9d01a.khali@linux-fr.org>
In-Reply-To: <20040118175528.66a9d01a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Greg, should I send a patch to you with these?
> 
> Sure, if it's needed.

Just noticed that I never sent the promised patch. Here it is. I also
added a few other IDs, since we have them in our (2.4) i2c CVS
repository. Having them in 2.6 as well will at least prevent collisions.

Thanks.

--- linux-2.6.7-rc2/include/linux/i2c-id.h.orig	Mon May 31 21:22:40 2004
+++ linux-2.6.7-rc2/include/linux/i2c-id.h	Mon May 31 21:26:48 2004
@@ -101,6 +101,14 @@
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
 #define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
+#define I2C_DRIVERID_MAX1617	56	/* temp sensor			*/
+#define I2C_DRIVERID_SAA7191	57	/* video encoder		*/
+#define I2C_DRIVERID_INDYCAM	58	/* SGI IndyCam			*/
+#define I2C_DRIVERID_BT832	59	/* CMOS camera video processor	*/
+#define I2C_DRIVERID_TDA9887	60	/* TDA988x IF-PLL demodulator	*/
+#define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
+#define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/
+#define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
 
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
@@ -264,6 +272,10 @@
 #define I2C_HW_SMBUS_SCX200	0x0b
 #define I2C_HW_SMBUS_NFORCE2	0x0c
 #define I2C_HW_SMBUS_W9968CF	0x0d
+#define I2C_HW_SMBUS_OV511	0x0e	/* OV511(+) USB 1.1 webcam ICs	*/
+#define I2C_HW_SMBUS_OV518	0x0f	/* OV518(+) USB 1.1 webcam ICs	*/
+#define I2C_HW_SMBUS_OV519	0x10	/* OV519 USB 1.1 webcam IC	*/
+#define I2C_HW_SMBUS_OVFX2	0x11	/* Cypress/OmniVision FX2 webcam */
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA 0x00


-- 
Jean Delvare
http://khali.linux-fr.org/
