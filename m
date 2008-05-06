From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 16:06:42 +0000
Subject: Re: [lm-sensors] Supermicro C2SBE
Message-Id: <20080506180642.31670f6b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <482054DE.1070005@dolbeau.org>
In-Reply-To: <482054DE.1070005@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 06 May 2008 17:59:18 +0200, Romain Dolbeau wrote:
> Jean Delvare wrote:
>=20
> > Can you include what this "nothing" looks like exactly? If that's all
> > zeroes, the chip is there but unused. If that's nothing at all, it
> > suggests that your version of libsensors is too old. Support for the
> > W83627DHG was added in lm-sensors 2.10.2.
>=20
> D*amn. Bitten by Debian again. Stable is (still) at 2.10.1 ...
>=20
> And the nothing is just nothing.
>=20
> > you need a recent version of sensors-detect:
>=20
> I think what I really need is some nice developer adding 2.10.6 to
> etch-backports :-) Unfortunately I don't have the time to do it
> myself... :-( (it's already difficult to justify with my boss spending
> time tweaking sensors.conf :-)

If anyone can do this I guess it would be Aur=E9lien (Cc'd.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
