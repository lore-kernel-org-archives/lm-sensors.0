From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Mon, 06 Oct 2008 17:31:10 +0000
Subject: [lm-sensors] [PATCH] Allow it87.c to handle IT8720
Message-Id: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The goal of this patch is to allow it87.c to handle IT8720 chipset
like IT8718 in order to retreive voltage, temperatures and fans speed
from sensors tools.

JMS



--- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02
09:04:44.000000000 -0400
+++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-06
13:27:08.000000000 -0400
@@ -14,6 +14,7 @@
               IT8712F  Super I/O chip w/LPC interface
               IT8716F  Super I/O chip w/LPC interface
               IT8718F  Super I/O chip w/LPC interface
+             IT8720F  Super I/O chip w/LPC interface
               IT8726F  Super I/O chip w/LPC interface
               Sis950   A clone of the IT8705F

@@ -50,7 +51,7 @@

 #define DRVNAME "it87"

-enum chips { it87, it8712, it8716, it8718 };
+enum chips { it87, it8712, it8716, it8718, it8720 };

 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -112,6 +113,7 @@ superio_exit(void)
 #define IT8716F_DEVID 0x8716
 #define IT8718F_DEVID 0x8718
 #define IT8726F_DEVID 0x8726
+#define IT8720F_DEVID 0x8720
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60

@@ -278,7 +280,8 @@ static inline int has_16bit_fans(const s
        return (data->type = it87 && data->revision >= 0x03)
            || (data->type = it8712 && data->revision >= 0x08)
            || data->type = it8716
-           || data->type = it8718;
+           || data->type = it8718
+           || data->type = it8720;
 }

 static int it87_probe(struct platform_device *pdev);
@@ -982,6 +985,9 @@ static int __init it87_find(unsigned sho
        case IT8718F_DEVID:
                sio_data->type = it8718;
                break;
+       case IT8720F_DEVID:
+               sio_data->type = it8720;
+               break;
        case 0xffff:    /* No device at all */
                goto exit;
        default:
@@ -1040,6 +1046,7 @@ static int __devinit it87_probe(struct p
                "it8712",
                "it8716",
                "it8718",
+               "it8720",
        };

        res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -1190,7 +1197,7 @@ static int __devinit it87_probe(struct p
        }

        if (data->type = it8712 || data->type = it8716
-        || data->type = it8718) {
+        || data->type = it8718 || data->type = it8720) {
                data->vrm = vid_which_vrm();
                /* VID reading from Super-I/O config space if available */
                data->vid = sio_data->vid_value;
@@ -1571,7 +1578,7 @@ static void __exit sm_it87_exit(void)

 MODULE_AUTHOR("Chris Gauthron, "
              "Jean Delvare <khali@linux-fr.org>");
-MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8726F, SiS950 driver");
+MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8720F/8726F, SiS950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
 module_param(fix_pwm_polarity, bool, 0);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
