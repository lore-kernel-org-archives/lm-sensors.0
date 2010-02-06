From: "Chris Verges" <chrisv@cyberswitching.com>
Date: Sat, 06 Feb 2010 16:58:14 +0000
Subject: Re: [lm-sensors] [PATCH] linux-2.6.32-directemp
Message-Id: <68FBE0F3CE97264395875AC1C468F22C2445C2@mail03.cyberswitching.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CAA74E.23E193DF"
List-Id: <lm-sensors.vger.kernel.org>
References: <20100206104251.1be31941@neptune.home>
In-Reply-To: <20100206104251.1be31941@neptune.home>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============5396807421418501557==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAA74E.23E193DF"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAA74E.23E193DF
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Wouldn't it make sense to make use of hardware monitoring interfaces =
so
> lm_sensors could handle the sensor information? (added to CC)
>
> This would also be a good reason to have the driver on kernel side
> rather than somewhere in userspace.

Hi Bruno,

I agree.  However, I've had other drivers in the past been pooh-pooh'd =
by the lm-sensors maintainers because they don't seem to fit exactly =
what the lm-sensors folks want in a driver.  Unfortunately, I  seem to =
be bad at understanding the purpose of lm-sensors.  :-)  I'd like to get =
their approval before any work is done to migrate over to lm-sensors.

Thanks,
Chris

P.S.  Sorry for any odd formatting with these e-mails.  I'm stuck in =
Exchange hell.

------_=_NextPart_001_01CAA74E.23E193DF
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
<TITLE>RE: [PATCH] linux-2.6.32-directemp</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt; Wouldn't it make sense to make use of hardware =
monitoring interfaces so<BR>
&gt; lm_sensors could handle the sensor information? (added to CC)<BR>
&gt;<BR>
&gt; This would also be a good reason to have the driver on kernel =
side<BR>
&gt; rather than somewhere in userspace.<BR>
<BR>
Hi Bruno,<BR>
<BR>
I agree.&nbsp; However, I've had other drivers in the past been =
pooh-pooh'd by the lm-sensors maintainers because they don't seem to fit =
exactly what the lm-sensors folks want in a driver.&nbsp; Unfortunately, =
I&nbsp; seem to be bad at understanding the purpose of lm-sensors.&nbsp; =
:-)&nbsp; I'd like to get their approval before any work is done to =
migrate over to lm-sensors.<BR>
<BR>
Thanks,<BR>
Chris<BR>
<BR>
P.S.&nbsp; Sorry for any odd formatting with these e-mails.&nbsp; I'm =
stuck in Exchange hell.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CAA74E.23E193DF--


--===============5396807421418501557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5396807421418501557==--
