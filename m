From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sun, 21 Oct 2012 23:30:38 +0000
Subject: Re: [lm-sensors] [PATCH v2 8/8] hwmon: (it87) Manage device specific features with table
Message-Id: <CAAek22FuRmwBkNO0VV_KRnav5GhFFYR_N_cteBOeRWzhg7AZFA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3235436918701139930=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1350841995-5748-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1350841995-5748-9-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org

--===============3235436918701139930==
Content-Type: multipart/alternative; boundary=f46d043c823ce5bd2f04cc9a1f5b

--f46d043c823ce5bd2f04cc9a1f5b
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Oct 21, 2012 at 10:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> +
> +#define        FEAT_12MV_ADC           (1 << 0)
> +#define        FEAT_NEWER_AUTOPWM      (1 << 1)
> +#define        FEAT_OLD_AUTOPWM        (1 << 2)
>

Newer or older than what?  Would it make more sense to number these?  Gen1,
Gen2 or V1, V2 so that if yet another AUTOPWM mode/feature is added we
don't end up with "even_newer_autopwm"?

Just wondering,
Phil P.

--f46d043c823ce5bd2f04cc9a1f5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Oct 21, 2012 at 10:53 AM, Guenter Roeck =
<span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blan=
k">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
+<br><div class=3D"im">
+#define =A0 =A0 =A0 =A0FEAT_12MV_ADC =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 0)<br=
>
+#define =A0 =A0 =A0 =A0FEAT_NEWER_AUTOPWM =A0 =A0 =A0(1 &lt;&lt; 1)<br>
+#define =A0 =A0 =A0 =A0FEAT_OLD_AUTOPWM =A0 =A0 =A0 =A0(1 &lt;&lt; 2)<br><=
/div></blockquote><div><br>Newer or older than what?=A0 Would it make more =
sense to number these?=A0 Gen1, Gen2 or V1, V2 so that if yet another AUTOP=
WM mode/feature is added we don&#39;t end up with &quot;even_newer_autopwm&=
quot;?<br>
<br>Just wondering,<br>Phil P. <br></div></div>

--f46d043c823ce5bd2f04cc9a1f5b--


--===============3235436918701139930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3235436918701139930==--
