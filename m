From: David Hubbard <david.c.hubbard@gmail.com>
Date: Thu, 13 Dec 2012 07:58:35 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <CAC-0Eqh6-2siZz_XcqE1SpoAXXtV=qkcP-q=GkBhJ9YNXdDNGA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5979094642423360767=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5979094642423360767==
Content-Type: multipart/alternative; boundary=f46d043c7c0833877404d0b748a9

--f46d043c7c0833877404d0b748a9
Content-Type: text/plain; charset=ISO-8859-1

Hi Jean,

On Wed, Dec 12, 2012 at 7:45 AM, Jean Delvare <khali@linux-fr.org> wrote:

> > >> +             * at all, not sure about the IT8728F or IT8603E
> > >> +             * (IT8603E - "hwmon_vid: Unknown VRM version of your
> x86 CPU"
> > >> +             * and cpu0_vid reads as 0)
> > >
> > > This has nothing to do with the IT8603E but only with your CPU. Which
> > > kernel version are you running, and can we see (one entry in)
> > > your /proc/cpuinfo?
> > $ cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 21
> > model           : 16
> > model name      : AMD A10-5800K APU with Radeon(tm) HD Graphics
> > stepping        : 1
> We do not support any VID decoding since family 10h CPUs for AMD:
>
>         {X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25},      /* NPT family 10h
> */
>
> Starting with family 11h CPUs, AMD has given up on parallel VID in
> favor of serial VID which uses only 2 pins. I know that the IT8720F has
> support for this, but I did not find any trace in other ITE datasheets.
>
> The serial VID uses 7-bit codes which are incompatible with the
> previous 6-bit parallel VID codes used by family 10h CPUs. BTW the
> family 10h CPUs already supported serial VID, and I have no idea how to
> support that properly as hwmon-vid has no idea whether the code came
> from the serial or parallel VID interface.
>
> The following should at least get rid of the warning in the kernel logs:
>
> * * * * *
>
> Since family 11h processors, AMD is exclusively using 7-bit VID codes
> transmitted using a serial protocol over two pins (clock and data.)
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/hwmon-vid.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --- linux-3.7-rc8.orig/drivers/hwmon/hwmon-vid.c        2012-10-20
> 21:11:32.000000000 +0200
> +++ linux-3.7-rc8/drivers/hwmon/hwmon-vid.c     2012-12-12
> 15:36:36.309882929 +0100
> @@ -115,6 +115,12 @@ int vid_from_reg(int val, u8 vrm)
>                 return (val < 32) ? 1550 - 25 * val
>                         : 775 - (25 * (val - 31)) / 2;
>
> +       case 26:                /* AMD family 10h to 15h, serial VID */
> +               val &= 0x7f;
> +               if (val >= 0x7c)
> +                       return 0;
> +               return DIV_ROUND_CLOSEST(15500 - 125 * val, 10);
> +
>         case 91:                /* VRM 9.1 */
>         case 90:                /* VRM 9.0 */
>                 val &= 0x1f;
> @@ -195,6 +201,10 @@ static struct vrm_model vrm_models[] = {
>         {X86_VENDOR_AMD, 0xF, 0x40, 0x7F, ANY, 24},     /* NPT family 0Fh
> */
>         {X86_VENDOR_AMD, 0xF, 0x80, ANY, ANY, 25},      /* future fam. 0Fh
> */
>         {X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25},      /* NPT family 10h
> */
> +       {X86_VENDOR_AMD, 0x11, 0x0, ANY, ANY, 26},      /* family 11h */
> +       {X86_VENDOR_AMD, 0x12, 0x0, ANY, ANY, 26},      /* family 12h */
> +       {X86_VENDOR_AMD, 0x14, 0x0, ANY, ANY, 26},      /* family 14h */
> +       {X86_VENDOR_AMD, 0x15, 0x0, ANY, ANY, 26},      /* family 15h */
>
>         {X86_VENDOR_INTEL, 0x6, 0x0, 0x6, ANY, 82},     /* Pentium Pro,
>                                                          * Pentium II,
> Xeon,
>
> Also available as a standalone driver at:
>   http://khali.linux-fr.org/devel/misc/hwmon-vid/
>
>
After applying the patch you sent cpu0_vid reads as 1550. Thanks much, that
was very helpful.

Hopefully here is an updated patch ready to add IT8603E support in the it87
driver. There is one question maybe still worth asking, namely: temp3_input
- should this be disabled because the chip only has 2 analog temperature
inputs?

Is the SST/PECI/AMDSTI/PCH SM-Link read using temp3_input? Otherwise I
assume it is outside the scope of the it87 driver?

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

--f46d043c7c0833877404d0b748a9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jean,<br><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">On We=
d, Dec 12, 2012 at 7:45 AM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">&gt; &gt;&gt; + =A0 =A0 =
=A0 =A0 =A0 =A0 * at all, not sure about the IT8728F or IT8603E<br><div cla=
ss=3D"im">
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 * (IT8603E - &quot;hwmon_vid: Unkno=
wn VRM version of your x86 CPU&quot;<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 * and cpu0_vid reads as 0)<br>
&gt; &gt;<br>
&gt; &gt; This has nothing to do with the IT8603E but only with your CPU. W=
hich<br>
&gt; &gt; kernel version are you running, and can we see (one entry in)<br>
&gt; &gt; your /proc/cpuinfo?<br>
&gt; $ cat /proc/cpuinfo<br>
&gt; processor =A0 =A0 =A0 : 0<br>
&gt; vendor_id =A0 =A0 =A0 : AuthenticAMD<br>
&gt; cpu family =A0 =A0 =A0: 21<br>
&gt; model =A0 =A0 =A0 =A0 =A0 : 16<br>
&gt; model name =A0 =A0 =A0: AMD A10-5800K APU with Radeon(tm) HD Graphics<=
br>
&gt; stepping =A0 =A0 =A0 =A0: 1<br></div>We do not support any VID decodin=
g since family 10h CPUs for AMD:<br>
<br>
=A0 =A0 =A0 =A0 {X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25}, =A0 =A0 =A0/* NP=
T family 10h */<br>
<br>
Starting with family 11h CPUs, AMD has given up on parallel VID in<br>
favor of serial VID which uses only 2 pins. I know that the IT8720F has<br>
support for this, but I did not find any trace in other ITE datasheets.<br>
<br>
The serial VID uses 7-bit codes which are incompatible with the<br>
previous 6-bit parallel VID codes used by family 10h CPUs. BTW the<br>
family 10h CPUs already supported serial VID, and I have no idea how to<br>
support that properly as hwmon-vid has no idea whether the code came<br>
from the serial or parallel VID interface.<br>
<br>
The following should at least get rid of the warning in the kernel logs:<br=
>
<br>
* * * * *<br>
<br>
Since family 11h processors, AMD is exclusively using 7-bit VID codes<br>
transmitted using a serial protocol over two pins (clock and data.)<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali=
@linux-fr.org</a>&gt;<br>
---<br>
=A0drivers/hwmon/hwmon-vid.c | =A0 10 ++++++++++<br>
=A01 file changed, 10 insertions(+)<br>
<br>
--- linux-3.7-rc8.orig/drivers/hwmon/hwmon-vid.c =A0 =A0 =A0 =A02012-10-20 =
21:11:32.000000000 +0200<br>
+++ linux-3.7-rc8/drivers/hwmon/hwmon-vid.c =A0 =A0 2012-12-12 15:36:36.309=
882929 +0100<br>
@@ -115,6 +115,12 @@ int vid_from_reg(int val, u8 vrm)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (val &lt; 32) ? 1550 - 25 * val<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : 775 - (25 * (val - 31)) /=
 2;<br>
<br>
+ =A0 =A0 =A0 case 26: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* AMD family 10h to =
15h, serial VID */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &amp;=3D 0x7f;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val &gt;=3D 0x7c)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return DIV_ROUND_CLOSEST(15500 - 125 * val, 1=
0);<br>
+<br>
=A0 =A0 =A0 =A0 case 91: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* VRM 9.1 */<br>
=A0 =A0 =A0 =A0 case 90: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* VRM 9.0 */<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &amp;=3D 0x1f;<br>
@@ -195,6 +201,10 @@ static struct vrm_model vrm_models[] =3D {<br>
=A0 =A0 =A0 =A0 {X86_VENDOR_AMD, 0xF, 0x40, 0x7F, ANY, 24}, =A0 =A0 /* NPT =
family 0Fh */<br>
=A0 =A0 =A0 =A0 {X86_VENDOR_AMD, 0xF, 0x80, ANY, ANY, 25}, =A0 =A0 =A0/* fu=
ture fam. 0Fh */<br>
=A0 =A0 =A0 =A0 {X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25}, =A0 =A0 =A0/* NP=
T family 10h */<br>
+ =A0 =A0 =A0 {X86_VENDOR_AMD, 0x11, 0x0, ANY, ANY, 26}, =A0 =A0 =A0/* fami=
ly 11h */<br>
+ =A0 =A0 =A0 {X86_VENDOR_AMD, 0x12, 0x0, ANY, ANY, 26}, =A0 =A0 =A0/* fami=
ly 12h */<br>
+ =A0 =A0 =A0 {X86_VENDOR_AMD, 0x14, 0x0, ANY, ANY, 26}, =A0 =A0 =A0/* fami=
ly 14h */<br>
+ =A0 =A0 =A0 {X86_VENDOR_AMD, 0x15, 0x0, ANY, ANY, 26}, =A0 =A0 =A0/* fami=
ly 15h */<br>
<br>
=A0 =A0 =A0 =A0 {X86_VENDOR_INTEL, 0x6, 0x0, 0x6, ANY, 82}, =A0 =A0 /* Pent=
ium Pro,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Pentium II, Xeon,<br>
<br>
Also available as a standalone driver at:<br>
=A0 <a href=3D"http://khali.linux-fr.org/devel/misc/hwmon-vid/" target=3D"_=
blank">http://khali.linux-fr.org/devel/misc/hwmon-vid/</a><br>
<span class=3D""><font color=3D"#888888"><br></font></span></blockquote><di=
v><br>After applying the patch you sent cpu0_vid reads as 1550. Thanks much=
, that was very helpful.<br><br>Hopefully here is an updated patch ready to=
 add IT8603E support in the it87 driver. There is one question maybe still =
worth asking, namely: temp3_input - should this be disabled because the chi=
p only has 2 analog temperature inputs?<br>
<br>Is the SST/PECI/AMDSTI/PCH SM-Link read using temp3_input? Otherwise I =
assume it is outside the scope of the it87 driver?<br><br>* * * * *<br><br>=
Add experimental support for the it8603e chip (Asus f2a85-m motherboard)<br=
>
Write only tested for pwmN and pwmN_enable.<br>Read tested, but the followi=
ng appear broken:<br>=A0 alarms<br>=A0 fanN_alarm<br>=A0 inN_alarm<br>=A0 i=
nN_max<br>=A0 inN_min<br>=A0 intrusionN_alarm<br>=A0 pwmN_auto_channels_tem=
p<br>=A0 pwmN_freq<br>
=A0 temp3_input (there is no 3rd analog temp input to the chip)<br><br>--- =
a/drivers/hwmon/it87.c=A0=A0=A0 2012-12-10 02:51:13.680000001 -0700<br>+++ =
b/drivers/hwmon/it87.c=A0=A0=A0 2012-12-13 08:42:54.195515406 -0700<br>@@ -=
21,10 +21,12 @@<br>
=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8758E=A0 Super I/O chip w/LPC inte=
rface<br>=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8782F=A0 Super I/O chip w=
/LPC interface<br>=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8783E/F Super I/=
O chip w/LPC interface<br>+ *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8603E=A0 S=
uper I/O chip w/LPC interface<br>
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
 =3D platform_get_resource(pdev, IORESOURCE_IO, 0);<br><br></div></div>
</div>

--f46d043c7c0833877404d0b748a9--


--===============5979094642423360767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5979094642423360767==--
