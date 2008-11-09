From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Nov 2008 20:47:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081109214705.3e9114ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

Thanks for your comments.

On Sun, 26 Oct 2008 21:18:42 -0400, Jean-Marc Spaggiari wrote:
> Sound like a good idea to me
>=20
> For those values:
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +26 C
> Core1 Temp:  +24 C
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +17=B0C
> Core1 Temp:  +25=B0C
>=20
> I think they are correct. In winter, I place my computer outside
> (-10C/-15C). The idle core temp can be pretty low.

They can be correct, but the fact is that we can't be certain (that's
more or less the definition of a heuristic.) Maybe these machines had
working diodes and were in a very cool environment. Or maybe these
machines had broken diodes and were in a very hot environment.

> So it's important
> to give the user a way to force the sensor activation or adjust the
> temperatures level for the heuristic.

Definitely, yes.

> So in this statement:
> * Average of the 4 sensors is below 15 degrees C.
> * Minimum of the 4 sensors is below 5 degrees C
>=20
> The user need to be able to update 15 and 5.

This was part of my original proposal :) Either that of a boolean
option to simply force the driver to bind.

> Also, since in all examples the average temperature is lower than 15
> degrees C (-4,75;  -15,25; -6,25; 3; 5,75) I will recommand to put it
> closer to 10 degrees C.

You forgot the first entry in the list:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +17 C
Core0 Temp:   +3 C
Core1 Temp:  +21 C
Core1 Temp:   +5 C

That one has an average temperature of 11.5 degrees C, so a limit of 10
degrees C would consider it good - which it clearly isn't. That being
said, there's no perfect limit, so maybe it is OK if the above is
considered OK by the driver even if I'm certain it isn't.

OTOH, the above is an interesting case. What strikes me here is not the
temperature values themselves but the difference between them which is
pretty unrealistic. So maybe this can be another check in the heuristic.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
