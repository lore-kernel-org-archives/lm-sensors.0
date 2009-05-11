From: "Mr. Tux" <tuxoholic@hotmail.de>
Date: Mon, 11 May 2009 08:07:30 +0000
Subject: [lm-sensors] 5VSB computing on it87
Message-Id: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2072864528467187153=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2072864528467187153==
Content-Type: multipart/alternative;
	boundary="_c577d23b-4142-4881-85ec-b7719edca8f8_"

--_c577d23b-4142-4881-85ec-b7719edca8f8_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi list

My Foxconn A7GM-S keep showing the wrong Voltage of 5VSB sensor.

This one shows up in BIOS as well=2C so it is connected and should indicate=
 about 5.02V

But 'sensors' with it87 module loaded keeps showing 6.85V - how to change t=
he compute
line in order to get the 5.02V?

At the moment the compute line is the default:

compute in7  ((6.8/10)+1)*@ =2C @/((6.8/10)+1)

thanks and regards

Mr Tux


_________________________________________________________________
http://redirect.gimas.net/?n=3DM0905xWLHM2
Unbegrenzter Speicher bei Windows Live Hotmail!=

--_c577d23b-4142-4881-85ec-b7719edca8f8_
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
Hi list<br><br>My Foxconn A7GM-S keep showing the wrong Voltage of 5VSB sen=
sor.<br><br>This one shows up in BIOS as well=2C so it is connected and sho=
uld indicate about 5.02V<br><br>But 'sensors' with it87 module loaded keeps=
 showing 6.85V - how to change the compute<br>line in order to get the 5.02=
V?<br><br>At the moment the compute line is the default:<br><br>compute in7=
&nbsp=3B ((6.8/10)+1)*@ =2C @/((6.8/10)+1)<br><br>thanks and regards<br><br=
>Mr Tux<br><br><br /><hr />Kein Werbe-Blabla -  <a href=3D'http://redirect.=
gimas.net/?n=3DM0905FTP_SpringCampaign1' target=3D'_new'>hier klicken!</a><=
/body>
</html>=

--_c577d23b-4142-4881-85ec-b7719edca8f8_--


--===============2072864528467187153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2072864528467187153==--
