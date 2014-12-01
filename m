From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Dec 2014 16:22:32 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] i8k: Add support for Dell XPS 13
Message-Id: <20141201162232.GA23419@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417381240-7641-1-git-send-email-linux@roeck-us.net>
 <1417381240-7641-3-git-send-email-linux@roeck-us.net>
 <20141201133645.2a423043@endymion.delvare>
In-Reply-To: <20141201133645.2a423043@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <jdelvare@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, lm-sensors@lm-sensors.org

On Mon, Dec 01, 2014 at 01:36:45PM +0100, Jean Delvare wrote:
> On Sun, 30 Nov 2014 13:00:40 -0800, Guenter Roeck wrote:
> > XPS 13 does not support turbo speed, so its initialization data
> > matches that of XPS M140. Make XPS initialization data generic,
> > and add support for XPS 13.
> >=20
> > Cc: Pali Roh=E1r <pali.rohar@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---

[ ... ]
>=20
> Looks reasonable.
>=20
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>=20
Thanks a lot for the reviews!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
