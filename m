From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Fri, 03 Oct 2008 13:23:08 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <79c9d4530810030623n73e77945s64ef9ec43b2e18dc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

thanks all for all your detailed answers. Very useful. I got it
regarding the voltage.

Here is the patch I did for it87c. As you said, I simply searched for
IT8718 and add IT8720 to do the same.

I looked into my BIOS and here is what I have:
vCore = 1,33
3,3 = 3,4
5 = 5,02
12 = 12,09

Since I have identified the chipset from my mother board, can you let
me know wich pin are the "in" so I can mesure the resistors and
provide the values? You might found that (the pin#) in the datasheet I
hope.

Regarding pwm4 and pwm5, I'm not really sure how to do so, and I seen
that some fans info was missing. So I will try to figure how to use it
since I have 3 fans and only 2 are displayed.

fan1:       3013 RPM  (min =    0 RPM, div = 2)
fan2:          0 RPM  (min =    0 RPM, div = 2)
fan3:       5973 RPM  (min =    0 RPM, div = 2)

Last point, temperatures are slightly different from it8720 and k8temp.

temp1:       +41.0 °C  (low  =  -1.0 °C, high = +127.0 °C)  sensor = transistor
temp2:       +34.0 °C  (low  =  -1.0 °C, high =  -3.0 °C)  sensor = transistor
temp3:       +22.0 °C  (low  =  -5.0 °C, high = +127.0 °C)  sensor = transistor

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +43.0 °C
Core1 Temp:  +37.0 °C

Has it87 only the motherboard temp? In that case, why there is 3? I
will receive a 4-core this afternoon so I will be able to do some
other tests.

I will keep you posted if I'm able to do something for pwm4 and pwm5.

Regard,

Jean-Marc


--- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02
09:04:44.000000000 -0400
+++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-03
09:01:10.000000000 -0400
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
@@ -111,6 +112,7 @@ superio_exit(void)
 #define IT8705F_DEVID 0x8705
 #define IT8716F_DEVID 0x8716
 #define IT8718F_DEVID 0x8718
+#define IT8720F_DEVID 0x8720
 #define IT8726F_DEVID 0x8726
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
@@ -979,6 +982,9 @@ static int __init it87_find(unsigned sho
        case IT8726F_DEVID:
                sio_data->type = it8716;
                break;
+       case IT8720F_DEVID:
+               sio_data->type = it8720;
+               break;
        case IT8718F_DEVID:
                sio_data->type = it8718;
                break;
@@ -1012,7 +1018,7 @@ static int __init it87_find(unsigned sho
                int reg;

                superio_select(GPIO);
-               if (chip_type = it8718)
+               if (chip_type = it8718 || chip_type = it8720)
                        sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);

                reg = superio_inb(IT87_SIO_PINX2_REG);
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
