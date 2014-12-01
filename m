From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Dec 2014 20:15:36 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] i8k: Rework error retries
Message-Id: <20141201201536.GA28914@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417381240-7641-1-git-send-email-linux@roeck-us.net>
 <1417381240-7641-2-git-send-email-linux@roeck-us.net>
 <201412012045.59404@pali>
In-Reply-To: <201412012045.59404@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Dec 01, 2014 at 08:45:59PM +0100, Pali Roh=E1r wrote:
> On Sunday 30 November 2014 22:00:39 Guenter Roeck wrote:
> > Instead of returning a previous value if the SMM code returns
> > an error when trying to read a temperature, retry once.
> > If that fails again, return -ENODATA. Also return -ENODATA if
> > an attempt is made to read the GPU temperature but the GPU is
> > currently turned off.
> >=20
> > Drop the I8K_TEMPERATURE_BUG definition and handle the related
> > bug unconditionally.
> >=20
> > Cc: Pali Roh=E1r <pali.rohar@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Applies on top of Pali's patch series.
> >=20
> >  drivers/char/i8k.c | 47
> > ++++++++++++++++++++++++----------------------- 1 file
> > changed, 24 insertions(+), 23 deletions(-)
> >=20
>=20
> Working fine GPU temp (turned on or off).
>=20
> Tested-by: Pali Roh=E1r <pali.rohar@gmail.com>
>=20
Thanks a lot for testing!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
