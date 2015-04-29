From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 29 Apr 2015 12:07:56 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: Rename i8k driver to dell-smm-hwmon and move it to hwmon tree
Message-Id: <20150429120756.GA27947@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150428123850.GA8855@kroah.com>
 <1430307686-1734-1-git-send-email-pali.rohar@gmail.com>
In-Reply-To: <1430307686-1734-1-git-send-email-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Apr 29, 2015 at 01:41:25PM +0200, Pali Roh=E1r wrote:
> This commit moves i8k driver to hwmon tree under name dell-smm-hwmon whic=
h is
> better name then abbreviation i8k. For backward compatibility is added ma=
cro
> MODULE_ALIAS("i8k") so modprobe will load driver also old name i8k. CONFI=
G_I8K
> compile option was not changed.
>=20
> This commit also adds me as maintainer of this new dell-smm-hwmon driver =
and
> remove Guenter Roeck from list who is implicit maintainer all hwmon drive=
rs.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  MAINTAINERS                    |    4 +-
>  drivers/char/Makefile          |    1 -
>  drivers/char/i8k.c             | 1007 ----------------------------------=
-----
>  drivers/hwmon/Makefile         |    1 +
>  drivers/hwmon/dell-smm-hwmon.c | 1009 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 1012 insertions(+), 1010 deletions(-)
>  delete mode 100644 drivers/char/i8k.c
>  create mode 100644 drivers/hwmon/dell-smm-hwmon.c

In the future, please create patches with -M to show the file is moved,
which makes it much easier to review.

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
