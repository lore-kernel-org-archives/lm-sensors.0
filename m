From: "Patrik Jakobsson" <patrik.jakobsson@home.se>
Date: Tue, 04 Jan 2011 14:00:07 +0000
Subject: [lm-sensors] Thermal zone driver for Intel US15W (aka Poulsbo)
Message-Id: <8B2C4C296C324A81A72BF93D6EC435F1@mail2world.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5573123906679861657=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============5573123906679861657==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0BB6_01CBABD4.A3497D70"
Content-Class: urn:content-classes:message

This is a multi-part message in MIME format.

------=_NextPart_000_0BB6_01CBABD4.A3497D70
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello

I have written a Linux kernel module for reading temperature from the
Intel US15W chip (aka Poulsbo). It is based on a bash script released
for the Fit-PC2. There is no documentation available so I'm not sure
what the register manipulation does. Also the readings are not very
accurate so I was hoping someone on this list could help me figure out
how this works so it can be improved.

The driver reads two sensor values from the host-bridge (0x8086:0x8100)
by some PCI config space magic, then converts it into celsius.

Driver can be found at:=20

https://github.com/patjak/fitpc2_tz

Any ideas are welcome

Thanks
Patrik Jakobsson



<P><p><font face=3D"Arial, Helvetica, sans-serif" size=3D"2" style=3D"font-=
size:13.5px">______________________________________________________________=
_<BR>Hitta k=E4rleken med hj=E4lp av v=E5rt matchningstest - <a href=3D"htt=
p://spray.matchaffinity.se/?mtcmk=3D614114">Klicka h=E4r!</a></font>
------=_NextPart_000_0BB6_01CBABD4.A3497D70
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
Hello<br>
<br>
I have written a Linux kernel module for reading temperature from the Intel US15W chip (aka Poulsbo). It is based on a bash script released for the Fit-PC2. There is no documentation available so I'm not sure what the register manipulation does. Also the readings are not very accurate so I was hoping someone on this list could help me figure out how this works so it can be improved.<br>
<br>
The driver reads two sensor values from the host-bridge (0x8086:0x8100) by some PCI config space magic, then converts it into celsius.<br>
<br>
Driver can be found at: <br>
<div>https://github.com/patjak/fitpc2_tz<br>
<br>
Any ideas are welcome<br>
<br>
Thanks<br>
Patrik Jakobsson<br>
</div>
</BODY></HTML>


<P><p><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR>Hitta k���rleken med hj���lp av v���rt matchningstest - <a href="http://spray.matchaffinity.se/?mtcmk=614114">Klicka h���r!</a></font>
------=_NextPart_000_0BB6_01CBABD4.A3497D70--



--===============5573123906679861657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5573123906679861657==--

