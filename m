From: Agile Aspect <agile.aspect@gmail.com>
Date: Sun, 24 Aug 2008 00:42:57 +0000
Subject: Re: [lm-sensors] it8705: nonsense temperature readings
Message-Id: <48B0AE91.30706@GMail.COM>
List-Id: <lm-sensors.vger.kernel.org>
References: <942859.11386.qm@web26403.mail.ukl.yahoo.com>
In-Reply-To: <942859.11386.qm@web26403.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Incidentally, if you have rack mounted computers in a computer room
with centralized air conditioning, then it's highly likely you have cold
and hot spots in the computer room.

Hence, the assumption that thermostat temperature should be equal
to the computer temperature may not be valid.

Hector Lahoz Gra=F1ena wrote:
> Hello
> I've been interested for some time in power management and ACPI.
> Well, I've come to the conclusion that the first step to achieve power ma=
nagement
> and (most important) a silent computer is good temperature readings. So I=
 had a look
> and I found that the reading was completely meaningless. The CPU temperat=
ure showed
> 20 degrees Celsius 1 min. after power-on, when the room temperature was 2=
5.
> I got the datasheet of the it8705 (not a real specification, but is all I=
 have) and
> found 3 registers called "thermal diode zero degree adjustment". I also f=
ound that
> the driver (version 2.6.24.2) does not use them. I've been playing around=
 with theese
> registers but I don't know which is the correct value to store there. I s=
uppose it
> depends on the diode used. The motherboard is a Biostar P4VTB.
> I wonder iwhether the chip could be connected to tne internal diode of the
> Pentium 4 or is it an external one on the motherboard. Really, the manufa=
cturers
> don't give much information. I wouldn't need it if they did things the ri=
ght way.
>
> i don't mean to achieve a lab accurate reading, but currently it is usele=
ss.
> If you could help me in some extent I would really appreciate it.
>
>
> __________________________________________________
> Correo Yahoo!
> Espacio para todos tus mensajes, antivirus y antispam =A1gratis!=20
> Reg=EDstrate ya - http://correo.yahoo.es=20
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>  =20


--=20
Article. VI. Clause 3 of the constitution of the United States states:=20

"The Senators and Representatives before mentioned, and the Members of=20
the several State Legislatures, and all executive and judicial Officers,=20
both of the United States and of the several States, shall be bound by=20
Oath or Affirmation, to support this Constitution; but no religious Test=20
shall ever be required as a Qualification to any Office or public Trust=20
under the United States."=20



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
