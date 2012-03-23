From: Tomas Johansson <tomasx@hotmail.com>
Date: Fri, 23 Mar 2012 09:38:57 +0000
Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <SNT106-W26EB4039FBA5BE591F5263D3460@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6220716618607461843=="
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
In-Reply-To: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============6220716618607461843==
Content-Type: multipart/alternative;
	boundary="_a5fff9ec-e9df-47ac-b74b-6fe49f408c2b_"

--_a5fff9ec-e9df-47ac-b74b-6fe49f408c2b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



> Date: Fri=2C 23 Mar 2012 10:05:42 +0100
> From: khali@linux-fr.org
> To: tomasx@hotmail.com
> CC: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
>=20
> Tomas=2C please don't top-post.
>=20
> On Fri=2C 23 Mar 2012 10:00:09 +0100=2C Tomas Johansson wrote:
> > Because=2C these are idle values:
> >=20
> > BIOS:
> > SYS 34 C
> > CPU 32 C
>=20
> Most likely the above are NOT idle values. The BIOS is not idle - at
> least never as idle as Linux can be with CPU frequency and voltage
> scaling and low C states.
>=20
> > lm-sensors:
> > temp1:        +34.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor=
 =3D thermistor
> > temp2:        +31.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor=
 =3D thermistor
> > temp3:        +25.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor=
 =3D thermistor
> >=20
> >=20
> > And when i for example compile firefox temp3 will rise to around 45-50 =
C=2C while temp2 stays at 31 C.
>=20
> This is correct reasoning though. temp3 is CPU temp. But you're
> comparing Linux idle with BIOS not idle=2C no surprise the values don't
> match.
>=20
> --=20
> Jean Delvare

Calm down. :)
You seem a litte bit hostile Jean=2C i am sorry if i do not live up to your=
 standards.

However=2C i do not agree with you=2C no=2C BIOS is not IDLE but it is not =
FULL LOAD either. I have never seen a so big difference between BIOS and Li=
nux idle=2C usually they are 1-2 degrees.
 		 	   		  =

--_a5fff9ec-e9df-47ac-b74b-6fe49f408c2b_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<br><div>&gt=3B Date: Fri=2C 23 Mar 2012 10:05:42 +0100<br>&gt=3B From: kha=
li@linux-fr.org<br>&gt=3B To: tomasx@hotmail.com<br>&gt=3B CC: lm-sensors@l=
m-sensors.org<br>&gt=3B Subject: Re: [lm-sensors] IT8728 shows wrong CPU te=
mperature<br>&gt=3B <br>&gt=3B Tomas=2C please don't top-post.<br>&gt=3B <b=
r>&gt=3B On Fri=2C 23 Mar 2012 10:00:09 +0100=2C Tomas Johansson wrote:<br>=
&gt=3B &gt=3B Because=2C these are idle values:<br>&gt=3B &gt=3B <br>&gt=3B=
 &gt=3B BIOS:<br>&gt=3B &gt=3B SYS 34 C<br>&gt=3B &gt=3B CPU 32 C<br>&gt=3B=
 <br>&gt=3B Most likely the above are NOT idle values. The BIOS is not idle=
 - at<br>&gt=3B least never as idle as Linux can be with CPU frequency and =
voltage<br>&gt=3B scaling and low C states.<br>&gt=3B <br>&gt=3B &gt=3B lm-=
sensors:<br>&gt=3B &gt=3B temp1:        +34.0 C  (low  =3D +127.0 C=2C high=
 =3D +127.0 C)  sensor =3D thermistor<br>&gt=3B &gt=3B temp2:        +31.0 =
C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor =3D thermistor<br>&gt=
=3B &gt=3B temp3:        +25.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C) =
 sensor =3D thermistor<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B=
 And when i for example compile firefox temp3 will rise to around 45-50 C=
=2C while temp2 stays at 31 C.<br>&gt=3B <br>&gt=3B This is correct reasoni=
ng though. temp3 is CPU temp. But you're<br>&gt=3B comparing Linux idle wit=
h BIOS not idle=2C no surprise the values don't<br>&gt=3B match.<br>&gt=3B =
<br>&gt=3B -- <br>&gt=3B Jean Delvare<br><br>Calm down. :)<br>You seem a li=
tte bit hostile Jean=2C i am sorry if i do not live up to your standards.<b=
r><br>However=2C i do not agree with you=2C no=2C BIOS is not IDLE but it i=
s not FULL LOAD either. I have never seen a so big difference between BIOS =
and Linux idle=2C usually they are 1-2 degrees.<br></div> 		 	   		  </div>=
</body>
</html>=

--_a5fff9ec-e9df-47ac-b74b-6fe49f408c2b_--


--===============6220716618607461843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6220716618607461843==--
