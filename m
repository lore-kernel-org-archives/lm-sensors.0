From: Tomas Johansson <tomasx@hotmail.com>
Date: Fri, 23 Mar 2012 08:00:35 +0000
Subject: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8401819533540708918=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8401819533540708918==
Content-Type: multipart/alternative;
	boundary="_56eb3879-3d08-4f55-a45e-8630fd87b68e_"

--_56eb3879-3d08-4f55-a45e-8630fd87b68e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi!

I have a Gigabyte GA-P67A-UD5-B3 with a IT8728F=2C yesterday i upgraded to =
Linux 3.3 and tested the new IT87 module.
As i will show below it shows wrong CPU temperature.

First:

temp1 shows system or motherboard if you want.
temp2 shows ?=2C probably unused
temp3 shows CPU but is 7-8 degrees wrong compared to BIOS (I know that temp=
3 is CPU because it is the only temp value that differ under load)


BIOS at this moment in time showed:
SYS 34=B0C
CPU 32=B0C


coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +36.0=B0C  (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)
Core 0:         +36.0=B0C  (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)
Core 1:         +35.0=B0C  (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)
Core 2:         +33.0=B0C  (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)
Core 3:         +35.0=B0C  (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)

it8728-isa-0290
Adapter: ISA adapter
in0:          +1.08 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
in1:          +2.03 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
in2:          +2.96 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
in3:          +2.93 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
in4:          +0.24 V  (min =3D  +0.00 V=2C max =3D  +0.84 V)
in5:          +1.20 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
in6:          +1.55 V  (min =3D  +0.00 V=2C max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V=2C max =3D  +6.12 V)
Vbat:         +3.26 V =20
fan1:        1056 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
fan5:        1374 RPM  (min =3D    0 RPM)
temp1:        +34.0=B0C  (low  =3D +127.0=B0C=2C high =3D +127.0=B0C)  sens=
or =3D thermistor
temp2:        +31.0=B0C  (low  =3D +127.0=B0C=2C high =3D +127.0=B0C)  sens=
or =3D thermistor
temp3:        +25.0=B0C  (low  =3D +127.0=B0C=2C high =3D +127.0=B0C)  sens=
or =3D thermistor
intrusion0:  ALARM



Conclusion:

fan1=2C shows correct value.
fan5=2C shows correct value.
temp1 (system)=2C shows correct value.
temp3 (CPU)=2C shows wrong value=2C in this case 25=B0C instead of 32=B0C.


I have studied the other IT8278 reports i have found and as far as i can te=
ll that they suffer from the same wrong cpu readings=2C i do not understand=
 why they have reported them as correct...


Thanks in advance.

/Tomas
 		 	   		  =

--_56eb3879-3d08-4f55-a45e-8630fd87b68e_
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
Hi!<br><br>I have a Gigabyte GA-P67A-UD5-B3 with a IT8728F=2C yesterday i u=
pgraded to Linux 3.3 and tested the new IT87 module.<br>As i will show belo=
w it shows wrong CPU temperature.<br><br>First:<br><br>temp1 shows system o=
r motherboard if you want.<br>temp2 shows ?=2C probably unused<br>temp3 sho=
ws CPU but is 7-8 degrees wrong compared to BIOS (I know that temp3 is CPU =
because it is the only temp value that differ under load)<br><br><br>BIOS a=
t this moment in time showed:<br>SYS 34=B0C<br>CPU 32=B0C<br><br><br>corete=
mp-isa-0000<br>Adapter: ISA adapter<br>Physical id 0:&nbsp=3B +36.0=B0C&nbs=
p=3B (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)<br>Core 0:&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +36.0=B0C&nbsp=3B (high =3D=
 +80.0=B0C=2C crit =3D +98.0=B0C)<br>Core 1:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +35.0=B0C&nbsp=3B (high =3D +80.0=B0C=
=2C crit =3D +98.0=B0C)<br>Core 2:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B +33.0=B0C&nbsp=3B (high =3D +80.0=B0C=2C crit =3D +=
98.0=B0C)<br>Core 3:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B +35.0=B0C&nbsp=3B (high =3D +80.0=B0C=2C crit =3D +98.0=B0C)<br=
><br>it8728-isa-0290<br>Adapter: ISA adapter<br>in0:&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +1.08 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +3.06 V)<br>in1:&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +2.03 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +3.06 V)<br>in2:&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +2.96 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +3.06 V)<br>in3:&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +2.93 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +3.06 V)<br>in4:&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +0.24 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +0.84 V)<br>in5:&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +1.20 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +3.06 V)<br>in6:&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +1.55 V&nbsp=3B (min =
=3D&nbsp=3B +0.00 V=2C max =3D&nbsp=3B +3.06 V)<br>3VSB:&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +3.38 V&nbsp=3B (min =3D&nbsp=
=3B +0.00 V=2C max =3D&nbsp=3B +6.12 V)<br>Vbat:&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +3.26 V &nbsp=3B<br>fan1:&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 1056 RPM&nbsp=3B (min =3D&nbsp=
=3B&nbsp=3B&nbsp=3B 0 RPM)<br>fan2:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 RPM&nbsp=3B (min =3D&nbsp=3B&nbs=
p=3B&nbsp=3B 0 RPM)<br>fan3:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 RPM&nbsp=3B (min =3D&nbsp=3B&nbsp=3B&=
nbsp=3B 0 RPM)<br>fan4:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B 0 RPM&nbsp=3B (min =3D&nbsp=3B&nbsp=3B&nbsp=3B=
 0 RPM)<br>fan5:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 13=
74 RPM&nbsp=3B (min =3D&nbsp=3B&nbsp=3B&nbsp=3B 0 RPM)<br>temp1:&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +34.0=B0C&nbsp=3B (low&nbsp=
=3B =3D +127.0=B0C=2C high =3D +127.0=B0C)&nbsp=3B sensor =3D thermistor<br=
>temp2:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +31.0=B0C&n=
bsp=3B (low&nbsp=3B =3D +127.0=B0C=2C high =3D +127.0=B0C)&nbsp=3B sensor =
=3D thermistor<br>temp3:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B +25.0=B0C&nbsp=3B (low&nbsp=3B =3D +127.0=B0C=2C high =3D +127.0=B0C)=
&nbsp=3B sensor =3D thermistor<br>intrusion0:&nbsp=3B ALARM<br><br><br><br>=
Conclusion:<br><br>fan1=2C shows correct value.<br>fan5=2C shows correct va=
lue.<br>temp1 (system)=2C shows correct value.<br>temp3 (CPU)=2C shows wron=
g value=2C in this case 25=B0C instead of 32=B0C.<br><br><br>I have studied=
 the other IT8278 reports i have found and as far as i can tell that they s=
uffer from the same wrong cpu readings=2C i do not understand why they have=
 reported them as correct...<br><br><br>Thanks in advance.<br><br>/Tomas<br=
> 		 	   		  </div></body>
</html>=

--_56eb3879-3d08-4f55-a45e-8630fd87b68e_--


--===============8401819533540708918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8401819533540708918==--
