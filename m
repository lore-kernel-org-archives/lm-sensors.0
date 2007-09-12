From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Wed, 12 Sep 2007 13:27:19 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <1606388921@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> -----Urspr=FCngliche Nachricht-----
> Von: "Juerg Haefliger" <juergh@gmail.com>
> Gesendet: 08.09.07 15:41:35
> An: "Juergen Bausa" <Juergen.Bausa@web.de>
> CC: lm-sensors@lm-sensors.org
> Betreff: Re: [lm-sensors] dme1737 module

>=20
> The contents of the temperature registers match the output of sensors,
> so it's not a conversion/display issue. The dme1737 does advertise the
> measured temp as 16C. The only thing that's left is that the CPU diode
> is not a 3904-type diode and the dme1737 gets the calculation wrong.
> It wants to see a 3904 diode attached to its remote diode pins. If you
> want closure, you need to check the docs for your CPU.
>=20

So the actual sensor is on the cpu and the processing is done on the board?

Is processing done by the bios or by dme1737?

The type of my cpu  is very new.  At boot up, the bios displays "unknown=20
cpu type". So, this might be the reason why it does not know how to handle =

the sensor output. If this is true, next bios revision might solve the prob=
lem.

Is this correct?

Juergen
______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!	=09
Jetzt testen! http://produkte.web.de/club/?mc=021130


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
