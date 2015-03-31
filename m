From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 31 Mar 2015 13:56:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/2] i8k.c => dell-smm-hwmon.c
Message-Id: <20150331135601.GA8806@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
 <1427633859-18596-1-git-send-email-pali.rohar@gmail.com>
 <551A1554.3090005@roeck-us.net>
In-Reply-To: <551A1554.3090005@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Mar 30, 2015 at 08:32:36PM -0700, Guenter Roeck wrote:
> On 03/29/2015 05:57 AM, Pali Roh=E1r wrote:
> >This patch series moves drivers/char/i8k.c to drivers/hwmon/dell-smm-hwm=
on.c
> >and allows to compile hwmon driver without /proc/i8k file.
> >
> >Pali Roh=E1r (2):
> >   hwmon: Rename i8k driver to dell-smm-hwmon and move it to hwmon tree
> >   hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
> >
> >  MAINTAINERS                    |    4 +-
> >  arch/x86/Kconfig               |   25 +-
> >  drivers/char/Makefile          |    1 -
> >  drivers/char/i8k.c             | 1005 --------------------------------=
-------
> >  drivers/hwmon/Kconfig          |   11 +
> >  drivers/hwmon/Makefile         |    1 +
> >  drivers/hwmon/dell-smm-hwmon.c | 1025 ++++++++++++++++++++++++++++++++=
++++++++
> >  7 files changed, 1049 insertions(+), 1023 deletions(-)
> >  delete mode 100644 drivers/char/i8k.c
> >  create mode 100644 drivers/hwmon/dell-smm-hwmon.c
> >
> I am ok with the series and would take it for 4.1 if Greg agrees.
>=20
> Greg, any comments ?

Let me review it, it's in my queue...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
