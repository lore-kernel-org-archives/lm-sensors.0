From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 23 Jan 2012 09:01:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120123090101.GF14835@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean,

On Thu, Jan 05, 2012 at 02:44:37PM +0100, Jean Delvare wrote:
> Uwe,
>=20
> On Tue, 27 Sep 2011 23:16:09 +0200, Uwe Kleine-K=F6nig wrote:
> > Based on a patch by David Jander that mostly did s/mc13783/mc13xxx/
> >=20
> > Cc: David Jander <david.jander@protonic.nl>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > changes since (implicit) v1:
> >  - update documentation
> >  - undo driver renaming
> >  - fix show_name callback (not 100% sure it is correct to give a differ=
ent name
> >    on mc13892. I think name contains the prefix documented in
> >    Documentation/hwmon/mc13783-adc?!)
> >  - implement some differences between mc13783 and mc13892 that I notice=
d when
> >    updating the docs
> >    - different scaling for bp channel
> >    - no general purpose channels 8-15 on mc13892
> >  - take over authorship as the patch got much more complicated now comp=
ared to
> >    David's original.
> >=20
> >  Documentation/hwmon/mc13783-adc |   48 ++++++++++++----
> >  drivers/hwmon/Kconfig           |    6 +-
> >  drivers/hwmon/mc13783-adc.c     |  113 +++++++++++++++++++++++++++++--=
--------
> >  3 files changed, 123 insertions(+), 44 deletions(-)
>=20
> What's the current state of this patch? Do you have a more recent
> version that you would like to share? I would like to get this upstream
> now so that your work doesn't get lost.
no, there is no more recent version. If you're happy with the show_name
callback it can go in from my side. I didn't try if it still applies,
but I'd expect that only Kconfig could conflict and that should be easy
to resolve in case it does.

Thanks for your heads up,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
