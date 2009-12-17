From: "Ray Copeland" <ray.copeland@aprius.com>
Date: Thu, 17 Dec 2009 01:26:19 +0000
Subject: [lm-sensors] [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30
Message-Id: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA328@EXVBE012-13.exch012.intermedia.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA7EB8.4B916955"
List-Id: <lm-sensors.vger.kernel.org>
References: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31A@EXVBE012-13.exch012.intermedia.net>
In-Reply-To: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31A@EXVBE012-13.exch012.intermedia.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============2473336370049281732==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA7EB8.4B916955"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA7EB8.4B916955
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Ray Copeland <ray.copeland@aprius.com>
Date: Wed, 16 Dec 2009
Subject: [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30 adt7462 =
hwmon driver=20

Description:

The #define ADT7462_VOLT_COUNT is wrong, it should be 13 not 12. All the =

for loops that use this as a limit count are of the typical form, "for=20
(n =3D 0; n < ADT7462_VOLT_COUNT; n++)", so to loop through all voltages =

w/o missing the last one it is necessary for the count to be one greater =

than it is.  (Specifically, you will miss the +1.5V 3GPIO input with =
count=20
=3D 12 vs. 13.)

Signed-off-by: Ray Copeland <ray.copeland@aprius.com>

Diff with changes vs. original adt7462.c 2.6.30 version:

--- adt7462.c.orig      2009-12-15 15:51:05.000000000 -0800
+++ adt7462.c.volt_count        2009-12-16 14:06:01.000000000 -0800
@@ -182,7 +182,7 @@
  *
  * Some, but not all, of these voltages have low/high limits.
  */
-#define ADT7462_VOLT_COUNT     12
+#define ADT7462_VOLT_COUNT     13

 #define ADT7462_VENDOR         0x41
 #define ADT7462_DEVICE         0x62

------_=_NextPart_001_01CA7EB8.4B916955
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>[PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30 adt7462 =
hwmon driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: Ray Copeland &lt;ray.copeland@aprius.com&gt;<BR>
Date: Wed, 16 Dec 2009<BR>
Subject: [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30 adt7462 =
hwmon driver<BR>
<BR>
Description:<BR>
<BR>
The #define ADT7462_VOLT_COUNT is wrong, it should be 13 not 12. All =
the<BR>
for loops that use this as a limit count are of the typical form, =
&quot;for<BR>
(n =3D 0; n &lt; ADT7462_VOLT_COUNT; n++)&quot;, so to loop through all =
voltages<BR>
w/o missing the last one it is necessary for the count to be one =
greater<BR>
than it is.&nbsp; (Specifically, you will miss the +1.5V 3GPIO input =
with count<BR>
=3D 12 vs. 13.)<BR>
<BR>
Signed-off-by: Ray Copeland &lt;ray.copeland@aprius.com&gt;<BR>
<BR>
Diff with changes vs. original adt7462.c 2.6.30 version:<BR>
<BR>
--- adt7462.c.orig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009-12-15 =
15:51:05.000000000 -0800<BR>
+++ adt7462.c.volt_count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2009-12-16 14:06:01.000000000 -0800<BR>
@@ -182,7 +182,7 @@<BR>
&nbsp; *<BR>
&nbsp; * Some, but not all, of these voltages have low/high limits.<BR>
&nbsp; */<BR>
-#define ADT7462_VOLT_COUNT&nbsp;&nbsp;&nbsp;&nbsp; 12<BR>
+#define ADT7462_VOLT_COUNT&nbsp;&nbsp;&nbsp;&nbsp; 13<BR>
<BR>
&nbsp;#define =
ADT7462_VENDOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x41<BR>
&nbsp;#define =
ADT7462_DEVICE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x62<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA7EB8.4B916955--


--===============2473336370049281732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2473336370049281732==--
