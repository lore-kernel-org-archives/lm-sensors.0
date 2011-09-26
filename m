From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 26 Sep 2011 15:54:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/mc13xxx-adc: add support for the
Message-Id: <20110926155447.GH20550@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Guenter,

> renaming the file makes it technically impossible to review the changes.
oh, I forgot to add -M to format-patch. I can resend when we agree on
renaming or not. But note that even then there are many hunks as I did
s/mc13783/mc13xxx/ in the driver.

> Please refrain from it, and use the mechanism used for other hwmon
> drivers - add support for the new chip to the old driver, and reference
> the supported chips in Kconfig and the driver documentation.
Ah, I missed to rename Documentation/hwmon/mc13783-adc. Will update that
on v2.

> Besides, the new name implies that all future MC13XXX chips would be
> supported by this driver, which seems to be a bit difficult to predict.
hmm, but today mc13xxx is the best name we have. And I prefer a driver
named mc13xxx over mc13783 because when looking for a driver for the
mc13892 and seeing only mc13783-adc I'd assume it doesn't support
mc13892. OTOH if there is a mc13xxx-adc driver I'd look in more detail
if my chip is supported.

So if you ask me, use the best name available today and think about the
best naming again when the next chip comes up that fits the naming
scheme but not the driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
