From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: W83L785TS-S
Message-Id: <20030809142559.04147194.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809120646.541e35a3.khali@linux-fr.org>
In-Reply-To: <20030809120646.541e35a3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> yes it's supported but if I had known I would not have started it.=20
> It's the sensor the A7N8X COP feature works on, it's not supported by
> Asus probe and I understand why by now :)
>=20
> acording to all the posts and mails:
>=20
> 1) W83L785TS_S shows diode temp  Asus 1 shows case , Asus 2 shows
> socket 2) W83L785TS_S diode shows diode temp Asus 1 shows case , Asus
> 2 shows socket
> 3) W83L785TS_S shows diode temp  Asus 2 shows case , Asus 1 shows
> socket 4) W83L785TS_S diode shows diode temp Asus 2 shows case , Asus
> 4 shows socket

I'm not sure I understand why you differenciate "W83L785TS_S" and
"W83L785TS_S diode". There's a single temperature measured by the
W83L785TS_S anyway, or did I miss something?

> some board needs a reboot if switching between diode and normal
> readout ??!! very version (and if I have to believe a few users) bios
> dependend

OK, so I defintely missed something. To me, the thermal diode vs.
thermistor is something the BIOS should set, matching the way the
hardware manufacturer designed and wired the board. That's something I
would better leave untouched.

> also it will timeout on the smbus, returning 0c, I am not sure if this
> is a conflict with the bios reading it or not, I just know my smbus
> codes times out.  To solves this, and I am NOT happy with it, I added
> a simple line for this sensor that if it's 0 then give it the previous
> value.  I logged this a while with a few users and it happens avarage
> about 2 times every 5 minutes, sometimes an hour nothing then a few
> almost in a row

We could see the same things on some dumps contributed by one user. See
there for the whole thread:
http://www.nforcershq.com/forum/viewtopic.php?t#918&sid=8E6f3b6d097334d2c10=
5967163817e83
The important thing is that occasionally, reading from the chip would
fail for that user (resulting in XX on the dump, instead of the value).
Another user seems never to suffer from that (but a couple of shots may
not be enough to conclude).

> also as for detection it has the same ID as the W83L785TR so you never
> know what you have :)  right now if I have no other primary sensor
> chip I asume it's a W83L785TR, if I already have a primary then it
> probably is a W83L785TS.

I don't have a datasheet for the W83L785TR. I could find one for the
W83L785R, and fortunately it has a different ID (50h instead of 70h).

> by now if people have problems with it (and I only know of the A7N8X
> using it) I simply reply to search the forum and to remember there is
> a reason asus probe does not support it

OK, I think I'll write a very simple driver (simply reporting the value
of register 27h, no more). I won't even add support to our library and
tools, just the driver.

BTW you didn't really answer my question. Do you use the registers 53h
and 85h in any way?

Thanks.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
