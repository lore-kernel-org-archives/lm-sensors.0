From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 10 Jun 2009 16:11:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix more __devexit_p glitches
Message-Id: <cfe85dfa0906100911yd9b24dchc207e7136a5117e1@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6010540873740151888=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20090604093041.442ad394@hyperion.delvare>
In-Reply-To: <20090604093041.442ad394@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============6010540873740151888==
Content-Type: multipart/alternative; boundary=0016367d6a3c94f741046c00bbad

--0016367d6a3c94f741046c00bbad
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Thu, Jun 4, 2009 at 1:30 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Make sure __devexit and devexit_p() match in all hwmon drivers.
> Suggested by a similar fix from Mike Frysinger.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/f71882fg.c |    2 +-
>  drivers/hwmon/sht15.c    |   10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> --- linux-2.6.30-rc8.orig/drivers/hwmon/f71882fg.c      2009-06-03
> 10:55:43.000000000 +0200
> +++ linux-2.6.30-rc8/drivers/hwmon/f71882fg.c   2009-06-04
> 09:02:47.000000000 +0200
> @@ -253,7 +253,7 @@ static struct platform_driver f71882fg_d
>                .name   = DRVNAME,
>        },
>        .probe          = f71882fg_probe,
> -       .remove         = __devexit_p(f71882fg_remove),
> +       .remove         = f71882fg_remove,
>  };
>


I think that one is reversed, certainly vs following.



> -               .remove = sht15_remove,
> +               .remove = __devexit_p(sht15_remove),
>
>

--0016367d6a3c94f741046c00bbad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jun 4, 2009 at 1:30 AM, Jean Del=
vare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linu=
x-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Make sure __devexit and devexit_p() match in all hwmon drivers.<br>
Suggested by a similar fix from Mike Frysinger.<br>
<br>
Signed-off-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali=
@linux-fr.org</a>&gt;<br>
Cc: Hans de Goede &lt;<a href=3D"mailto:hdegoede@redhat.com">hdegoede@redha=
t.com</a>&gt;<br>
Cc: Jonathan Cameron &lt;<a href=3D"mailto:jic23@cam.ac.uk">jic23@cam.ac.uk=
</a>&gt;<br>
---<br>
=A0drivers/hwmon/f71882fg.c | =A0 =A02 +-<br>
=A0drivers/hwmon/sht15.c =A0 =A0| =A0 10 +++++-----<br>
=A02 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
--- linux-2.6.30-rc8.orig/drivers/hwmon/f71882fg.c =A0 =A0 =A02009-06-03 10=
:55:43.000000000 +0200<br>
+++ linux-2.6.30-rc8/drivers/hwmon/f71882fg.c =A0 2009-06-04 09:02:47.00000=
0000 +0200<br>
@@ -253,7 +253,7 @@ static struct platform_driver f71882fg_d<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D DRVNAME,<br>
 =A0 =A0 =A0 =A0},<br>
 =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D f71882fg_probe,<br>
- =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(f71882fg_remove),<br>
+ =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D f71882fg_remove,<br>
=A0};<br>
</blockquote><div><br><br>I think that one is reversed, certainly vs follow=
ing.<br><br>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 .remove =3D sht15_remove,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .remove =3D __devexit_p(sht15_remove),<br><br=
>
 </blockquote></div><br>

--0016367d6a3c94f741046c00bbad--


--===============6010540873740151888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6010540873740151888==--
