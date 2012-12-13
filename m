From: David Hubbard <david.c.hubbard@gmail.com>
Date: Thu, 13 Dec 2012 08:00:30 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <CAC-0Eqht_AjvR_uuQfojOMbH5KpVTLw77-D4xQ+jmThVW5QOng@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6597092495961757465=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6597092495961757465==
Content-Type: multipart/alternative; boundary=f46d043bdffa0a8e8604d0b74fd8

--f46d043bdffa0a8e8604d0b74fd8
Content-Type: text/plain; charset=ISO-8859-1

I'd like to send the same patch again but add signed-off-by this time :) I
apologize.

* * * * *

Add experimental support for the it8603e chip (Asus f2a85-m motherboard)
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
  temp3_input (there is no 3rd analog temp input to the chip)

Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>

--- a/drivers/hwmon/it87.c    2012-12-10 02:51:13.680000001 -0700
+++ b/drivers/hwmon/it87.c    2012-12-13 08:42:54.195515406 -0700
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
     return data->type == it8721
-        || data->type == it8728;
+        || data->type == it8728
+        || data->type == it8603;
 }

 static inline int has_newer_autopwm(const struct it87_data *data)
@@ -313,7 +317,8 @@
      * mapping and the manual duty cycle.
      */
     return data->type == it8721
-        || data->type == it8728;
+        || data->type == it8728
+        || data->type == it8603;
 }

 static int adc_lsb(const struct it87_data *data, int nr)
@@ -413,7 +418,8 @@
         || data->type == it8721
         || data->type == it8728
         || data->type == it8782
-        || data->type == it8783;
+        || data->type == it8783
+        || data->type == it8603;
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
+        chip_type, (chip_type == 0x8603) ? 'E' : 'F', *address,
sio_data->revision);

     /* in8 (Vbat) is always internal */
     sio_data->internal = (1 << 2);
@@ -1986,6 +1995,7 @@
         "it8728",
         "it8782",
         "it8783",
+        "it8603",
     };

     res = platform_get_resource(pdev, IORESOURCE_IO, 0);

--f46d043bdffa0a8e8604d0b74fd8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;d like to send the same patch again but add signed-off-by this time :=
) I apologize.<br><br>* * * * *<br><br>Add experimental support for the it8=
603e chip (Asus f2a85-m motherboard)<br>Write only tested for pwmN and pwmN=
_enable.<br>
Read tested, but the following appear broken:<br>=A0 alarms<br>=A0 fanN_ala=
rm<br>=A0 inN_alarm<br>=A0 inN_max<br>=A0 inN_min<br>=A0 intrusionN_alarm<b=
r>=A0 pwmN_auto_channels_temp<br>=A0 pwmN_freq<br>=A0 temp3_input (there is=
 no 3rd analog temp input to the chip)<br>
<br>Signed-off-by: David Hubbard &lt;<a href=3D"mailto:david.c.hubbard@gmai=
l.com">david.c.hubbard@gmail.com</a>&gt;<br><br>--- a/drivers/hwmon/it87.c=
=A0=A0=A0 2012-12-10 02:51:13.680000001 -0700<br>+++ b/drivers/hwmon/it87.c=
=A0=A0=A0 2012-12-13 08:42:54.195515406 -0700<br>
@@ -21,10 +21,12 @@<br>=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8758E=A0 Su=
per I/O chip w/LPC interface<br>=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT87=
82F=A0 Super I/O chip w/LPC interface<br>=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 IT8783E/F Super I/O chip w/LPC interface<br>+ *=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 IT8603E=A0 Super I/O chip w/LPC interface<br>
=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Sis950=A0=A0 A clone of the IT8705F<=
br>=A0 *<br>=A0 *=A0 Copyright (C) 2001 Chris Gauthron<br>=A0 *=A0 Copyrigh=
t (C) 2005-2010 Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khal=
i@linux-fr.org</a>&gt;<br>+ *=A0 Copyright (C) 2012 David Hubbard &lt;<a hr=
ef=3D"mailto:david.c.hubbard@gmail.com">david.c.hubbard@gmail.com</a>&gt;<b=
r>
=A0 *<br>=A0 *=A0 This program is free software; you can redistribute it an=
d/or modify<br>=A0 *=A0 it under the terms of the GNU General Public Licens=
e as published by<br>@@ -62,7 +64,7 @@<br>=A0#define DRVNAME &quot;it87&quo=
t;<br>=A0<br>
=A0enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it878=
2,<br>-=A0=A0=A0 =A0=A0=A0=A0 it8783 };<br>+=A0=A0=A0 =A0=A0=A0=A0 it8783, =
it8603 };<br>=A0<br>=A0static unsigned short force_id;<br>=A0module_param(f=
orce_id, ushort, 0);<br>@@ -142,6 +144,7 @@<br>
=A0#define IT8728F_DEVID 0x8728<br>=A0#define IT8782F_DEVID 0x8782<br>=A0#d=
efine IT8783E_DEVID 0x8783<br>+#define IT8603E_DEVID 0x8603<br>=A0#define I=
T87_ACT_REG=A0 0x30<br>=A0#define IT87_BASE_REG 0x60<br>=A0<br>@@ -303,7 +3=
06,8 @@<br>
=A0=A0=A0=A0 =A0* on selected inputs.<br>=A0=A0=A0=A0 =A0*/<br>=A0=A0=A0=A0=
 return data-&gt;type =3D=3D it8721<br>-=A0=A0=A0 =A0=A0=A0 || data-&gt;typ=
e =3D=3D it8728;<br>+=A0=A0=A0 =A0=A0=A0 || data-&gt;type =3D=3D it8728<br>=
+=A0=A0=A0 =A0=A0=A0 || data-&gt;type =3D=3D it8603;<br>=A0}<br>=A0<br>=A0s=
tatic inline int has_newer_autopwm(const struct it87_data *data)<br>
@@ -313,7 +317,8 @@<br>=A0=A0=A0=A0 =A0* mapping and the manual duty cycle.=
<br>=A0=A0=A0=A0 =A0*/<br>=A0=A0=A0=A0 return data-&gt;type =3D=3D it8721<b=
r>-=A0=A0=A0 =A0=A0=A0 || data-&gt;type =3D=3D it8728;<br>+=A0=A0=A0 =A0=A0=
=A0 || data-&gt;type =3D=3D it8728<br>+=A0=A0=A0 =A0=A0=A0 || data-&gt;type=
 =3D=3D it8603;<br>
=A0}<br>=A0<br>=A0static int adc_lsb(const struct it87_data *data, int nr)<=
br>@@ -413,7 +418,8 @@<br>=A0=A0=A0=A0 =A0=A0=A0 || data-&gt;type =3D=3D it=
8721<br>=A0=A0=A0=A0 =A0=A0=A0 || data-&gt;type =3D=3D it8728<br>=A0=A0=A0=
=A0 =A0=A0=A0 || data-&gt;type =3D=3D it8782<br>-=A0=A0=A0 =A0=A0=A0 || dat=
a-&gt;type =3D=3D it8783;<br>
+=A0=A0=A0 =A0=A0=A0 || data-&gt;type =3D=3D it8783<br>+=A0=A0=A0 =A0=A0=A0=
 || data-&gt;type =3D=3D it8603;<br>=A0}<br>=A0<br>=A0static inline int has=
_old_autopwm(const struct it87_data *data)<br>@@ -1707,6 +1713,9 @@<br>=A0=
=A0=A0=A0 case IT8783E_DEVID:<br>=A0=A0=A0=A0 =A0=A0=A0 sio_data-&gt;type =
=3D it8783;<br>
=A0=A0=A0=A0 =A0=A0=A0 break;<br>+=A0=A0=A0 case IT8603E_DEVID:<br>+=A0=A0=
=A0 =A0=A0=A0 sio_data-&gt;type =3D it8603;<br>+=A0=A0=A0 =A0=A0=A0 break;<=
br>=A0=A0=A0=A0 case 0xffff:=A0=A0=A0 /* No device at all */<br>=A0=A0=A0=
=A0 =A0=A0=A0 goto exit;<br>=A0=A0=A0=A0 default:<br>@@ -1728,8 +1737,8 @@<=
br>=A0<br>
=A0=A0=A0=A0 err =3D 0;<br>=A0=A0=A0=A0 sio_data-&gt;revision =3D superio_i=
nb(DEVREV) &amp; 0x0f;<br>-=A0=A0=A0 pr_info(&quot;Found IT%04xF chip at 0x=
%x, revision %d\n&quot;,<br>-=A0=A0=A0 =A0=A0=A0 chip_type, *address, sio_d=
ata-&gt;revision);<br>+=A0=A0=A0 pr_info(&quot;Found IT%04x%c chip at 0x%x,=
 revision %d\n&quot;,<br>
+=A0=A0=A0 =A0=A0=A0 chip_type, (chip_type =3D=3D 0x8603) ? &#39;E&#39; : &=
#39;F&#39;, *address, sio_data-&gt;revision);<br>=A0<br>=A0=A0=A0=A0 /* in8=
 (Vbat) is always internal */<br>=A0=A0=A0=A0 sio_data-&gt;internal =3D (1 =
&lt;&lt; 2);<br>@@ -1986,6 +1995,7 @@<br>
=A0=A0=A0=A0 =A0=A0=A0 &quot;it8728&quot;,<br>=A0=A0=A0=A0 =A0=A0=A0 &quot;=
it8782&quot;,<br>=A0=A0=A0=A0 =A0=A0=A0 &quot;it8783&quot;,<br>+=A0=A0=A0 =
=A0=A0=A0 &quot;it8603&quot;,<br>=A0=A0=A0=A0 };<br>=A0<br>=A0=A0=A0=A0 res=
 =3D platform_get_resource(pdev, IORESOURCE_IO, 0);<br><br>

--f46d043bdffa0a8e8604d0b74fd8--


--===============6597092495961757465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6597092495961757465==--
