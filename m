From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Oct 2009 13:20:27 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (it87) Verify the VID pin usage
Message-Id: <20091022152027.3366ce4b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The VID input pins can alternatively be used as GPIOs. Make sure we
have at least 4 pins used for VID, otherwise don't bother reading and
exposing VID.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |    1 -
 drivers/hwmon/it87.c     |   18 ++++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

--- linux-2.6.32-rc5.orig/drivers/hwmon/it87.c	2009-10-22 14:44:20.000000000 +0200
+++ linux-2.6.32-rc5/drivers/hwmon/it87.c	2009-10-22 14:54:17.000000000 +0200
@@ -124,6 +124,7 @@ superio_exit(void)
 #define IT87_BASE_REG 0x60
 
 /* Logical device 7 registers (IT8712F and later) */
+#define IT87_SIO_GPIO3_REG	0x27
 #define IT87_SIO_PINX2_REG	0x2c	/* Pin selection */
 #define IT87_SIO_VID_REG	0xfc	/* VID value */
 
@@ -244,6 +245,7 @@ struct it87_sio_data {
 	/* Values read from Super-I/O config space */
 	u8 revision;
 	u8 vid_value;
+	u8 skip_vid;
 	/* Values set based on DMI strings */
 	u8 skip_pwm;
 };
@@ -1028,11 +1030,20 @@ static int __init it87_find(unsigned sho
 		chip_type, *address, sio_data->revision);
 
 	/* Read GPIO config and VID value from LDN 7 (GPIO) */
-	if (sio_data->type != it87) {
+	if (sio_data->type = it87) {
+		/* The IT8705F doesn't have VID pins at all */
+		sio_data->skip_vid = 1;
+	} else {
 		int reg;
 
 		superio_select(GPIO);
-		if (sio_data->type = it8718 || sio_data->type = it8720)
+		/* We need at least 4 VID pins */
+		reg = superio_inb(IT87_SIO_GPIO3_REG);
+		if (reg & 0x0f)
+			sio_data->skip_vid = 1;
+
+		if ((sio_data->type = it8718 || sio_data->type = it8720)
+		 && !(sio_data->skip_vid))
 			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
 
 		reg = superio_inb(IT87_SIO_PINX2_REG);
@@ -1236,8 +1247,7 @@ static int __devinit it87_probe(struct p
 		}
 	}
 
-	if (data->type = it8712 || data->type = it8716
-	 || data->type = it8718 || data->type = it8720) {
+	if (!sio_data->skip_vid) {
 		data->vrm = vid_which_vrm();
 		/* VID reading from Super-I/O config space if available */
 		data->vid = sio_data->vid_value;
--- linux-2.6.32-rc5.orig/Documentation/hwmon/it87	2009-10-22 15:07:15.000000000 +0200
+++ linux-2.6.32-rc5/Documentation/hwmon/it87	2009-10-22 15:07:28.000000000 +0200
@@ -86,7 +86,6 @@ The IT8712F and IT8716F additionally fea
 the Vcore voltage of the processor. The early IT8712F have 5 VID pins,
 the IT8716F and late IT8712F have 6. They are shared with other functions
 though, so the functionality may not be available on a given system.
-The driver dumbly assume it is there.
 
 The IT8718F and IT8720F also features VID inputs (up to 8 pins) but the value
 is stored in the Super-I/O configuration space. Due to technical limitations,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
