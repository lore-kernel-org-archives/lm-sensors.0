From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Tue, 19 Feb 2008 07:51:59 +0000
Subject: Re: [lm-sensors] Preparing patches for pca9552, ad5259, and bq27350
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C0113DCFF@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C872CC.4EA48B70"
List-Id: <lm-sensors.vger.kernel.org>
References: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
In-Reply-To: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============0127598026573823253==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C872CC.4EA48B70"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C872CC.4EA48B70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

There are several monitoring chips that monitor the CMOS battery =
voltage.  That's similar...

Phil P.

--=20
Philip Pokorny, RHCE
Director of Field Engineering=20
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Jean Delvare [mailto:khali@linux-fr.org]
Sent:	Monday, February 18, 2008 01:43 PM Pacific Standard Time
To:	Matthew Bosworth
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] Preparing patches for pca9552, ad5259, and =
bq27350

Hi Matthew,

On Mon, 18 Feb 2008 13:26:10 -0800, Matthew Bosworth wrote:
>    The BQ27350 is a battery monitor for Li-ion batteries, does that =20
> count?  I'll send mail to the i2c list about the other two.

Does it implement any part of the standard hwmon interface? If not,
then it can't be considered a hwmon driver. FWIW, we do not have any
battery monitor driver in drivers/hwmon yet, and I am under the
impression that your driver would rather belong to drivers/power.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

------_=_NextPart_001_01C872CC.4EA48B70
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>Re: [lm-sensors] Preparing patches for pca9552, ad5259, and =
bq27350</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>There are several monitoring chips that monitor the =
CMOS battery voltage.&nbsp; That's similar...<BR>
<BR>
Phil P.<BR>
<BR>
--<BR>
Philip Pokorny, RHCE<BR>
Director of Field Engineering<BR>
Penguin Computing&nbsp; <A =
HREF=3D"http://www.penguincomputing.com">http://www.penguincomputing.com<=
/A><BR>
<BR>
&nbsp;-----Original Message-----<BR>
From: &nbsp; Jean Delvare [<A =
HREF=3D"mailto:khali@linux-fr.org">mailto:khali@linux-fr.org</A>]<BR>
Sent:&nbsp;&nbsp; Monday, February 18, 2008 01:43 PM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; Matthew Bosworth<BR>
Cc:&nbsp;&nbsp;&nbsp;&nbsp; lm-sensors@lm-sensors.org<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Re: [lm-sensors] =
Preparing patches for pca9552, ad5259, and bq27350<BR>
<BR>
Hi Matthew,<BR>
<BR>
On Mon, 18 Feb 2008 13:26:10 -0800, Matthew Bosworth wrote:<BR>
&gt;&nbsp;&nbsp;&nbsp; The BQ27350 is a battery monitor for Li-ion =
batteries, does that&nbsp;<BR>
&gt; count?&nbsp; I'll send mail to the i2c list about the other =
two.<BR>
<BR>
Does it implement any part of the standard hwmon interface? If not,<BR>
then it can't be considered a hwmon driver. FWIW, we do not have any<BR>
battery monitor driver in drivers/hwmon yet, and I am under the<BR>
impression that your driver would rather belong to drivers/power.<BR>
<BR>
--<BR>
Jean Delvare<BR>
<BR>
_______________________________________________<BR>
lm-sensors mailing list<BR>
lm-sensors@lm-sensors.org<BR>
<A =
HREF=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://l=
ists.lm-sensors.org/mailman/listinfo/lm-sensors</A><BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C872CC.4EA48B70--


--===============0127598026573823253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0127598026573823253==--
