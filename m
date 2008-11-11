From: Sergio Gutierrez Verde <513172@unizar.es>
Date: Tue, 11 Nov 2008 10:22:40 +0000
Subject: Re: [lm-sensors] a problem with lm-sensor 2.10.7.
Message-Id: <BLU118-W3654CA430411654A31C127A2150@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1692002033885901101=="
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
In-Reply-To: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============1692002033885901101==
Content-Type: multipart/alternative;
	boundary="_0d87b044-f382-45a4-9fd0-80059f3c0aca_"

--_0d87b044-f382-45a4-9fd0-80059f3c0aca_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Yes=2C I use -Wall -W and -pedantic compiling options=2C and there aren't a=
ny problems=2C in compiling time.

Ok=2C I have read the 3.x API and you have reason=2C it's easier than 2.x. =
but in the computer is installed the older version.=20
I accept more suggestions... If I can't find the problem I'll change the ve=
rsion and I'll do a new code.

Thanks for your helpful information.


> Date: Tue=2C 11 Nov 2008 10:31:55 +0100
> From: khali@linux-fr.org
> To: 513172@unizar.es
> CC: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] a problem with lm-sensor 2.10.7.
>=20
> Hi Sergio=2C
>=20
> On Mon=2C 10 Nov 2008 19:20:05 +0100=2C Sergio Gutierrez Verde wrote:
> > I have a problem using a function of lm-sensors 2.10.7.
> >=20
> > In the next extract of code I try to get the CPU TEMP of a
> > certain chip. But when  'sensors_get_feature' is called=2C
> > there is a problem=2C a Segmentation fault.
> > I also try to use the most part of the code of lm-sensors
> > 2.10.7 (like main.c=2C chips.c and so on)=2C but the problem persists.
> > The chip and the sensors are the right.
>=20
> If I can allow myself a side comment=2C writing code for libsensors 2.x
> today is a bit odd. The libsensors 3.x API is perfectly stable by now
> and it is much better than 2.x so you should really use 3.x for new
> applications.
>=20
> > Could anyone find the wrong in my code?
>=20
> Did you try building it with -Wall -W? In many cases it is sufficient
> to point you to the problematic code.
>=20
> --=20
> Jean Delvare

_________________________________________________________________
Los m=E1s de lo m=E1s=2C Especial Rankings
http://events.es.msn.com/dinero/listas/default.aspx=

--_0d87b044-f382-45a4-9fd0-80059f3c0aca_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Yes=2C I use -Wall -W and -pedantic compiling options=2C and there aren't a=
ny problems=2C in compiling time.<br><br>Ok=2C I have read the 3.x API and =
you have reason=2C it's easier than 2.x. but in the computer is installed t=
he older version. <br>I accept more suggestions... If I can't find the prob=
lem I'll change the version and I'll do a new code.<br><br>Thanks for your =
helpful information.<br><br><br>&gt=3B Date: Tue=2C 11 Nov 2008 10:31:55 +0=
100<br>&gt=3B From: khali@linux-fr.org<br>&gt=3B To: 513172@unizar.es<br>&g=
t=3B CC: lm-sensors@lm-sensors.org<br>&gt=3B Subject: Re: [lm-sensors] a pr=
oblem with lm-sensor 2.10.7.<br>&gt=3B <br>&gt=3B Hi Sergio=2C<br>&gt=3B <b=
r>&gt=3B On Mon=2C 10 Nov 2008 19:20:05 +0100=2C Sergio Gutierrez Verde wro=
te:<br>&gt=3B &gt=3B I have a problem using a function of lm-sensors 2.10.7=
.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B In the next extract of code I try to g=
et the CPU TEMP of a<br>&gt=3B &gt=3B certain chip. But when  'sensors_get_=
feature' is called=2C<br>&gt=3B &gt=3B there is a problem=2C a Segmentation=
 fault.<br>&gt=3B &gt=3B I also try to use the most part of the code of lm-=
sensors<br>&gt=3B &gt=3B 2.10.7 (like main.c=2C chips.c and so on)=2C but t=
he problem persists.<br>&gt=3B &gt=3B The chip and the sensors are the righ=
t.<br>&gt=3B <br>&gt=3B If I can allow myself a side comment=2C writing cod=
e for libsensors 2.x<br>&gt=3B today is a bit odd. The libsensors 3.x API i=
s perfectly stable by now<br>&gt=3B and it is much better than 2.x so you s=
hould really use 3.x for new<br>&gt=3B applications.<br>&gt=3B <br>&gt=3B &=
gt=3B Could anyone find the wrong in my code?<br>&gt=3B <br>&gt=3B Did you =
try building it with -Wall -W? In many cases it is sufficient<br>&gt=3B to =
point you to the problematic code.<br>&gt=3B <br>&gt=3B -- <br>&gt=3B Jean =
Delvare<br><br /><hr />No te aburras m=E1s=2C eng=E1nchate a los <a href=3D=
'http://www.vivelive.com/juegos/' target=3D'_new'>Juegos de Messenger</a></=
body>
</html>=

--_0d87b044-f382-45a4-9fd0-80059f3c0aca_--


--===============1692002033885901101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1692002033885901101==--
