From: David Hubbard <david.c.hubbard@gmail.com>
Date: Thu, 29 Nov 2012 10:09:01 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <CAC-0EqiRSZ=oBwieEFy61uAwVePgXV3=biCQQpnGUQtzxVbuAg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Guenter,

>> Rudolf and I are collaborating on a new Asus board for coreboot.org,
>> the F2A85-M, which has a new ITE chip, the it8603e. sensors-detect
>> says:
>>
> good luck with that ... I don't find any information about the chip except for
> Rudolf's e-mail on the coreboot mailing list. I suspect it may be one of those
> special vendor specific ITE chips like the IT877x, for which no documentation is
> available at all (though someone in the coreboot project seems to have access
> to the datasheet for IT8772F).
>
> Guenter

I'm sure I can figure it out. For example:

This adds experimental support for the it8603e chip found in the asus
f2a85-m motherboard.
Write only tested for pwmN and pwmN_enable.
Read tested, but the following appear broken:
  alarms
  fanN_alarm
  inN_alarm
  inN_max
  inN_min
  intrusionN_alarm
  pwmN_auto_channels_temp
  pwmN_freq

--- drivers/hwmon/it87.c    2012-11-28 21:50:32.218599922 -0700
+++ drivers/hwmon/it87.c    2012-11-29 10:55:31.576117770 -0700
@@ -21,10 +21,12 @@
  *            IT8758E  Super I/O chip w/LPC interface
  *            IT8782F  Super I/O chip w/LPC interface
  *            IT8783E/F Super I/O chip w/LPC interface
+ *            IT8603E  Super I/O chip w/LPC interface
  *            Sis950   A clone of the IT8705F
  *
  *  Copyright (C) 2001 Chris Gauthron
  *  Copyright (C) 2005-2010 Jean Delvare <khali@linux-fr.org>
+ *  Copyright (C) 2012 David Hubbard <david.c.hubbard@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -62,7 +64,7 @@
 #define DRVNAME "it87"

 enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8782,
-         it8783 };
+         it8783, it8603 };

 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -142,6 +144,7 @@
 #define IT8728F_DEVID 0x8728
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
+#define IT8603E_DEVID 0x8603
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60

@@ -303,7 +306,8 @@
      * on selected inputs.
      */
     return data->type = it8721
-        || data->type = it8728;
+        || data->type = it8728
+        || data->type = it8603;
 }

 static inline int has_newer_autopwm(const struct it87_data *data)
@@ -313,7 +317,8 @@
      * mapping and the manual duty cycle.
      */
     return data->type = it8721
-        || data->type = it8728;
+        || data->type = it8728
+        || data->type = it8603;
 }

 static int adc_lsb(const struct it87_data *data, int nr)
@@ -413,7 +418,8 @@
         || data->type = it8721
         || data->type = it8728
         || data->type = it8782
-        || data->type = it8783;
+        || data->type = it8783
+        || data->type = it8603;
 }

 static inline int has_old_autopwm(const struct it87_data *data)
@@ -1707,6 +1713,9 @@
     case IT8783E_DEVID:
         sio_data->type = it8783;
         break;
+    case IT8603E_DEVID:
+        sio_data->type = it8603;
+        break;
     case 0xffff:    /* No device at all */
         goto exit;
     default:
@@ -1728,8 +1737,8 @@

     err = 0;
     sio_data->revision = superio_inb(DEVREV) & 0x0f;
-    pr_info("Found IT%04xF chip at 0x%x, revision %d\n",
-        chip_type, *address, sio_data->revision);
+    pr_info("Found IT%04x%c chip at 0x%x, revision %d\n",
+        chip_type, (chip_type = 0x8603) ? 'E' : 'F', *address,
sio_data->revision);

     /* in8 (Vbat) is always internal */
     sio_data->internal = (1 << 2);
@@ -1818,10 +1827,12 @@

         reg = superio_inb(IT87_SIO_GPIO3_REG);
         if (sio_data->type = it8721 || sio_data->type = it8728 ||
-            sio_data->type = it8782) {
+            sio_data->type = it8782 || sio_data->type = it8603) {
             /*
              * IT8721F/IT8758E, and IT8782F don't have VID pins
-             * at all, not sure about the IT8728F.
+             * at all, not sure about the IT8728F or IT8603E
+             * (IT8603E - "hwmon_vid: Unknown VRM version of your x86 CPU"
+             * and cpu0_vid reads as 0)
              */
             sio_data->skip_vid = 1;
         } else {
@@ -1986,6 +1997,7 @@
         "it8728",
         "it8782",
         "it8783",
+        "it8603",
     };

     res = platform_get_resource(pdev, IORESOURCE_IO, 0);

Regards,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
