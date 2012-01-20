From: George Joseph <george.joseph@fairview5.com>
Date: Fri, 20 Jan 2012 15:58:17 +0000
Subject: Re: [lm-sensors] [PATCH 15/82] hwmon: (asc7621) Fix multi-line comments
Message-Id: <CAHKv19BcGk6xpdVfMq+_-6X1HHp315ofTPrMLKnWNwUG6pQtUA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-16-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-16-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jan 19, 2012 at 4:55 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Cc: George Joseph <george.joseph@fairview5.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> =A0drivers/hwmon/asc7621.c | =A0 =A08 +++++---
> =A01 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
> index 3efd324..7caa242 100644
> --- a/drivers/hwmon/asc7621.c
> +++ b/drivers/hwmon/asc7621.c
> @@ -268,9 +268,11 @@ static ssize_t store_fan16(struct device *dev,
> =A0 =A0 =A0 =A0if (kstrtol(buf, 10, &reqval))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 /* If a minimum RPM of zero is requested, then we set the r=
egister to
> - =A0 =A0 =A0 =A0 =A00xffff. This value allows the fan to be stopped comp=
letely without
> - =A0 =A0 =A0 =A0 =A0generating an alarm. */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If a minimum RPM of zero is requested, then we set the=
 register to
> + =A0 =A0 =A0 =A0* 0xffff. This value allows the fan to be stopped comple=
tely without
> + =A0 =A0 =A0 =A0* generating an alarm.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0reqval =3D
> =A0 =A0 =A0 =A0 =A0 =A0(reqval <=3D 0 ? 0xffff : SENSORS_LIMIT(5400000 / =
reqval, 0, 0xfffe));
>
> --
> 1.7.5.4
>

Acked-by: George Joseph <george.joseph@fairview5.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
