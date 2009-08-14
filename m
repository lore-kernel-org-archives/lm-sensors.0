From: "Chris Verges" <chrisv@cyberswitching.com>
Date: Fri, 14 Aug 2009 13:48:21 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <68FBE0F3CE97264395875AC1C468F22C11656C@mail03.cyberswitching.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA1CE6.5D3F0DFD"
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============5802219759496659132==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA1CE6.5D3F0DFD"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1CE6.5D3F0DFD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> *snip*

Just so there's no confusion, Analog Devices has a version of the driver =
that works with both the ADXL345 and ADXL346 chip.  I highly recommend =
people switch over to that rather than use the patch that started this =
thread.

Turn this into a one-line URL:

   http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/
       ?action=3Dbrowse&path=3D/trunk/drivers/input/misc/adxl34x.c

Chris

------_=_NextPart_001_01CA1CE6.5D3F0DFD
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: [PATCH] adxl345 accelerometer hwmon driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt; *snip*<BR>
<BR>
Just so there's no confusion, Analog Devices has a version of the driver =
that works with both the ADXL345 and ADXL346 chip.&nbsp; I highly =
recommend people switch over to that rather than use the patch that =
started this thread.<BR>
<BR>
Turn this into a one-line URL:<BR>
<BR>
&nbsp;&nbsp; <A =
HREF=3D"http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/">http=
://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/</A><BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
?action=3Dbrowse&amp;path=3D/trunk/drivers/input/misc/adxl34x.c<BR>
<BR>
Chris</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA1CE6.5D3F0DFD--


--===============5802219759496659132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5802219759496659132==--
