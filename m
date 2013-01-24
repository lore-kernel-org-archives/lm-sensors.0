From: Robert Smith <rs.porsche@gmail.com>
Date: Thu, 24 Jan 2013 09:17:17 +0000
Subject: [lm-sensors] tap SMBus vis PCI slot?
Message-Id: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2885506938084611732=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2885506938084611732==
Content-Type: multipart/alternative; boundary=f46d043c06442882be04d4054873

--f46d043c06442882be04d4054873
Content-Type: text/plain; charset=ISO-8859-1

I am interested in connecting my arduino to my motherboard's SMBus and I
read the 'Hardware Hacking' web page here:

http://www.lm-sensors.org/wiki/HardwareHacking

It occurred to me that the SMBus pins are routed to the PCI slot pins
A40/A41, so I figured it should be possible to modify a PCI riser card and
use this to access the SMBus.

Just wondering if anyone has any experience to share regarding this as it
wasn't mentioned as a possibility on the Hardware page it seems that it
would be a lot simpler than modifying a DIMM since you can get riser cards
which use ribbon cables.

FYI, with the Arduino I would like to create a PID fan controller which can
access the motherboard sensors directly. It would also be able to
control/read the motherboard's built in fan controller as well as control
additional PWM fans, at least that's the idea.

I hope to also be able to configure the arduino from the PC via the SMBus
and possibly feed it cpu load information if that is useful in controlling
the fans... probably not necessary with the PID controller. It could be
useful to be able to switch between different cooling profiles.

--f46d043c06442882be04d4054873
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am interested in connecting my arduino to my motherboard=
&#39;s SMBus and I read the &#39;Hardware Hacking&#39; web page here:<div><=
br></div><div><a href=3D"http://www.lm-sensors.org/wiki/HardwareHacking">ht=
tp://www.lm-sensors.org/wiki/HardwareHacking</a><br>

</div><div><br></div><div style>It occurred to me that the SMBus pins are r=
outed to the PCI slot pins A40/A41, so I figured it should be possible to m=
odify a PCI riser card and use this to access the SMBus.</div><div style>

<br></div><div style>Just wondering if anyone has any experience to share r=
egarding this as it wasn&#39;t mentioned as a possibility on the Hardware p=
age it seems that it would be a lot simpler than modifying a DIMM since you=
 can get riser cards which use ribbon cables.</div>

<div style><br></div><div style>FYI, with the Arduino I would like to creat=
e a PID fan controller which can access the motherboard sensors directly. I=
t would also be able to control/read the motherboard&#39;s built in fan con=
troller as well as control additional PWM fans, at least that&#39;s the ide=
a.</div>

<div style><br></div><div style>I hope to also be able to configure the ard=
uino from the PC via the SMBus and possibly feed it cpu load information if=
 that is useful in controlling the fans... probably not necessary with the =
PID controller. It could be useful to be able to switch between different c=
ooling profiles.</div>

</div>

--f46d043c06442882be04d4054873--


--===============2885506938084611732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2885506938084611732==--
