From: Kelly Anderson <kelly@silka.with-linux.com>
Date: Fri, 07 Sep 2012 23:34:41 +0000
Subject: [lm-sensors] [PATCH 1/1] Add lm-sensors support for it8771 (Asus E350M1-I).
Message-Id: <1347060881-14106-2-git-send-email-kelly@silka.with-linux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

---
 drivers/hwmon/it87.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index f1de397..a184ad6 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -61,7 +61,7 @@
 
 #define DRVNAME "it87"
 
-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8782,
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771, it8782,
 	     it8783 };
 
 static unsigned short force_id;
@@ -140,6 +140,7 @@ static inline void superio_exit(void)
 #define IT8721F_DEVID 0x8721
 #define IT8726F_DEVID 0x8726
 #define IT8728F_DEVID 0x8728
+#define IT8771F_DEVID 0x8771
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
 #define IT87_ACT_REG  0x30
@@ -303,7 +304,8 @@ static inline int has_12mv_adc(const struct it87_data *data)
 	 * on selected inputs.
 	 */
 	return data->type = it8721
-	    || data->type = it8728;
+	    || data->type = it8728
+	    || data->type = it8771;
 }
 
 static inline int has_newer_autopwm(const struct it87_data *data)
@@ -313,7 +315,8 @@ static inline int has_newer_autopwm(const struct it87_data *data)
 	 * mapping and the manual duty cycle.
 	 */
 	return data->type = it8721
-	    || data->type = it8728;
+	    || data->type = it8728
+	    || data->type = it8771;
 }
 
 static int adc_lsb(const struct it87_data *data, int nr)
@@ -412,6 +415,7 @@ static inline int has_16bit_fans(const struct it87_data *data)
 	    || data->type = it8720
 	    || data->type = it8721
 	    || data->type = it8728
+	    || data->type = it8771
 	    || data->type = it8782
 	    || data->type = it8783;
 }
@@ -1701,6 +1705,9 @@ static int __init it87_find(unsigned short *address,
 	case IT8728F_DEVID:
 		sio_data->type = it8728;
 		break;
+	case IT8771F_DEVID:
+		sio_data->type = it8771;
+		break;
 	case IT8782F_DEVID:
 		sio_data->type = it8782;
 		break;
@@ -1818,7 +1825,7 @@ static int __init it87_find(unsigned short *address,
 
 		reg = superio_inb(IT87_SIO_GPIO3_REG);
 		if (sio_data->type = it8721 || sio_data->type = it8728 ||
-		    sio_data->type = it8782) {
+		    sio_data->type = it8771 || sio_data->type = it8782) {
 			/*
 			 * IT8721F/IT8758E, and IT8782F don't have VID pins
 			 * at all, not sure about the IT8728F.
@@ -1875,7 +1882,8 @@ static int __init it87_find(unsigned short *address,
 		if (reg & (1 << 0))
 			sio_data->internal |= (1 << 0);
 		if ((reg & (1 << 1)) || sio_data->type = it8721 ||
-		    sio_data->type = it8728)
+		    sio_data->type = it8728 ||
+		    sio_data->type = it8771)
 			sio_data->internal |= (1 << 1);
 
 		/*
@@ -1984,6 +1992,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
 		"it8720",
 		"it8721",
 		"it8728",
+		"it8771",
 		"it8782",
 		"it8783",
 	};
-- 
1.7.12


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
