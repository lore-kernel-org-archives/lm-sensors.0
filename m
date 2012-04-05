From: "Chislett, William" <William.Chislett@baesystemsdetica.com>
Date: Thu, 05 Apr 2012 10:17:11 +0000
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <9A372728639DC642813D19869275E7B35563F5@ukastblkexb02.detica.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CD1315.3DF92C49"
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============8750259308404903534==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CD1315.3DF92C49"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CD1315.3DF92C49
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Good Morning,

Apologies in advance as I realise the subject of this email may be
slightly outdated and the driver I'm referring to was created some time
ago (back in 2009!) but I've reached a dead-end trying to get reliable
sensor readings from a new ASUS server (ASUS ESC4000), and was hoping
someone might be able to help.

The issue I'm having is that lm-sensors only reads back realistic values
for about 10% of the time.  The rest of the time all fanspeeds default
to 90,000rpm and all temperatures to -0.2degrees and over 80degrees,
which are obviously incorrect.  I've tried using the latest version of
lm-sensors and the w83795 driver but keep running into this problem.
The w83795 driver provided on the lm-sensorswiki/Devices is the same as
that provided for this server via the ASUS website.

I'm using Linux CentOS 5.4 with a 2.6.18-164.el5 kernel (which isn't
listed as being supported by this driver unfortunately - probably part
of the issue).  I've also seen similar problems, although mostly
involving sensor values locking-up, when using this driver and
ipmi-tools or similar hardware monitoring utilities.

I was wondering if you knew of any updated versions of this driver, or
alternatives I could try at all.  Any sort of advice at all would be
massively appreciated!

Thanks for your time,
Will
______________________________________________
William Chislett=20
t +44 (0)207 812 4822 | m +44 (0)794 0023 001
a Detica | Surrey Research Park | Guildford | GU2 7YP | UK
______________________________________________
www.baesystemsdetica.com <http://www.baesystemsdetica.com/> =20



Please consider the environment before printing this email.
 =

This message should be regarded as confidential. If you have received thi=
s email in error please notify the sender and destroy it immediately.
 =

Statements of intent shall only become binding when confirmed in hard cop=
y by an authorised signatory. =

 =

The contents of this email may relate to dealings with other companies un=
der the control of BAE Systems plc details of which can be found at http:=
//www.baesystems.com/Businesses/index.htm.
 =

Detica Limited is a BAE Systems company trading as BAE Systems Detica.
Detica Limited is registered in England and Wales under No: 1337451.
Registered office: Surrey Research Park, Guildford, Surrey, GU2 7YP, Engl=
and.
=0D
------_=_NextPart_001_01CD1315.3DF92C49
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Good Morning,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apologies in advance as I realise the =
subject of this email may be slightly outdated and the driver I'm =
referring to was created some time ago (back in 2009!) but I've reached =
a dead-end trying to get reliable sensor readings from a new ASUS server =
(ASUS ESC4000), and was hoping someone might be able to help.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The issue I'm having is that lm-sensors =
only reads back realistic values for about 10% of the time.&nbsp; The =
rest of the time all fanspeeds default to 90,000rpm and all temperatures =
to -0.2degrees and over 80degrees, which are obviously incorrect.&nbsp; =
I've tried using the latest version of lm-sensors and the w83795 driver =
but keep running into this problem.&nbsp; The w83795 driver provided on =
the lm-sensorswiki/Devices is the same as that provided for this server =
via the ASUS website.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm using Linux CentOS 5.4 with a =
2.6.18-164.el5 kernel (which isn't listed as being supported by this =
driver unfortunately - probably part of the issue).&nbsp; I've also seen =
similar problems, although mostly involving sensor values locking-up, =
when using this driver and ipmi-tools or similar hardware monitoring =
utilities.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I was wondering if you knew of any =
updated versions of this driver, or alternatives I could try at =
all.&nbsp; Any sort of advice at all would be massively =
appreciated!</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks for your time,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Will</FONT>

<BR><B><FONT COLOR=3D"#C0C0C0" =
FACE=3D"Arial">______________________________________________</FONT></B><=
BR>
<B></B><B><FONT SIZE=3D2 FACE=3D"Arial">William Chislett</FONT></B><FONT =
SIZE=3D2 FACE=3D"Arial"></FONT><B></B><B> </B>

<BR><B><FONT FACE=3D"Arial">t</FONT></B><FONT SIZE=3D2 FACE=3D"Arial"> =
+44 (0)207 812 4822</FONT><FONT FACE=3D"Arial"> </FONT><FONT SIZE=3D2 =
FACE=3D"Arial">|</FONT><B></B><B><FONT FACE=3D"Arial"> m</FONT></B><FONT =
SIZE=3D2 FACE=3D"Arial"> +44 (0)794 0023 001<BR>
</FONT><B></B><B><FONT FACE=3D"Arial">a</FONT></B><FONT SIZE=3D2 =
FACE=3D"Arial"> Detica</FONT><FONT FACE=3D"Arial"> </FONT><FONT SIZE=3D2 =
FACE=3D"Arial">|</FONT><FONT FACE=3D"Arial"> </FONT><FONT SIZE=3D2 =
FACE=3D"Arial">Surrey Research Park</FONT><FONT FACE=3D"Arial"> =
</FONT><FONT SIZE=3D2 FACE=3D"Arial">|</FONT><FONT FACE=3D"Arial"> =
</FONT><FONT SIZE=3D2 FACE=3D"Arial">Guildford | GU2 7YP</FONT><FONT =
FACE=3D"Arial"> </FONT><FONT SIZE=3D2 FACE=3D"Arial">|</FONT><FONT =
FACE=3D"Arial"> </FONT><FONT SIZE=3D2 FACE=3D"Arial">UK</FONT>

<BR><B><FONT COLOR=3D"#C0C0C0" =
FACE=3D"Arial">______________________________________________</FONT></B><=
BR>
<A HREF=3D"http://www.baesystemsdetica.com/"><U></U><U><B><FONT =
COLOR=3D"#008AC9" SIZE=3D2 =
FACE=3D"Arial">www.baesystemsdetica.com</FONT></B></U></A><FONT =
FACE=3D"Arial"> </FONT>
</P>
<BR>

</BODY>
</HTML>
<pre>Please consider the environment before printing this email.
 =

This message should be regarded as confidential. If you have received thi=
s email in error please notify the sender and destroy it immediately.
 =

Statements of intent shall only become binding when confirmed in hard cop=
y by an authorised signatory. =

 =

The contents of this email may relate to dealings with other companies un=
der the control of BAE Systems plc details of which can be found at http:=
//www.baesystems.com/Businesses/index.htm.
 =

Detica Limited is a BAE Systems company trading as BAE Systems Detica.
Detica Limited is registered in England and Wales under No: 1337451.
Registered office: Surrey Research Park, Guildford, Surrey, GU2 7YP, Engl=
and.
=0D
------_=_NextPart_001_01CD1315.3DF92C49--


--===============8750259308404903534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8750259308404903534==--
