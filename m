From: "Chris Verges" <chrisv@cyberswitching.com>
Date: Thu, 02 Jul 2009 14:15:24 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <68FBE0F3CE97264395875AC1C468F22C1164A6@mail03.cyberswitching.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9FB20.24AD6FEE"
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============8076419275756138335==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9FB20.24AD6FEE"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9FB20.24AD6FEE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> All in all, I don't really care where the drivers go, as long as it's
> not in drivers/hwmon. So the choice is probably better left to the
> authors of the accelerometer drivers. Once one driver is moved, the
> rest will have to follow.

To quote my favorite bartender, "You don't have to go home, but you
can't stay here."

I guess until the IIO framework gets fully integrated (saw the patches
that were just submitted, great job Jonathan!) I'll put the adxl345
driver into "misc."  A new patch should be sent out within 2 days.
Until then, if anyone has feedback on the meat of the code, please
send it so I can integrate both changes into the same patch.

Jonathan, Jean, and Eric -- thanks for the feedback!

Chris

------_=_NextPart_001_01C9FB20.24AD6FEE
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

<P><FONT SIZE=3D2>&gt; All in all, I don't really care where the drivers =
go, as long as it's<BR>
&gt; not in drivers/hwmon. So the choice is probably better left to =
the<BR>
&gt; authors of the accelerometer drivers. Once one driver is moved, =
the<BR>
&gt; rest will have to follow.<BR>
<BR>
To quote my favorite bartender, &quot;You don't have to go home, but =
you<BR>
can't stay here.&quot;<BR>
<BR>
I guess until the IIO framework gets fully integrated (saw the =
patches<BR>
that were just submitted, great job Jonathan!) I'll put the adxl345<BR>
driver into &quot;misc.&quot;&nbsp; A new patch should be sent out =
within 2 days.<BR>
Until then, if anyone has feedback on the meat of the code, please<BR>
send it so I can integrate both changes into the same patch.<BR>
<BR>
Jonathan, Jean, and Eric -- thanks for the feedback!<BR>
<BR>
Chris</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9FB20.24AD6FEE--


--===============8076419275756138335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8076419275756138335==--
