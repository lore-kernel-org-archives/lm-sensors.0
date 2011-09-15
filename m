From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu, 15 Sep 2011 15:10:33 +0000
Subject: Re: [lm-sensors] [PATCH 0/6] mc13783 cleanup
Message-Id: <20110915151033.GD32263@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824132740.GA28197@pengutronix.de>
In-Reply-To: <20110824132740.GA28197@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

Hi Uwe,

On Wed, Aug 24, 2011 at 03:27:40PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> this series removes the long obsolte mc13783 API after fixing all
> remaining users.
>=20
> The patches touch many subsystems and have some interdependencies:
>=20
>  - patches 3 and 5 depend on patch 2
>  - patch 6 depends on patches 1-5
>=20
> So we have to think about how to merge them when everyone is OK that
> they are merged.
I am merging them, unless someone objects here.
I have applied all 6 patches now.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
