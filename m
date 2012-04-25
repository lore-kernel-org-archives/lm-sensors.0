From: "Mr. Tux" <tuxoholic@hotmail.de>
Date: Wed, 25 Apr 2012 07:18:38 +0000
Subject: [lm-sensors] (no subject)
Message-Id: <BLU120-W29660EFAF104596DF3DBA6D8270@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3229219275264998921=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200703231349.l2NDnj1q025087@whb1.seed.net.tw>
In-Reply-To: <200703231349.l2NDnj1q025087@whb1.seed.net.tw>
To: lm-sensors@vger.kernel.org

--===============3229219275264998921==
Content-Type: multipart/alternative;
	boundary="_91b74683-1401-4865-b272-ef9974a5c235_"

--_91b74683-1401-4865-b272-ef9974a5c235_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi list

How can I set sensor limits to an Asus m4a89gtd pro usb3 board using Debian=
/Squeeze?

The sensors output looks reasonable (compared to the BIOS values) . What I'=
m missing is critical limits
for the fan speeds in case of  0 RPM.

I forced the chassis fan to stop=2C got 0 RPM but no ALARM output. I assume=
 the crit value is missing. Usually I set this in a /etc/sensors.d/<configf=
ile>

Now this fails=2C because sensors3.conf does not show an entry for atk0110-=
* and I can't create one myself that is successfully parsed by sensors -s -=
c <configfile>

~$ sensors --version
sensors version 3.1.2 with libsensors version 3.1.2

~$ uname -r
2.6.32-5-686

~$ sensors

k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +15.0=B0C  (high =3D +70.0=B0C=2C crit =3D +90.0=B0C) =20

atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +1.07 V  (min =3D  +0.80 V=2C max =3D  +1.60 V)
+3.3V Voltage:      +3.29 V  (min =3D  +2.97 V=2C max =3D  +3.63 V)
+5V Voltage:        +4.97 V  (min =3D  +4.50 V=2C max =3D  +5.50 V)
+12V Voltage:      +12.07 V  (min =3D +10.20 V=2C max =3D +13.80 V)
CPU Fan Speed:     1537 RPM  (min =3D  600 RPM)
Chassis Fan Speed:    1467 RPM  (min =3D  600 RPM)
Chassis2 Fan Speed:   0 RPM  (min =3D  600 RPM)
Power Fan Speed:      0 RPM  (min =3D  600 RPM)
CPU Temperature:    +24.0=B0C  (high =3D +60.0=B0C=2C crit =3D +95.0=B0C) =
=20
MB Temperature:     +23.0=B0C  (high =3D +45.0=B0C=2C crit =3D +75.0=B0C) =
=20


Should I rebuild libsensors / try a newer kernel / create the config file i=
n a different way?

What's the right thing to do here?
 		 	   		  =

--_91b74683-1401-4865-b272-ef9974a5c235_
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
Hi list<br><br>How can I set sensor limits to an Asus m4a89gtd pro usb3 boa=
rd using Debian/Squeeze?<br><br>The sensors output looks reasonable (compar=
ed to the BIOS values) . What I'm missing is critical limits<br>for the fan=
 speeds in case of&nbsp=3B 0 RPM.<br><br>I forced the chassis fan to stop=
=2C got 0 RPM but no ALARM output. I assume the crit value is missing. Usua=
lly I set this in a /etc/sensors.d/&lt=3Bconfigfile&gt=3B<br><br>Now this f=
ails=2C because sensors3.conf does not show an entry for atk0110-* and I ca=
n't create one myself that is successfully parsed by sensors -s -c &lt=3Bco=
nfigfile&gt=3B<br><br>~$ sensors --version<br>sensors version 3.1.2 with li=
bsensors version 3.1.2<br><br>~$ uname -r<br>2.6.32-5-686<br><br>~$ sensors=
<br><br>k10temp-pci-00c3<br>Adapter: PCI adapter<br>temp1:&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +15.0=B0C&nbsp=3B (high =3D +70.0=B0C=2C cr=
it =3D +90.0=B0C)&nbsp=3B <br><br>atk0110-acpi-0<br>Adapter: ACPI interface=
<br>Vcore Voltage:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +1.07 V&nbsp=3B =
(min =3D&nbsp=3B +0.80 V=2C max =3D&nbsp=3B +1.60 V)<br>+3.3V Voltage:&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +3.29 V&nbsp=3B (min =3D&nbsp=3B +2.97 =
V=2C max =3D&nbsp=3B +3.63 V)<br>+5V Voltage:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B +4.97 V&nbsp=3B (min =3D&nbsp=3B +4.50 V=2C max=
 =3D&nbsp=3B +5.50 V)<br>+12V Voltage:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B +12.07 V&nbsp=3B (min =3D +10.20 V=2C max =3D +13.80 V)<br>CPU Fan Spee=
d:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 1537 RPM&nbsp=3B (min =3D&nbsp=3B 600 RP=
M)<br>Chassis Fan Speed:&nbsp=3B&nbsp=3B&nbsp=3B 1467 RPM&nbsp=3B (min =3D&=
nbsp=3B 600 RPM)<br>Chassis2 Fan Speed:&nbsp=3B&nbsp=3B 0 RPM&nbsp=3B (min =
=3D&nbsp=3B 600 RPM)<br>Power Fan Speed:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B 0 RPM&nbsp=3B (min =3D&nbsp=3B 600 RPM)<br>CPU Temperature:&nbsp=3B&n=
bsp=3B&nbsp=3B +24.0=B0C&nbsp=3B (high =3D +60.0=B0C=2C crit =3D +95.0=B0C)=
&nbsp=3B <br>MB Temperature:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B +23.0=B0C&nbsp=
=3B (high =3D +45.0=B0C=2C crit =3D +75.0=B0C)&nbsp=3B <br><br><br>Should I=
 rebuild libsensors / try a newer kernel / create the config file in a diff=
erent way?<br><br>What's the right thing to do here?<br> 		 	   		  </div><=
/body>
</html>=

--_91b74683-1401-4865-b272-ef9974a5c235_--


--===============3229219275264998921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3229219275264998921==--
