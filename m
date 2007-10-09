From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Tue, 09 Oct 2007 19:41:10 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <1681366284@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> -----Urspr=FCngliche Nachricht-----
> Von: "Juerg Haefliger" <juergh@gmail.com>
>=20
> > Juerg, you could patch i2c-nforce2 to return more useful error codes.
> > Such a patch could go upstream. Alternatively, building the i2c-nforce2
> > driver with CONFIG_I2C_DEBUG_BUS=3Dy may provide some hints.
>=20
> I was thinking of doing that. First I have to try to recreate the
> problem on my machine.
>=20
> Juergen: Do you feel like recompiling i2c_nforce2 with debugging enabled?
>=20

This would require compiling a single module and exchanging it against the =
default=20
debian module? Then ist no problem. Is it ok to use the debian sources (2.6=
.18-5-k7)?
And how to turn on debugging?

Juergen
_______________________________________________________________________
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
