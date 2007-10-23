From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Tue, 23 Oct 2007 20:44:17 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <1719565594@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Juer, Jean,


> -----Urspr=FCngliche Nachricht-----
> Von: "Juerg Haefliger" <juergh@gmail.com>
> Gesendet: 18.10.07 06:53:47
> An: "Jean Delvare" <khali@linux-fr.org>
> CC: lm-sensors@lm-sensors.org
> Betreff: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!


>=20
> > >                                                                  That
> > > should definitely get retried. I can certainly do that at the dme1737
> > > level but I don't think that's the right place. Jean?
> >
> > Assuming that "busy" means that the nForce chip did not even attempt to
> > send the message (or lost arbitration, which is equivalent), this
> > specific error could be handled in i2c-nforce2, by retrying. The
> > problem is that you have to decide how many times you retry, and how
> > much time you wait between retries (there doesn't seem to be a way to
> > test if the SMBus is busy before trying, right?)
>=20
> The i2c-nforce2 driver already spins for 10 msecs before deciding to
> give up. I'd just retry once after that and see what happens.
>=20
> Juergen: Can you apply the attached patch and give it a whirl?
>=20


Since i applied the patch I got no more errors.

Juergen
______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!	=09
Jetzt testen! http://produkte.web.de/club/?mc=021130


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
