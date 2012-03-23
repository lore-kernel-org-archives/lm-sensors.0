From: Tomas Johansson <tomasx@hotmail.com>
Date: Fri, 23 Mar 2012 09:00:09 +0000
Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <SNT106-W3290D16302F7E7AA26DB0FD3460@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7211654718619819650=="
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
In-Reply-To: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
To: lm-sensors@vger.kernel.org

--===============7211654718619819650==
Content-Type: multipart/alternative;
	boundary="_23fd0c9e-4f24-444b-929d-297ae8d2dd00_"

--_23fd0c9e-4f24-444b-929d-297ae8d2dd00_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Because=2C these are idle values:

BIOS:
SYS 34 C
CPU 32 C

lm-sensors:
temp1:        +34.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor =3D=
 thermistor
temp2:        +31.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor =3D=
 thermistor
temp3:        +25.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor =3D=
 thermistor


And when i for example compile firefox temp3 will rise to around 45-50 C=2C=
 while temp2 stays at 31 C.




> Date: Fri=2C 23 Mar 2012 01:14:56 -0700
> From: guenter.roeck@ericsson.com
> To: tomasx@hotmail.com
> CC: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
>=20
> On Fri=2C Mar 23=2C 2012 at 04:00:35AM -0400=2C Tomas Johansson wrote:
> > Hi!
> >=20
> > I have a Gigabyte GA-P67A-UD5-B3 with a IT8728F=2C yesterday i upgraded=
 to Linux
> > 3.3 and tested the new IT87 module.
> > As i will show below it shows wrong CPU temperature.
> >=20
> > First:
> >=20
> > temp1 shows system or motherboard if you want.
> > temp2 shows ?=2C probably unused
> > temp3 shows CPU but is 7-8 degrees wrong compared to BIOS (I know that =
temp3 is
> > CPU because it is the only temp value that differ under load)
> >=20
> >=20
> > BIOS at this moment in time showed:
> > SYS 34 C
> > CPU 32 C
> >=20
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Physical id 0:  +36.0 C  (high =3D +80.0 C=2C crit =3D +98.0 C)
> > Core 0:         +36.0 C  (high =3D +80.0 C=2C crit =3D +98.0 C)
> > Core 1:         +35.0 C  (high =3D +80.0 C=2C crit =3D +98.0 C)
> > Core 2:         +33.0 C  (high =3D +80.0 C=2C crit =3D +98.0 C)
> > Core 3:         +35.0 C  (high =3D +80.0 C=2C crit =3D +98.0 C)
> >=20
> > it8728-isa-0290
> > Adapter: ISA adapter
> > in0:          +1.08 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
> > in1:          +2.03 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
> > in2:          +2.96 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
> > in3:          +2.93 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
> > in4:          +0.24 V  (min =3D  +0.00 V=2C max =3D  +0.84 V)
> > in5:          +1.20 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
> > in6:          +1.55 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
> > 3VSB:         +3.38 V  (min =3D  +0.00 V=2C max =3D  +6.12 V)
> > Vbat:         +3.26 V =20
> > fan1:        1056 RPM  (min =3D    0 RPM)
> > fan2:           0 RPM  (min =3D    0 RPM)
> > fan3:           0 RPM  (min =3D    0 RPM)
> > fan4:           0 RPM  (min =3D    0 RPM)
> > fan5:        1374 RPM  (min =3D    0 RPM)
> > temp1:        +34.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor=
 =3D thermistor
> > temp2:        +31.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor=
 =3D thermistor
> > temp3:        +25.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor=
 =3D thermistor
> > intrusion0:  ALARM
> >=20
> >=20
> >=20
> > Conclusion:
> >=20
> > fan1=2C shows correct value.
> > fan5=2C shows correct value.
> > temp1 (system)=2C shows correct value.
> > temp3 (CPU)=2C shows wrong value=2C in this case 25 C instead of 32 C.
> >=20
> I am a bit lost here. Why do you assume that temp2 (which would show roug=
hly
> the correct temperature) is unused=2C and that temp3 is the CPU temperatu=
re ?
> Why not temp2=3DCPU and temp3=3D???=20
>=20
> What happens if you run something challenging on the system ?
>=20
> Guenter
 		 	   		  =

--_23fd0c9e-4f24-444b-929d-297ae8d2dd00_
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
Because=2C these are idle values:<br><br>BIOS:<br>SYS 34 C<br>CPU 32 C<br><=
br>lm-sensors:<br>temp1:        +34.0 C  (low  =3D +127.0 C=2C high =3D +12=
7.0 C)  sensor =3D thermistor<br>temp2:        +31.0 C  (low  =3D +127.0 C=
=2C high =3D +127.0 C)  sensor =3D thermistor<br>temp3:        +25.0 C  (lo=
w  =3D +127.0 C=2C high =3D +127.0 C)  sensor =3D thermistor<br><br><br>And=
 when i for example compile firefox temp3 will rise to around 45-50 C=2C wh=
ile temp2 stays at 31 C.<br><br><br><br><br><div><div id=3D"SkyDrivePlaceho=
lder"></div>&gt=3B Date: Fri=2C 23 Mar 2012 01:14:56 -0700<br>&gt=3B From: =
guenter.roeck@ericsson.com<br>&gt=3B To: tomasx@hotmail.com<br>&gt=3B CC: l=
m-sensors@lm-sensors.org<br>&gt=3B Subject: Re: [lm-sensors] IT8728 shows w=
rong CPU temperature<br>&gt=3B <br>&gt=3B On Fri=2C Mar 23=2C 2012 at 04:00=
:35AM -0400=2C Tomas Johansson wrote:<br>&gt=3B &gt=3B Hi!<br>&gt=3B &gt=3B=
 <br>&gt=3B &gt=3B I have a Gigabyte GA-P67A-UD5-B3 with a IT8728F=2C yeste=
rday i upgraded to Linux<br>&gt=3B &gt=3B 3.3 and tested the new IT87 modul=
e.<br>&gt=3B &gt=3B As i will show below it shows wrong CPU temperature.<br=
>&gt=3B &gt=3B <br>&gt=3B &gt=3B First:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B =
temp1 shows system or motherboard if you want.<br>&gt=3B &gt=3B temp2 shows=
 ?=2C probably unused<br>&gt=3B &gt=3B temp3 shows CPU but is 7-8 degrees w=
rong compared to BIOS (I know that temp3 is<br>&gt=3B &gt=3B CPU because it=
 is the only temp value that differ under load)<br>&gt=3B &gt=3B <br>&gt=3B=
 &gt=3B <br>&gt=3B &gt=3B BIOS at this moment in time showed:<br>&gt=3B &gt=
=3B SYS 34 C<br>&gt=3B &gt=3B CPU 32 C<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <=
br>&gt=3B &gt=3B coretemp-isa-0000<br>&gt=3B &gt=3B Adapter: ISA adapter<br=
>&gt=3B &gt=3B Physical id 0:  +36.0 C  (high =3D +80.0 C=2C crit =3D +98.0=
 C)<br>&gt=3B &gt=3B Core 0:         +36.0 C  (high =3D +80.0 C=2C crit =3D=
 +98.0 C)<br>&gt=3B &gt=3B Core 1:         +35.0 C  (high =3D +80.0 C=2C cr=
it =3D +98.0 C)<br>&gt=3B &gt=3B Core 2:         +33.0 C  (high =3D +80.0 C=
=2C crit =3D +98.0 C)<br>&gt=3B &gt=3B Core 3:         +35.0 C  (high =3D +=
80.0 C=2C crit =3D +98.0 C)<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B it8728-isa-0=
290<br>&gt=3B &gt=3B Adapter: ISA adapter<br>&gt=3B &gt=3B in0:          +1=
.08 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)<br>&gt=3B &gt=3B in1:        =
  +2.03 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)<br>&gt=3B &gt=3B in2:    =
      +2.96 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)<br>&gt=3B &gt=3B in3:=
          +2.93 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)<br>&gt=3B &gt=3B =
in4:          +0.24 V  (min =3D  +0.00 V=2C max =3D  +0.84 V)<br>&gt=3B &gt=
=3B in5:          +1.20 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)<br>&gt=3B=
 &gt=3B in6:          +1.55 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)<br>&g=
t=3B &gt=3B 3VSB:         +3.38 V  (min =3D  +0.00 V=2C max =3D  +6.12 V)<b=
r>&gt=3B &gt=3B Vbat:         +3.26 V  <br>&gt=3B &gt=3B fan1:        1056 =
RPM  (min =3D    0 RPM)<br>&gt=3B &gt=3B fan2:           0 RPM  (min =3D   =
 0 RPM)<br>&gt=3B &gt=3B fan3:           0 RPM  (min =3D    0 RPM)<br>&gt=
=3B &gt=3B fan4:           0 RPM  (min =3D    0 RPM)<br>&gt=3B &gt=3B fan5:=
        1374 RPM  (min =3D    0 RPM)<br>&gt=3B &gt=3B temp1:        +34.0 C=
  (low  =3D +127.0 C=2C high =3D +127.0 C)  sensor =3D thermistor<br>&gt=3B=
 &gt=3B temp2:        +31.0 C  (low  =3D +127.0 C=2C high =3D +127.0 C)  se=
nsor =3D thermistor<br>&gt=3B &gt=3B temp3:        +25.0 C  (low  =3D +127.=
0 C=2C high =3D +127.0 C)  sensor =3D thermistor<br>&gt=3B &gt=3B intrusion=
0:  ALARM<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &=
gt=3B Conclusion:<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B fan1=2C shows correct =
value.<br>&gt=3B &gt=3B fan5=2C shows correct value.<br>&gt=3B &gt=3B temp1=
 (system)=2C shows correct value.<br>&gt=3B &gt=3B temp3 (CPU)=2C shows wro=
ng value=2C in this case 25 C instead of 32 C.<br>&gt=3B &gt=3B <br>&gt=3B =
I am a bit lost here. Why do you assume that temp2 (which would show roughl=
y<br>&gt=3B the correct temperature) is unused=2C and that temp3 is the CPU=
 temperature ?<br>&gt=3B Why not temp2=3DCPU and temp3=3D??? <br>&gt=3B <br=
>&gt=3B What happens if you run something challenging on the system ?<br>&g=
t=3B <br>&gt=3B Guenter<br></div> 		 	   		  </div></body>
</html>=

--_23fd0c9e-4f24-444b-929d-297ae8d2dd00_--


--===============7211654718619819650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7211654718619819650==--
