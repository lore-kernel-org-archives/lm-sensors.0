From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 28 Apr 2015 12:38:50 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <20150428123850.GA8855@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
 <1427633859-18596-1-git-send-email-pali.rohar@gmail.com>
 <1427633859-18596-3-git-send-email-pali.rohar@gmail.com>
In-Reply-To: <1427633859-18596-3-git-send-email-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sun, Mar 29, 2015 at 02:57:39PM +0200, Pali Roh=E1r wrote:
> This patch splits CONFIG_I8K compile option to SENSORS_DELL_SMM and CONFI=
G_I8K.
> Option SENSORS_DELL_SMM is now used to enable compilation of dell-smm-hwm=
on
> driver and old CONFIG_I8K option to enable /proc/i8k interface in driver.
>=20
> So this change allows to compile dell-smm-hwmon driver without legacy /pr=
oc/i8k
> interface which is needed only for old Dell Inspirion models or for users=
pace
> i8kutils package.
>=20
> For backward compatibility when CONFIG_I8K is enabled then also SENSORS_D=
ELL_SMM
> is enabled and so driver dell-smm-hwmon (with /proc/i8k) is compiled.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  arch/x86/Kconfig               |   25 +++----
>  drivers/hwmon/Kconfig          |   11 +++
>  drivers/hwmon/Makefile         |    2 +-
>  drivers/hwmon/dell-smm-hwmon.c |  150 ++++++++++++++++++++++------------=
------
>  4 files changed, 106 insertions(+), 82 deletions(-)

This doesn't apply to 4.1-rc1, so I can't apply this series now.  Can
you respin it and resend?

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
