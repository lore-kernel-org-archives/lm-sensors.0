From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sat, 11 Feb 2012 20:15:13 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120211201513.GC14173@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327939078-4906-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1327939078-4906-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean,

On Fri, Feb 10, 2012 at 08:46:20PM +0100, Jean Delvare wrote:
> On Fri, 10 Feb 2012 11:47:36 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Feb 10, 2012 at 10:40:35AM +0100, Jean Delvare wrote:
> > > Hmm, this means that the touchscreen inputs are _never_ exposed for t=
he
> > > MC13892, even though the documentation says these inputs exist on that
> > > chip. Is this an oversight, or is there a good reason to not expose
> > > these inputs on the MC13892?
> >
> > No, that's correct. The mc13782's touchscreen inputs can be used for
> > touch (in that case they are not used in the mc13783-adc driver) or as
> > general purpose input (in which case mc13783_group_ts is used). For the
> > mc13892 the touch lines are dedicated for touch and there is no general
> > purpose functionallity, so on mc13892 mc13783_group_ts is never
> > instantiated.
>=20
> From the MC13892 datasheet:
>=20
> "TSX1 AND TSX2, TSY1 AND TSY2 (...)
>=20
> Touch Screen Interfaces X1 and X2, Y1 and Y2. The touch screen X plate
> is connected to TSX1 and TSX2, while the Y plate is connected to Y1 and
> Y2. **In inactive mode, these pins can also be used as general purpose
> ADC inputs.** They are respectively mapped on ADC channels 4, 5, 6, and
> 7. In interrupt mode, a voltage is applied to the X-plate (TSX2) via a
> weak current source to VCORE, while the Y-plate is connected to ground
> (TSY1)."
>=20
> So this doesn't seem to be fundamentally different from the MC13783, hm?
Hmm, it seems you're right and either my memory doesn't serve me right
or I never understood it correctly.

If you ask me it's OK to implement that when the first machine is using
that. And moreover I don't currently have a machine at hand with an
mc13892, so I couldn't test these inputs in an eventual v5 patch.

Is it OK for you to take the patch as is, too?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
