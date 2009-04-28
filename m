From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Tue, 28 Apr 2009 13:31:16 +0000
Subject: Re: [lm-sensors] Why internal sensor on atom cpu isn't yet
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C01D4FA83@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9C805.9B643420"
List-Id: <lm-sensors.vger.kernel.org>
References: <1240762029.10972.15.camel@maxim-laptop>
In-Reply-To: <1240762029.10972.15.camel@maxim-laptop>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============4730096418932039472==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9C805.9B643420"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9C805.9B643420
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Why doesn't this fit the current temperature interface?  What is there =
in the interface that says it has to be an absolute temperature and not =
a relative temperature?

Alarms, min-max, hysterisis, etc all still work the same, they are just =
shifted so that the max limit is zero and the typical values are less =
than zero.  We allow negative temperatures in the library.

Phil P.

--=20
Philip Pokorny, RHCE
Chief Hardware Architect
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Jean Delvare [mailto:khali@linux-fr.org]
Sent:	Tuesday, April 28, 2009 06:26 AM Pacific Standard Time
To:	Maxim Levitsky
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] Why internal sensor on atom cpu isn't yet =
supported?

On Tue, 28 Apr 2009 16:18:45 +0300, Maxim Levitsky wrote:
> On Tue, 2009-04-28 at 15:13 +0200, Jean Delvare wrote:
> > On Tue, 28 Apr 2009 12:39:32 +0200, Rudolf Marek wrote:
> > > Maxim Levitsky wrote:
> > > > I use an old patch, and it works fine, was it forgotten?
> > >=20
> > > Hi,
> > >=20
> > > Well I think there are more atoms with different TjMax and I =
became tired to ask=20
> > > Intel again and again.
> >=20
> > What's the plan then, never ever support the Atom thermal sensors?
> > Seems wrong, TjMax for Core/Core2 is not that clear either, but we
> > still do support these.
> >=20
>=20
> Lets just expose raw value, and let usespace (or user do the
> calculation)
>=20
> Just expose the  (30 degrees below maximum or so)

This doesn't fit in our standard interface. If we want to do this (I'm
not sure) we need to define a new interface first.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

------_=_NextPart_001_01C9C805.9B643420
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

<P><FONT SIZE=3D2>Why doesn't this fit the current temperature =
interface?&nbsp; What is there in the interface that says it has to be =
an absolute temperature and not a relative temperature?<BR>
<BR>
Alarms, min-max, hysterisis, etc all still work the same, they are just =
shifted so that the max limit is zero and the typical values are less =
than zero.&nbsp; We allow negative temperatures in the library.<BR>
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
From: &nbsp; Jean Delvare [<A =
HREF=3D"mailto:khali@linux-fr.org">mailto:khali@linux-fr.org</A>]<BR>
Sent:&nbsp;&nbsp; Tuesday, April 28, 2009 06:26 AM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; Maxim Levitsky<BR>
Cc:&nbsp;&nbsp;&nbsp;&nbsp; lm-sensors@lm-sensors.org<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Re: [lm-sensors] Why =
internal sensor on atom cpu isn't yet supported?<BR>
<BR>
On Tue, 28 Apr 2009 16:18:45 +0300, Maxim Levitsky wrote:<BR>
&gt; On Tue, 2009-04-28 at 15:13 +0200, Jean Delvare wrote:<BR>
&gt; &gt; On Tue, 28 Apr 2009 12:39:32 +0200, Rudolf Marek wrote:<BR>
&gt; &gt; &gt; Maxim Levitsky wrote:<BR>
&gt; &gt; &gt; &gt; I use an old patch, and it works fine, was it =
forgotten?<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; Hi,<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; Well I think there are more atoms with different TjMax =
and I became tired to ask<BR>
&gt; &gt; &gt; Intel again and again.<BR>
&gt; &gt;<BR>
&gt; &gt; What's the plan then, never ever support the Atom thermal =
sensors?<BR>
&gt; &gt; Seems wrong, TjMax for Core/Core2 is not that clear either, =
but we<BR>
&gt; &gt; still do support these.<BR>
&gt; &gt;<BR>
&gt;<BR>
&gt; Lets just expose raw value, and let usespace (or user do the<BR>
&gt; calculation)<BR>
&gt;<BR>
&gt; Just expose the&nbsp; (30 degrees below maximum or so)<BR>
<BR>
This doesn't fit in our standard interface. If we want to do this =
(I'm<BR>
not sure) we need to define a new interface first.<BR>
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
------_=_NextPart_001_01C9C805.9B643420--


--===============4730096418932039472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4730096418932039472==--
