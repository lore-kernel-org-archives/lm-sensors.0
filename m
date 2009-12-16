From: "Ray Copeland" <ray.copeland@aprius.com>
Date: Wed, 16 Dec 2009 17:58:32 +0000
Subject: [lm-sensors] [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30
Message-Id: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31A@EXVBE012-13.exch012.intermedia.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA7E79.618D6995"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============6518689384888039629==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA7E79.618D6995"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA7E79.618D6995
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

--- adt7462.c	2009-12-15 15:57:47.000000000 -0800
+++ adt7462.c.orig	2009-12-15 15:51:05.000000000 -0800
@@ -97,7 +97,6 @@
 #define		ADT7462_PIN24_SHIFT		6
 #define		ADT7462_PIN26_VOLT_INPUT	0x08
 #define		ADT7462_PIN25_VOLT_INPUT	0x20
-#define		ADT7462_PIN29_SHIFT		4	/* cfg3 */
 #define		ADT7462_PIN28_SHIFT		6	/* cfg3 */
 #define		ADT7462_PIN28_VOLT		0x5
=20
@@ -183,7 +182,7 @@
  *
  * Some, but not all, of these voltages have low/high limits.
  */
-#define ADT7462_VOLT_COUNT	13
+#define ADT7462_VOLT_COUNT	12
=20
 #define ADT7462_VENDOR		0x41
 #define ADT7462_DEVICE		0x62
@@ -325,13 +324,13 @@
 	case 10:
 		return 0x6A;
 	case 11:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 0x50;
 		break;
 	case 12:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 0x4C;
@@ -384,13 +383,13 @@
 	case 10:
 		return 0x73;
 	case 11:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 0x76;
 		break;
 	case 12:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 0x77;
@@ -443,13 +442,13 @@
 	case 10:
 		return 0x91;
 	case 11:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 0x94;
 		break;
 	case 12:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 0x95;
@@ -535,13 +534,13 @@
 			return "+1.5";
 		}
 	case 11:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return "+1.5V ICH";
 		break;
 	case 12:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return "+1.5V 3GPIO";
@@ -630,7 +629,7 @@
 		}
 	case 11:
 	case 12:
-		if (data->pin_cfg[3] >> ADT7462_PIN29_SHIFT =3D=3D
+		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT =3D=3D
 					ADT7462_PIN28_VOLT &&
 		    !(data->pin_cfg[0] & ADT7462_VID_INPUT))
 			return 7800;




------_=_NextPart_001_01CA7E79.618D6995
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
--- adt7462.c&nbsp;&nbsp; 2009-12-15 15:57:47.000000000 -0800<BR>
+++ adt7462.c.orig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009-12-15 =
15:51:05.000000000 -0800<BR>
@@ -97,7 +97,6 @@<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ADT7462_PIN24_SHIFT&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ADT7462_PIN26_VOLT_INPUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x08<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ADT7462_PIN25_VOLT_INPUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x20<BR>
-#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ADT7462_PIN29_SHIFT&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cfg3 */<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ADT7462_PIN28_SHIFT&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cfg3 */<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ADT7462_PIN28_VOLT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5<BR>
<BR>
@@ -183,7 +182,7 @@<BR>
&nbsp; *<BR>
&nbsp; * Some, but not all, of these voltages have low/high limits.<BR>
&nbsp; */<BR>
-#define ADT7462_VOLT_COUNT&nbsp;&nbsp;&nbsp;&nbsp; 13<BR>
+#define ADT7462_VOLT_COUNT&nbsp;&nbsp;&nbsp;&nbsp; 12<BR>
<BR>
&nbsp;#define ADT7462_VENDOR &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x41<BR>
&nbsp;#define ADT7462_DEVICE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x62<BR>
@@ -325,13 +324,13 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 10:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x6A;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 11:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x50;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 12:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x4C;<BR>
@@ -384,13 +383,13 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 10:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x73;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 11:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x76;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 12:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x77;<BR>
@@ -443,13 +442,13 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 10:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x91;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 11:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x94;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 12:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0x95;<BR>
@@ -535,13 +534,13 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;+1.5&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 11:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;+1.5V =
ICH&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 12:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;+1.5V =
3GPIO&quot;;<BR>
@@ -630,7 +629,7 @@<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 11:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 12:<BR>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN29_SHIFT =3D=3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;pin_cfg[3] =
&gt;&gt; ADT7462_PIN28_SHIFT =3D=3D<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADT7462_PIN28_VOLT =
&amp;&amp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 7800;<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA7E79.618D6995--


--===============6518689384888039629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6518689384888039629==--
