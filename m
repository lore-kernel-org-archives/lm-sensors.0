From: PHP Nut <phpnut@live.com>
Date: Sun, 25 Aug 2013 15:51:25 +0000
Subject: [lm-sensors] Taking action based upon sensors
Message-Id: <BLU173-W194E5678B7B93E08C63033A4480@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5156150472245814804=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5156150472245814804==
Content-Type: multipart/alternative;
	boundary="_5d6d1bdc-ee25-494b-9576-d408d71990c9_"

--_5d6d1bdc-ee25-494b-9576-d408d71990c9_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Is there any explicitly supported method to execute specified actions based=
 upon the value of a sensor output exceeding a threshold or equaling a cert=
ain state?

What I'm looking for is a way to use sensord or a similar daemon based on l=
m-sensors to execute a command when a condition is met=2C such as the tempe=
rature exceeding a certain threshold. This could be done with a separate da=
emonized or scheduled log monitor=2C however that is a bit clunky=2C anothe=
r item to debug=2C a waste of resources=2C and another undocumented interop=
 to fail upon a package upgrade.

If there isn't=2C what's the best method for doing this and are there exist=
ing log watching/parsing scripts which have been thoroughly debugged? I'd l=
ike to avoid anything homebrew if at all possible.
 		 	   		  =

--_5d6d1bdc-ee25-494b-9576-d408d71990c9_
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
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Is there any explicitly supporte=
d method to execute specified actions based upon the value of a sensor outp=
ut exceeding a threshold or equaling a certain state?<br><br>What I'm looki=
ng for is a way to use sensord or a similar daemon based on lm-sensors to e=
xecute a command when a condition is met=2C such as the temperature exceedi=
ng a certain threshold. This could be done with a separate daemonized or sc=
heduled log monitor=2C however that is a bit clunky=2C another item to debu=
g=2C a waste of resources=2C and another undocumented interop to fail upon =
a package upgrade.<br><br>If there isn't=2C what's the best method for doin=
g this and are there existing log watching/parsing scripts which have been =
thoroughly debugged? I'd like to avoid anything homebrew if at all possible=
.<br> 		 	   		  </div></body>
</html>=

--_5d6d1bdc-ee25-494b-9576-d408d71990c9_--


--===============5156150472245814804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5156150472245814804==--
