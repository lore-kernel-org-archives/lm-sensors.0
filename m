From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jan 2012 13:44:37 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon/mc13xxx-adc: add support for the
Message-Id: <20120105144437.2dcad38d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317158169-25372-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Uwe,

On Tue, 27 Sep 2011 23:16:09 +0200, Uwe Kleine-K=F6nig wrote:
> Based on a patch by David Jander that mostly did s/mc13783/mc13xxx/
>=20
> Cc: David Jander <david.jander@protonic.nl>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> changes since (implicit) v1:
>  - update documentation
>  - undo driver renaming
>  - fix show_name callback (not 100% sure it is correct to give a differen=
t name
>    on mc13892. I think name contains the prefix documented in
>    Documentation/hwmon/mc13783-adc?!)
>  - implement some differences between mc13783 and mc13892 that I noticed =
when
>    updating the docs
>    - different scaling for bp channel
>    - no general purpose channels 8-15 on mc13892
>  - take over authorship as the patch got much more complicated now compar=
ed to
>    David's original.
>=20
>  Documentation/hwmon/mc13783-adc |   48 ++++++++++++----
>  drivers/hwmon/Kconfig           |    6 +-
>  drivers/hwmon/mc13783-adc.c     |  113 +++++++++++++++++++++++++++++----=
------
>  3 files changed, 123 insertions(+), 44 deletions(-)

What's the current state of this patch? Do you have a more recent
version that you would like to share? I would like to get this upstream
now so that your work doesn't get lost.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
