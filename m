From: "Ray Copeland" <ray.copeland@aprius.com>
Date: Wed, 16 Dec 2009 18:08:51 +0000
Subject: [lm-sensors] [PATCH 2/2] Need ADT7462_PIN29_SHIFT for pin_cfg[3]
Message-Id: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31C@EXVBE012-13.exch012.intermedia.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA7E7A.D2802CD5"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============3722002780083799882==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA7E7A.D2802CD5"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA7E7A.D2802CD5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Ray Copeland <ray.copeland@aprius.com>
Date: Wed, 16 Dec 2009
Subject: [PATCH 2/2] Need ADT7462_PIN29_SHIFT for pin_cfg[3] =
linux-2.6.30 adt7462 hwmon driver

Description:

The driver uses the following expression (parentheses added for clarity) =

to test if the +1.5V ICH/3GPIO voltages are configured:

if (((data->pin_cfg[3] >> ADT7462_PIN28_SHIFT) =3D=3D =
ADT7462_PIN28_VOLT) &&
!(data->pin_cfg[0] & ADT7462_VID_INPUT))

With "#define ADT7462_PIN28_SHIFT 6" this will never equate to "#define
ADT7462_PIN28_VOLT 5" because that shifts in only the PIN28 +1.5V ICH =
value=20
and misses the PIN29 +1.5V 3GPIO value.  It is the combination of both =
these=20
values that equates to 5 if the voltages are configured.=20

Note the logic is essentially correct in that both these voltages must
be configured together, meaning you can't set one to +1.5V and have the=20
other be something else.  Also, I think the logic just got a little =
confused=20
thinking that pin 28 comes first (bit-position wise) in the pin_cfg[3], =
but=20
actually the order of bits from ms to ls is pin28/29 not pin 29/28.

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




------_=_NextPart_001_01CA7E7A.D2802CD5
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
<TITLE>[PATCH 2/2] Need ADT7462_PIN29_SHIFT for pin_cfg[3] linux-2.6.30 =
adt7462 hwmon driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: Ray Copeland &lt;ray.copeland@aprius.com&gt;<BR>
Date: Wed, 16 Dec 2009<BR>
Subject: [PATCH 2/2] Need ADT7462_PIN29_SHIFT for pin_cfg[3] =
linux-2.6.30 adt7462 hwmon driver<BR>
<BR>
Description:<BR>
<BR>
The driver uses the following expression (parentheses added for =
clarity)<BR>
to test if the +1.5V ICH/3GPIO voltages are configured:<BR>
<BR>
if (((data-&gt;pin_cfg[3] &gt;&gt; ADT7462_PIN28_SHIFT) =3D=3D =
ADT7462_PIN28_VOLT) &amp;&amp;<BR>
!(data-&gt;pin_cfg[0] &amp; ADT7462_VID_INPUT))<BR>
<BR>
With &quot;#define ADT7462_PIN28_SHIFT 6&quot; this will never equate to =
&quot;#define<BR>
ADT7462_PIN28_VOLT 5&quot; because that shifts in only the PIN28 +1.5V =
ICH value<BR>
and misses the PIN29 +1.5V 3GPIO value.&nbsp; It is the combination of =
both these<BR>
values that equates to 5 if the voltages are configured.<BR>
<BR>
Note the logic is essentially correct in that both these voltages =
must<BR>
be configured together, meaning you can't set one to +1.5V and have =
the<BR>
other be something else.&nbsp; Also, I think the logic just got a little =
confused<BR>
thinking that pin 28 comes first (bit-position wise) in the pin_cfg[3], =
but<BR>
actually the order of bits from ms to ls is pin28/29 not pin 29/28.<BR>
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
------_=_NextPart_001_01CA7E7A.D2802CD5--


--===============3722002780083799882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3722002780083799882==--
