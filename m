From: =?iso-8859-1?Q?Hector_Lahoz_Gra=F1ena?= <hectorlahoz@yahoo.es>
Date: Sun, 24 Aug 2008 00:02:41 +0000
Subject: [lm-sensors] it8705: nonsense temperature readings
Message-Id: <942859.11386.qm@web26403.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello
I've been interested for some time in power management and ACPI.
Well, I've come to the conclusion that the first step to achieve power mana=
gement
and (most important) a silent computer is good temperature readings. So I h=
ad a look
and I found that the reading was completely meaningless. The CPU temperatur=
e showed
20 degrees Celsius 1 min. after power-on, when the room temperature was 25.
I got the datasheet of the it8705 (not a real specification, but is all I h=
ave) and
found 3 registers called "thermal diode zero degree adjustment". I also fou=
nd that
the driver (version 2.6.24.2) does not use them. I've been playing around w=
ith theese
registers but I don't know which is the correct value to store there. I sup=
pose it
depends on the diode used. The motherboard is a Biostar P4VTB.
I wonder iwhether the chip could be connected to tne internal diode of the
Pentium 4 or is it an external one on the motherboard. Really, the manufact=
urers
don't give much information. I wouldn't need it if they did things the righ=
t way.

i don't mean to achieve a lab accurate reading, but currently it is useless.
If you could help me in some extent I would really appreciate it.


__________________________________________________
Correo Yahoo!
Espacio para todos tus mensajes, antivirus y antispam =A1gratis!=20
Reg=EDstrate ya - http://correo.yahoo.es=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
