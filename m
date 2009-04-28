From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Tue, 28 Apr 2009 13:27:07 +0000
Subject: Re: [lm-sensors] Why internal sensor on atom cpu isn't yet
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C01D4FA82@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9C805.06E850DC"
List-Id: <lm-sensors.vger.kernel.org>
References: <1240762029.10972.15.camel@maxim-laptop>
In-Reply-To: <1240762029.10972.15.camel@maxim-laptop>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============5637066188382201236==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9C805.06E850DC"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9C805.06E850DC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The Intel EPSD systems with IPMI are now reporting 'margins' instead of =
'temperatres' for many sensors.

A margin is measured in degrees and is a negative number.  As the CPU or =
other device gets hotter the value increases towards zero.  If it goes =
positive, then you have 'overheated' and exceeded the spec.

I would agree that you should expose thw value from the sensor but would =
suggest we label these as 'margins' and not 'temperatures'

Phil P.

--=20
Philip Pokorny, RHCE
Chief Hardware Architect
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Maxim Levitsky [mailto:maximlevitsky@gmail.com]
Sent:	Tuesday, April 28, 2009 06:21 AM Pacific Standard Time
To:	Jean Delvare
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] Why internal sensor on atom cpu isn't yet =
supported?

On Tue, 2009-04-28 at 15:13 +0200, Jean Delvare wrote:
> On Tue, 28 Apr 2009 12:39:32 +0200, Rudolf Marek wrote:
> > Maxim Levitsky wrote:
> > > I use an old patch, and it works fine, was it forgotten?
> >=20
> > Hi,
> >=20
> > Well I think there are more atoms with different TjMax and I became =
tired to ask=20
> > Intel again and again.
>=20
> What's the plan then, never ever support the Atom thermal sensors?
> Seems wrong, TjMax for Core/Core2 is not that clear either, but we
> still do support these.
>=20

Lets just expose raw value, and let usespace (or user do the
calculation)

Just expose the  (30 degrees below maximum or so)

Best regards,
	Maxim Levitsky


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

------_=_NextPart_001_01C9C805.06E850DC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>Re: [lm-sensors] Why internal sensor on atom cpu isn't yet =
supported?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>The Intel EPSD systems with IPMI are now reporting =
'margins' instead of 'temperatres' for many sensors.<BR>
<BR>
A margin is measured in degrees and is a negative number.&nbsp; As the =
CPU or other device gets hotter the value increases towards zero.&nbsp; =
If it goes positive, then you have 'overheated' and exceeded the =
spec.<BR>
<BR>
I would agree that you should expose thw value from the sensor but would =
suggest we label these as 'margins' and not 'temperatures'<BR>
<BR>
Phil P.<BR>
<BR>
--<BR>
Philip Pokorny, RHCE<BR>
Chief Hardware Architect<BR>
Penguin Computing&nbsp; <A =
HREF=3D"http://www.penguincomputing.com">http://www.penguincomputing.com<=
/A><BR>
<BR>
&nbsp;-----Original Message-----<BR>
From: &nbsp; Maxim Levitsky [<A =
HREF=3D"mailto:maximlevitsky@gmail.com">mailto:maximlevitsky@gmail.com</A=
>]<BR>
Sent:&nbsp;&nbsp; Tuesday, April 28, 2009 06:21 AM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; Jean Delvare<BR>
Cc:&nbsp;&nbsp;&nbsp;&nbsp; lm-sensors@lm-sensors.org<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Re: [lm-sensors] Why =
internal sensor on atom cpu isn't yet supported?<BR>
<BR>
On Tue, 2009-04-28 at 15:13 +0200, Jean Delvare wrote:<BR>
&gt; On Tue, 28 Apr 2009 12:39:32 +0200, Rudolf Marek wrote:<BR>
&gt; &gt; Maxim Levitsky wrote:<BR>
&gt; &gt; &gt; I use an old patch, and it works fine, was it =
forgotten?<BR>
&gt; &gt;<BR>
&gt; &gt; Hi,<BR>
&gt; &gt;<BR>
&gt; &gt; Well I think there are more atoms with different TjMax and I =
became tired to ask<BR>
&gt; &gt; Intel again and again.<BR>
&gt;<BR>
&gt; What's the plan then, never ever support the Atom thermal =
sensors?<BR>
&gt; Seems wrong, TjMax for Core/Core2 is not that clear either, but =
we<BR>
&gt; still do support these.<BR>
&gt;<BR>
<BR>
Lets just expose raw value, and let usespace (or user do the<BR>
calculation)<BR>
<BR>
Just expose the&nbsp; (30 degrees below maximum or so)<BR>
<BR>
Best regards,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim Levitsky<BR>
<BR>
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
------_=_NextPart_001_01C9C805.06E850DC--


--===============5637066188382201236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5637066188382201236==--
