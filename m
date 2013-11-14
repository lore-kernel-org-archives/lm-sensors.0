From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Nov 2013 19:33:05 +0000
Subject: Re: [lm-sensors] NCT6106D: strange VIN max behaviour (nct6775)
Message-Id: <20131114203305.5223c424@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <250339793.65111.1384443406161.open-xchange@app04.ox.hosteurope.de>
In-Reply-To: <250339793.65111.1384443406161.open-xchange@app04.ox.hosteurope.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 14 Nov 2013 10:58:37 -0800, Guenter Roeck wrote:
> On Thu, Nov 14, 2013 at 04:36:46PM +0100, Bj=F6rn Gerhart wrote:
> > Hi,
> >=20
> > I'm about to test the new NCT6106D part of the Nuvoton nct6775 driver.
> > However, I experience a strange behaviour concerning the maximum
> > thresholds of in1 (wiring: +5V at chip's VIN0, 15/10 resistor ratio) and
> > in4 (wiring: +12V at chip's VIN1, 110/22 ratio). The behaviour is as
> > follows:
>=20
> Those scaling factors don't really work. VIN0 and VIN1 have a maximum
> input range of 2.048V. With your scaling factors you don't really get
> to the limits you are trying to set. Maximum for 5V is 2.048 * 2.5 =3D 5.=
12V,
> and maximum for 12V is 2.048*6 =3D 12.228V. So, in practice, what you see
> is that the ADCs for both inputs are maxed out, which also explains
> why you can not set the maximum higher than the actual voltage.
>=20
> If this is a third-party board, you may be out of luck. If this is your
> own board, you might want to select different resistor ratios.
> Something like 20/10 and 150/22 should work better, for example.

FWIW, chip vendors usually recommend aiming at 3/4 of the scale for the
nominal value, which is a good balance between resolution and range.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
