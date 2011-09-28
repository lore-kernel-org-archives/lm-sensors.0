From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 13:37:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <20110928153704.28797169@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 28 Sep 2011 18:54:58 +0530, R, Durgadoss wrote:
> > > 0x27 (Medfield Atom) and TjMax 90
> >=20
> > I can add it, no problem. Is TjMax the same for all Medfield-based Atom
> > CPUs? If so, and if it can't be read from MSR_TEMPERATURE_TARGET, then
> > this value shouldn't go in the documentation file but in the driver,
> > unless the fragile heuristic we have already comes to that conclusion
> > (it's so complex that honestly I can't tell.)
>=20
> Thanks Jean.
> Yes. It's the same for all Medfield based Atom products.
> And it cannot be read from MSR_TEMPERATURE_TARGET.
> So, we have to add the model name in the driver.
> Currently I have added a OR inside the 'if' in adjust_tjmax Function.
>=20
> if (c->x86_model =3D 0x1c || c->x86_model =3D 0x27) {
>=20
> This fetches me 90 and I have confirmed it with the Hardware folks here.

OK, I'll do this. What about model 0x26? Wouldn't 90=B0C be a better
default for them too?

And please tell your hardware friends to implement
MSR_TEMPERATURE_TARGET in future Atom product lines, it makes our life
so much easier...

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
