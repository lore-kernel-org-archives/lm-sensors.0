From: Allen Weiner <alweiner7@hotmail.com>
Date: Sun, 27 Feb 2011 22:23:16 +0000
Subject: [lm-sensors] IT8721 on Biostar motherboards
Message-Id: <BAY146-w28BC7C153ED76FE05A390CF7DF0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1525342570481971207=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1525342570481971207==
Content-Type: multipart/alternative;
	boundary="_e1fefabb-e1c6-4baf-ba28-a068ef8de66e_"

--_e1fefabb-e1c6-4baf-ba28-a068ef8de66e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I run Fedora 14 on a PC with a Biostar TA890FXE motherboard (Super I/O chip=
 ITE IT8721).

I installed the standalone LM-sensors driver for the ITE IT8721 chip. Howev=
er module IT87 will not load due to a conflict of I/O ports with ACPI.

For Asus motherboards using IT87xx chips=2C the workaround for getting sens=
ors data is to use an ACPI driver asus_atk0110.

Is there a similar workaround for getting sensors data available or being p=
lanned for Biostar motherboards using IT87xx chips?

(FWIW=2C it appears that the author of asus_atk0110=2C Luca Tettamanti=2C h=
as no affiliation with Asus.) 		 	   		  =

--_e1fefabb-e1c6-4baf-ba28-a068ef8de66e_
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
--></style>
</head>
<body class=3D'hmmessage'>
I run Fedora 14 on a PC with a Biostar TA890FXE motherboard (Super I/O chip=
 ITE IT8721).<br><br>I installed the standalone LM-sensors driver for the I=
TE IT8721 chip. However module IT87 will not load due to a conflict of I/O =
ports with ACPI.<br><br>For Asus motherboards using IT87xx chips=2C the wor=
karound for getting sensors data is to use an ACPI driver asus_atk0110.<br>=
<br>Is there a similar workaround for getting sensors data available or bei=
ng planned for Biostar motherboards using IT87xx chips?<br><br>(FWIW=2C it =
appears that the author of asus_atk0110=2C Luca Tettamanti=2C has no affili=
ation with Asus.) 		 	   		  </body>
</html>=

--_e1fefabb-e1c6-4baf-ba28-a068ef8de66e_--


--===============1525342570481971207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1525342570481971207==--
