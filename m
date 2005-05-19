From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [PATCH] i2c driver changes for 2.5.70
Message-Id: <10548465592180@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10548465592488@kroah.com>
References: <1054846559915@kroah.com>
In-Reply-To: <1054846559915@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1259.3.4, 2003/06/05 13:14:37-07:00, greg@kroah.com

[PATCH] I2C: sync i2c-id.h with cvs version.


 include/linux/i2c-id.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Thu Jun  5 13:50:01 2003
+++ b/include/linux/i2c-id.h	Thu Jun  5 13:50:01 2003
@@ -98,6 +98,7 @@
 #define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
 #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
+#define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 
 
 
@@ -178,6 +179,7 @@
 #define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
+#define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
 
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
@@ -213,6 +215,9 @@
 #define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
 #define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
 #define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
+#define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
+#define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
+#define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
@@ -234,6 +239,8 @@
 /* --- PowerPC on-chip adapters						*/
 #define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
 
+/* --- XSCALE on-chip adapters                          */
+#define I2C_HW_IOP321 0x00
 
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00

