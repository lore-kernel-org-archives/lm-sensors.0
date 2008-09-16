From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Sep 2008 17:32:08 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: add support for MAX1618 in MAX1619
Message-Id: <200809161932.08276.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080916133542.GA2072@www.tglx.de>
In-Reply-To: <20080916133542.GA2072@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Oh, BTW...

Le mardi 16 septembre 2008, Sebastian Siewior a =E9crit=A0:
> From: Tobias Himmer <tobias@himmer-online.de>
>=20
> The difference between MAX1619 and MAX1618 is that the latter has only one
> measurement register.
>=20
> Tested-by: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tobias Himmer <tobias@himmer-online.de>
> ---
> This patch was done by Tobias some time ago but he was not able to test
> it because of -ENODEV. I tested this against Linus' current tree. The
> last commit (of the max1618 driver) in linux-next of today is the same
> as in Linus' tree.
>=20
>  drivers/hwmon/Kconfig   |    5 +-
>  drivers/hwmon/max1619.c |  185 ++++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 129 insertions(+), 61 deletions(-)

Please update Documentation/hwmon/max1619 as well.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
