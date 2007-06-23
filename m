From: Nicolas Boichat <nicolas@boichat.ch>
Date: Sat, 23 Jun 2007 10:07:22 +0000
Subject: Re: [lm-sensors] Fw: [PATCH] applesmc - switch to using
Message-Id: <467CF0DA.9070309@boichat.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

Jean Delvare wrote:
> Hi Nicolas,
>=20
> Forwarding this one to you as Dmitry says his mails to you are bouncing
> back.
>=20
> Thanks.
>=20
> ----- Message Transf=E9r=E9 -----
>=20
> Date: Fri, 25 May 2007 00:41:00 -0400
> De: Dmitry Torokhov <dtor@insightbb.com>
> =C0: lm-sensors@lm-sensors.org
> Cc: khali@linux-fr.org, Andrew Morton <akpm@linux-foundation.org>,       =
 Nicolas Boichat <nicolas@boichat.ch>
> Sujet: [PATCH] applesmc - switch to using input-polldev
>=20
>=20
> Not tested - no hardware...

I finally got a chance to test it, and it works.

> Dmitry
>
> HWMON: applesmc - convert to use input-polldev.
>
> Switch to using input-polldev skeleton instead of implementing
> polling loop by itself. This also fixes problem with trylock
> on a mutex in atomic context.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>

Best regards,

Nicolas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
