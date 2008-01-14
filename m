From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Mon, 14 Jan 2008 15:19:44 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was:
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C0113DBF3@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C856C0.E435DA55"
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============2022363240257554511==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C856C0.E435DA55"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C856C0.E435DA55
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It is also possible that those fans are not monitored.

Is there some indication in the manual or BIOS that these fans are =
monitored?

You should try plugging a fan into each fan header and see which ones =
are attached to which sensor inputs.  The labels in sensors.conf are =
only a guide and not specific for your motherboard.

Phil P.

--=20
Philip Pokorny, RHCE
Director of Field Engineering=20
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Andrew Voznytsa [mailto:andrew.voznytsa@gmail.com]
Sent:	Monday, January 14, 2008 06:49 AM Pacific Standard Time
To:	lm-sensors@lm-sensors.org
Subject:	[lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 (was: =
lm85in Intel S3000AH case)

More information on topic:

=20

I found http://www.lm-sensors.org/ticket/2195 which is related to my =
problem
- looked over sensors-detect output and found

=20

Some Super I/O chips may also contain sensors. We have to write to

standard I/O ports to probe them. This is usually safe.

Do you want to scan for Super I/O sensors? (YES/no):

Probing for Super-I/O at 0x2e/0x2f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     Yes

Found unknown chip with ID 0x8902

Probing for Super-I/O at 0x4e/0x4f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Fintek'...                       No

Trying family `ITE'...                                      No

=20

So is not this unknown chip with ID 0x8902 what is missing to support =
fans
5/6/etc?  If yes - could someone drop some light on topic when to expect =
it
supported?

Thanks,
Andrew Voznytsa

=20

  _____ =20

From: Andrew Voznytsa [mailto:andrew.voznytsa@gmail.com]=20
Sent: Sunday, January 13, 2008 12:28 AM
To: 'lm-sensors@lm-sensors.org'
Subject: lm85 in Intel S3000AH case

=20

Hi guys,

=20

Just installed lm-sensors (2.10.4 and 3.0.0) on S3000AH-based system =
(Linux
version 2.6.23-gentoo-r3 (root@farm) (gcc version 4.1.2 (Gentoo 4.1.2 =
p1.0

.2)), x86_64) - works fine except lm-sensors does not show fans 5 and 6. =
Is
it fixable? (I'd leave my chassis fan connected to 5th socket and do not
reconnect it to 2-4)

=20

Here is part of sensors-detect output

=20

  Detects correctly:

  * Bus `SMBus I801 adapter at 3000'

    Busdriver `i2c-i801', I2C address 0x2e

    Chip `SMSC EMC6D100, EMC6D101 or EMC6D102' (confidence: 7)

=20

And sensors output:

=20

lm85-i2c-0-2e

Adapter: SMBus I801 adapter at 3000

V1.5:        +2.29 V  (min =3D  +0.00 V, max =3D  +3.32 V)

VCore:       +1.14 V  (min =3D  +0.00 V, max =3D  +2.99 V)

V3.3:        +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)

V5:          +1.51 V  (min =3D  +0.00 V, max =3D  +6.64 V)

V12:        +12.81 V  (min =3D  +0.00 V, max =3D +15.94 V)

CPU_Fan:    1769 RPM  (min =3D  720 RPM)

fan2:          0 RPM  (min =3D  720 RPM)

fan3:          0 RPM  (min =3D  720 RPM)

fan4:          0 RPM  (min =3D  720 RPM)

CPU Temp:    -63.0 C  (low  =3D -127.0 C, high =3D +127.0 C)

Board Temp:  +39.0 C  (low  =3D -127.0 C, high =3D +127.0 C)

DIMM Temp:   +29.0 C  (low  =3D -127.0 C, high =3D +127.0 C)

cpu0_vid:   +0.000 V

Best regards,
Andrew Voznytsa

=20


------_=_NextPart_001_01C856C0.E435DA55
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>RE: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902 =
(was: lm85in Intel S3000AH case)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>It is also possible that those fans are not =
monitored.<BR>
<BR>
Is there some indication in the manual or BIOS that these fans are =
monitored?<BR>
<BR>
You should try plugging a fan into each fan header and see which ones =
are attached to which sensor inputs.&nbsp; The labels in sensors.conf =
are only a guide and not specific for your motherboard.<BR>
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
From: &nbsp; Andrew Voznytsa [<A =
HREF=3D"mailto:andrew.voznytsa@gmail.com">mailto:andrew.voznytsa@gmail.co=
m</A>]<BR>
Sent:&nbsp;&nbsp; Monday, January 14, 2008 06:49 AM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; lm-sensors@lm-sensors.org<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [lm-sensors] SMSC =
Super I/O: unknown chip with ID 0x8902 (was: lm85in Intel S3000AH =
case)<BR>
<BR>
More information on topic:<BR>
<BR>
<BR>
<BR>
I found <A =
HREF=3D"http://www.lm-sensors.org/ticket/2195">http://www.lm-sensors.org/=
ticket/2195</A> which is related to my problem<BR>
- looked over sensors-detect output and found<BR>
<BR>
<BR>
<BR>
Some Super I/O chips may also contain sensors. We have to write to<BR>
<BR>
standard I/O ports to probe them. This is usually safe.<BR>
<BR>
Do you want to scan for Super I/O sensors? (YES/no):<BR>
<BR>
Probing for Super-I/O at 0x2e/0x2f<BR>
<BR>
Trying family `National =
Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>
<BR>
Trying family =
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Yes<BR>
<BR>
Found unknown chip with ID 0x8902<BR>
<BR>
Probing for Super-I/O at 0x4e/0x4f<BR>
<BR>
Trying family `National =
Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<BR>
<BR>
Trying family =
`SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; No<BR>
<BR>
Trying family =
`VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; No<BR>
<BR>
Trying family =
`ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; No<BR>
<BR>
<BR>
<BR>
So is not this unknown chip with ID 0x8902 what is missing to support =
fans<BR>
5/6/etc?&nbsp; If yes - could someone drop some light on topic when to =
expect it<BR>
supported?<BR>
<BR>
Thanks,<BR>
Andrew Voznytsa<BR>
<BR>
<BR>
<BR>
&nbsp; _____&nbsp;<BR>
<BR>
From: Andrew Voznytsa [<A =
HREF=3D"mailto:andrew.voznytsa@gmail.com">mailto:andrew.voznytsa@gmail.co=
m</A>]<BR>
Sent: Sunday, January 13, 2008 12:28 AM<BR>
To: 'lm-sensors@lm-sensors.org'<BR>
Subject: lm85 in Intel S3000AH case<BR>
<BR>
<BR>
<BR>
Hi guys,<BR>
<BR>
<BR>
<BR>
Just installed lm-sensors (2.10.4 and 3.0.0) on S3000AH-based system =
(Linux<BR>
version 2.6.23-gentoo-r3 (root@farm) (gcc version 4.1.2 (Gentoo 4.1.2 =
p1.0<BR>
<BR>
.2)), x86_64) - works fine except lm-sensors does not show fans 5 and 6. =
Is<BR>
it fixable? (I'd leave my chassis fan connected to 5th socket and do =
not<BR>
reconnect it to 2-4)<BR>
<BR>
<BR>
<BR>
Here is part of sensors-detect output<BR>
<BR>
<BR>
<BR>
&nbsp; Detects correctly:<BR>
<BR>
&nbsp; * Bus `SMBus I801 adapter at 3000'<BR>
<BR>
&nbsp;&nbsp;&nbsp; Busdriver `i2c-i801', I2C address 0x2e<BR>
<BR>
&nbsp;&nbsp;&nbsp; Chip `SMSC EMC6D100, EMC6D101 or EMC6D102' =
(confidence: 7)<BR>
<BR>
<BR>
<BR>
And sensors output:<BR>
<BR>
<BR>
<BR>
lm85-i2c-0-2e<BR>
<BR>
Adapter: SMBus I801 adapter at 3000<BR>
<BR>
V1.5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.29 V&nbsp; (min =
=3D&nbsp; +0.00 V, max =3D&nbsp; +3.32 V)<BR>
<BR>
VCore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.14 V&nbsp; (min =3D&nbsp; =
+0.00 V, max =3D&nbsp; +2.99 V)<BR>
<BR>
V3.3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.35 V&nbsp; (min =
=3D&nbsp; +0.00 V, max =3D&nbsp; +4.38 V)<BR>
<BR>
V5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.51 V&nbsp; =
(min =3D&nbsp; +0.00 V, max =3D&nbsp; +6.64 V)<BR>
<BR>
V12:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +12.81 V&nbsp; (min =
=3D&nbsp; +0.00 V, max =3D +15.94 V)<BR>
<BR>
CPU_Fan:&nbsp;&nbsp;&nbsp; 1769 RPM&nbsp; (min =3D&nbsp; 720 RPM)<BR>
<BR>
fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; =
(min =3D&nbsp; 720 RPM)<BR>
<BR>
fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; =
(min =3D&nbsp; 720 RPM)<BR>
<BR>
fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; =
(min =3D&nbsp; 720 RPM)<BR>
<BR>
CPU Temp:&nbsp;&nbsp;&nbsp; -63.0 C&nbsp; (low&nbsp; =3D -127.0 C, high =
=3D +127.0 C)<BR>
<BR>
Board Temp:&nbsp; +39.0 C&nbsp; (low&nbsp; =3D -127.0 C, high =3D +127.0 =
C)<BR>
<BR>
DIMM Temp:&nbsp;&nbsp; +29.0 C&nbsp; (low&nbsp; =3D -127.0 C, high =3D =
+127.0 C)<BR>
<BR>
cpu0_vid:&nbsp;&nbsp; +0.000 V<BR>
<BR>
Best regards,<BR>
Andrew Voznytsa<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C856C0.E435DA55--


--===============2022363240257554511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2022363240257554511==--
