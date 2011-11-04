From: "Frank T. Lofaro Jr." <ftlofaro@yahoo.com>
Date: Fri, 04 Nov 2011 04:44:18 +0000
Subject: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE 8728
Message-Id: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8815903812512220665=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8815903812512220665==
Content-Type: multipart/alternative; boundary="-83809723-1680731830-1320381858=:22997"

---83809723-1680731830-1320381858=:22997
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

This patch allows the ITE 8728 chip to be detected and used.=0AThe chip app=
ears to be compatible with the 8721.=0A=0ASigned-off-by: Frank T. Lofaro Jr=
. <ftlofaro@yahoo.com>=0A---=0A=A0drivers/hwmon/it87.c |=A0=A0=A0 3 +++=0A=
=A01 files changed, 3 insertions(+), 0 deletions(-)=0A=0Adiff --git a/drive=
rs/hwmon/it87.c b/drivers/hwmon/it87.c=0Aindex d912649..0b21d18 100644=0A--=
- a/drivers/hwmon/it87.c=0A+++ b/drivers/hwmon/it87.c=0A@@ -17,6 +17,7 @@=
=0A=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8720F=A0 Super I/O chip w/LPC i=
nterface=0A=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8721F=A0 Super I/O chip=
 w/LPC interface=0A=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8726F=A0 Super =
I/O chip w/LPC interface=0A+ *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8728F=A0 =
Super I/O chip w/LPC interface=0A=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IT8=
758E=A0 Super I/O chip w/LPC interface=0A=A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Sis950=A0=A0 A clone of the IT8705F=0A=A0 *=0A@@ -135,6 +136,7 @@ st=
atic inline void superio_exit(void)=0A=A0#define IT8720F_DEVID 0x8720=0A=A0=
#define IT8721F_DEVID 0x8721=0A=A0#define IT8726F_DEVID 0x8726=0A+#define I=
T8728F_DEVID 0x8728=0A=A0#define IT87_ACT_REG=A0 0x30=0A=A0#define IT87_BAS=
E_REG 0x60=0A=A0=0A@@ -1603,6 +1605,7 @@ static int __init it87_find(unsign=
ed short *address,=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sio_data=
->type =3D it8720;=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=
=0A=A0=A0=A0=A0=A0=A0=A0 case IT8721F_DEVID:=0A+=A0=A0=A0=A0=A0=A0 case IT8=
728F_DEVID:=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sio_data->type =
=3D it8721;=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=A0=A0=
=A0=A0=A0=A0=A0 case 0xffff:=A0=A0=A0 /* No device at all */=0A-- =0A1.7.7.=
2
---83809723-1680731830-1320381858=:22997
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt">This patch allows the=
 ITE 8728 chip to be detected and used.<br>The chip appears to be compatibl=
e with the 8721.<br><br>Signed-off-by: Frank T. Lofaro Jr. &lt;ftlofaro@yah=
oo.com&gt;<br>---<br>&nbsp;drivers/hwmon/it87.c |&nbsp;&nbsp;&nbsp; 3 +++<b=
r>&nbsp;1 files changed, 3 insertions(+), 0 deletions(-)<br><br>diff --git =
a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c<br>index d912649..0b21d18 100=
644<br>--- a/drivers/hwmon/it87.c<br>+++ b/drivers/hwmon/it87.c<br>@@ -17,6=
 +17,7 @@<br>&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; IT8720F&nbsp; Super I/O chip w/LPC interface<br>&nbsp; *&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IT8721F&nbsp; =
Super I/O chip w/LPC interface<br>&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IT8726F&nbsp; Super I/O chip w/LPC
 interface<br>+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; IT8728F&nbsp; Super I/O chip w/LPC interface<br>&nbsp; *&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IT8758E&nbsp; Supe=
r I/O chip w/LPC interface<br>&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sis950&nbsp;&nbsp; A clone of the IT8705F<br>=
&nbsp; *<br>@@ -135,6 +136,7 @@ static inline void superio_exit(void)<br>&n=
bsp;#define IT8720F_DEVID 0x8720<br>&nbsp;#define IT8721F_DEVID 0x8721<br>&=
nbsp;#define IT8726F_DEVID 0x8726<br>+#define IT8728F_DEVID 0x8728<br>&nbsp=
;#define IT87_ACT_REG&nbsp; 0x30<br>&nbsp;#define IT87_BASE_REG 0x60<br>&nb=
sp;<br>@@ -1603,6 +1605,7 @@ static int __init it87_find(unsigned short *ad=
dress,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sio_data-&gt;type =3D
 it8720;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; case IT8721F_DEVID:<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IT8=
728F_DEVID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sio_data-&gt;type =3D it8721;<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0xffff:&nbsp=
;&nbsp;&nbsp; /* No device at all */<br>-- <br>1.7.7.2<br><br></div></body>=
</html>
---83809723-1680731830-1320381858=:22997--


--===============8815903812512220665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8815903812512220665==--
