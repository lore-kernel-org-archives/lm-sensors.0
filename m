From: Parag Warudkar <parag.lkml@gmail.com>
Date: Mon, 17 Sep 2012 21:38:17 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <CAOULuObzLdp3Hq-v48Z2sfFXibPfUNrD6HdAPO6P=5ufBY2Vow@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9065347472210078987=="
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1209151834120.2271@ubuntu>
In-Reply-To: <alpine.DEB.2.02.1209151834120.2271@ubuntu>
To: lm-sensors@vger.kernel.org

--===============9065347472210078987==
Content-Type: multipart/alternative; boundary=0015175cb92a7f97b404c9ec9747

--0015175cb92a7f97b404c9ec9747
Content-Type: text/plain; charset=ISO-8859-1

On Monday, September 17, 2012, Henrik Rydberg <rydberg@euromail.se> wrote:
>> Any better/other ideas ? Is the problem that we have to increase the
wait time,
>> or is something else going on ?
>
> No, it makes sense now that I got the right number of zeroes. ;-)
>
> So, to be explicit, this is the patch I would like to go in. It is
> completely safe, back-portable, and a no-brainer. Parag, are you ok
> with being the author on this one?
>

I am OK with the proposed timeout as it works for me. I'll add an

Tested-by: Parag Warudkar <parag.lkml@gmail.com>

Thanks :)

Parag
> Thanks,
> Henrik
>
> From 868fc42edcb3a338ce0a0334e2dc50b01a7f6844 Mon Sep 17 00:00:00 2001
> From: Parag Warudkar <parag.lkml@gmail.com>
> Date: Mon, 17 Sep 2012 17:49:55 +0200
> Subject: [PATCH] applesmc: Bump max wait
>
> A heavy-load test on a MacBookPro6,1 is still showing a substantial
> amount of read errors.  Increasing the maximum wait time to 128 ms
> resolves the issue.
>
> maybe-Signed-off-by: Parag Warudkar <parag.lkml@gmail.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hwmon/applesmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 2827088..8f3f6f2 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -53,10 +53,10 @@
>
>  #define APPLESMC_MAX_DATA_LENGTH 32
>
> -/* wait up to 32 ms for a status change. */
> +/* wait up to 128 ms for a status change. */
>  #define APPLESMC_MIN_WAIT      0x0010
>  #define APPLESMC_RETRY_WAIT    0x0100
> -#define APPLESMC_MAX_WAIT      0x8000
> +#define APPLESMC_MAX_WAIT      0x20000
>
>  #define APPLESMC_READ_CMD      0x10
>  #define APPLESMC_WRITE_CMD     0x11
> --
> 1.7.12
>
>

--0015175cb92a7f97b404c9ec9747
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, September 17, 2012, Henrik Rydberg &lt;<a href=3D"mailto=
:rydberg@euromail.se">rydberg@euromail.se</a>&gt; wrote:<br>&gt;&gt; Any be=
tter/other ideas ? Is the problem that we have to increase the wait time,<b=
r>
&gt;&gt; or is something else going on ?<br>&gt;<br>&gt; No, it makes sense=
 now that I got the right number of zeroes. ;-)<br>&gt;<br>&gt; So, to be e=
xplicit, this is the patch I would like to go in. It is<br>&gt; completely =
safe, back-portable, and a no-brainer. Parag, are you ok<br>
&gt; with being the author on this one?<br>&gt;<br><br>I am OK with the pro=
posed timeout as it works for me. I&#39;ll add an<br><br>Tested-by: Parag W=
arudkar &lt;<a href=3D"mailto:parag.lkml@gmail.com">parag.lkml@gmail.com</a=
>&gt;<br>
<br>Thanks :)<br><br>Parag<br>&gt; Thanks,<br>&gt; Henrik<br>&gt;<br>&gt; F=
rom 868fc42edcb3a338ce0a0334e2dc50b01a7f6844 Mon Sep 17 00:00:00 2001<br>&g=
t; From: Parag Warudkar &lt;<a href=3D"mailto:parag.lkml@gmail.com">parag.l=
kml@gmail.com</a>&gt;<br>
&gt; Date: Mon, 17 Sep 2012 17:49:55 +0200<br>&gt; Subject: [PATCH] applesm=
c: Bump max wait<br>&gt;<br>&gt; A heavy-load test on a MacBookPro6,1 is st=
ill showing a substantial<br>&gt; amount of read errors. =A0Increasing the =
maximum wait time to 128 ms<br>
&gt; resolves the issue.<br>&gt;<br>&gt; maybe-Signed-off-by: Parag Warudka=
r &lt;<a href=3D"mailto:parag.lkml@gmail.com">parag.lkml@gmail.com</a>&gt;<=
br>&gt; Signed-off-by: Henrik Rydberg &lt;<a href=3D"mailto:rydberg@euromai=
l.se">rydberg@euromail.se</a>&gt;<br>
&gt; ---<br>&gt; =A0drivers/hwmon/applesmc.c | 4 ++--<br>&gt; =A01 file cha=
nged, 2 insertions(+), 2 deletions(-)<br>&gt;<br>&gt; diff --git a/drivers/=
hwmon/applesmc.c b/drivers/hwmon/applesmc.c<br>&gt; index 2827088..8f3f6f2 =
100644<br>
&gt; --- a/drivers/hwmon/applesmc.c<br>&gt; +++ b/drivers/hwmon/applesmc.c<=
br>&gt; @@ -53,10 +53,10 @@<br>&gt;<br>&gt; =A0#define APPLESMC_MAX_DATA_LE=
NGTH 32<br>&gt;<br>&gt; -/* wait up to 32 ms for a status change. */<br>&gt=
; +/* wait up to 128 ms for a status change. */<br>
&gt; =A0#define APPLESMC_MIN_WAIT =A0 =A0 =A00x0010<br>&gt; =A0#define APPL=
ESMC_RETRY_WAIT =A0 =A00x0100<br>&gt; -#define APPLESMC_MAX_WAIT =A0 =A0 =
=A00x8000<br>&gt; +#define APPLESMC_MAX_WAIT =A0 =A0 =A00x20000<br>&gt;<br>=
&gt; =A0#define APPLESMC_READ_CMD =A0 =A0 =A00x10<br>
&gt; =A0#define APPLESMC_WRITE_CMD =A0 =A0 0x11<br>&gt; --<br>&gt; 1.7.12<b=
r>&gt;<br>&gt;

--0015175cb92a7f97b404c9ec9747--


--===============9065347472210078987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9065347472210078987==--
