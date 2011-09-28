From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 14:17:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <20110928161740.172c098a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 28 Sep 2011 19:27:37 +0530, R, Durgadoss wrote:
> Hi Jean,
>=20
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Sent: Wednesday, September 28, 2011 7:20 PM
> > To: R, Durgadoss
> > Cc: LM Sensors; Yu, Fenghua; Alexander Stein
> > Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660 =
support
> >=20
> > On Wed, 28 Sep 2011 18:54:58 +0530, R, Durgadoss wrote:
> > > Yes. It's the same for all Medfield based Atom products.
> > > And it cannot be read from MSR_TEMPERATURE_TARGET.
> > > So, we have to add the model name in the driver.
> > > Currently I have added a OR inside the 'if' in adjust_tjmax Function.
> > >
> > > if (c->x86_model =3D 0x1c || c->x86_model =3D 0x27) {
> > >
> > > This fetches me 90 and I have confirmed it with the Hardware folks he=
re..
> >=20
> > Oh, BTW, there is magic in this block to adjust tjmax based on the
> > north bridge. Is there any such magic possible for Atom model 0x26?
>=20
> I guess this is not needed now, since we know the tjmax is 90 for 0x26.

Not always. As discussed earlier, the E660T has TjMax =3D 110=B0C. If this
was the only exception, it's documented now so we'd me mostly fine. But
apparently all "T" variants of the Atom E6x0 have TjMax =3D 110=B0C. It
would be really nice to have a way to set tjmax =3D 110000 in the driver
for them, even if this is only a heuristic.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
