From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu, 15 Sep 2011 15:12:13 +0000
Subject: Re: [lm-sensors] [PATCH 0/6] mc13783 cleanup
Message-Id: <20110915151213.GE32263@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824132740.GA28197@pengutronix.de>
 <201108250905.13168.philippe.retornaz@epfl.ch>
In-Reply-To: <201108250905.13168.philippe.retornaz@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, kernel@pengutronix.de, linux-input@vger.kernel.org

Hi Philippe,

On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R=E9tornaz wrote:
> Le mercredi 24 ao=FBt 2011 15:27:40, Uwe Kleine-K=F6nig a =E9crit :
> > Hello,
> >=20
> > this series removes the long obsolte mc13783 API after fixing all
> > remaining users.
>=20
> I posted a patch last month which was touching this MFD too.
> We will need to synchronize both patch.=20
I applied Uwe's patchset now. Could you please sync your code and send me a
patchset that applies on top of:

git://git.infradead.org/users/sameo/mfd-2.6.git for-next

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
