From: David Jander <david.jander@protonic.nl>
Date: Tue, 27 Sep 2011 06:44:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/mc13xxx-adc: add support for the
Message-Id: <20110927084441.47dea579@archvile>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 26 Sep 2011 18:08:39 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> On Mon, 26 Sep 2011 17:54:47 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Guenter,
> >=20
> > > renaming the file makes it technically impossible to review the chang=
es.
> > oh, I forgot to add -M to format-patch. I can resend when we agree on
> > renaming or not. But note that even then there are many hunks as I did
> > s/mc13783/mc13xxx/ in the driver.
>=20
> Please don't do that, it's pointless. Naming drivers and functions
> after the first supported device is a very common practice.
>=20
> > > Please refrain from it, and use the mechanism used for other hwmon
> > > drivers - add support for the new chip to the old driver, and referen=
ce
> > > the supported chips in Kconfig and the driver documentation.
> > Ah, I missed to rename Documentation/hwmon/mc13783-adc. Will update that
> > on v2.
> >=20
> > > Besides, the new name implies that all future MC13XXX chips would be
> > > supported by this driver, which seems to be a bit difficult to predic=
t.
> > hmm, but today mc13xxx is the best name we have. And I prefer a driver
> > named mc13xxx over mc13783 because when looking for a driver for the
> > mc13892 and seeing only mc13783-adc I'd assume it doesn't support
> > mc13892. OTOH if there is a mc13xxx-adc driver I'd look in more detail
>=20
> That's simply a wrong assumption from you.
>=20
> > if my chip is supported.
>=20
> With name mc13xxx-adc you'd have to check the details just the same, as
> you have no guarantee that the xxx's match the chip you have.

Yes, but from the filename you'd already have a hint. If you only know mc13=
892
and don't know that the mc13783 is an almost compatible part, you'd never f=
ind
the former was already supported.
OTOH, I know that many other drivers tend to have names reflecting the first
supported model of a family, so that is usual practice.
Personally I prefer the way of minimum impact, so I'd suggest the latter
solution to keep the name of the file and functions. For the MFD driver it =
is
a different story, since that driver contains code that is generic (mc13xxx)
and code that is specific to one or the other model (mc13892 or mc13783), so
the mc13xxx naming makes sense there to point out the differences.

Best regards,

--=20
David Jander
Protonic Holland.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
