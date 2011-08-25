From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Thu, 25 Aug 2011 07:57:19 +0000
Subject: Re: [lm-sensors] [PATCH 0/6] mc13783 cleanup
Message-Id: <20110825075719.GL16557@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824132740.GA28197@pengutronix.de>
 <201108250905.13168.philippe.retornaz@epfl.ch>
In-Reply-To: <201108250905.13168.philippe.retornaz@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Richard Purdie <rpurdie@rpsys.net>, kernel@pengutronix.de, Jean Delvare <khali@linux-fr.org>

On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R=E9tornaz wrote:
> Le mercredi 24 ao=FBt 2011 15:27:40, Uwe Kleine-K=F6nig a =E9crit :
> > Hello,
> >=20
> > this series removes the long obsolte mc13783 API after fixing all
> > remaining users.
>=20
> I posted a patch last month which was touching this MFD too.
> We will need to synchronize both patch.=20
Ah right. At one point I remembered your patch set because I wondered
that ..._USE_REGULATOR is still used.

Assuming all involved people are OK with both patch sets I can do the
merge of both patch sets.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
