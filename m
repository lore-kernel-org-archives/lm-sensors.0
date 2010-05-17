From: Ray Lee <ray-lk@madrabbit.org>
Date: Mon, 17 May 2010 15:59:50 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <AANLkTilRvyWK-SEp2pgVAosaJ8GQUbbXsP4BkZBxGphU@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4026650323522204578=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
In-Reply-To: <1272518506.24542.163.camel@pasglop>
To: lm-sensors@vger.kernel.org

--===============4026650323522204578==
Content-Type: multipart/alternative; boundary=0016363b90ecc4f0b80486cc5151

--0016363b90ecc4f0b80486cc5151
Content-Type: text/plain; charset=UTF-8

On Thu, Apr 29, 2010 at 3:56 PM, Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> Now, maybe the best option is to have instead:
>
>        fan[1-*]_discrete_value
>                Discrete value
>                RW
>
>        fan[1-*]_supported values
>                List of supported discrete values
>                RO
>

Perhaps a granularity (ie, step-size) instead of a full list of values?

--0016363b90ecc4f0b80486cc5151
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Apr 29, 2010 at 3:56 PM, Benjamin Herren=
schmidt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing.org">b=
enh@kernel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex;">

Now, maybe the best option is to have instead:<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0fan[1-*]_discrete_value<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Discrete value<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RW<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0fan[1-*]_supported values<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0List of supported d=
iscrete values<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RO<br></blockquote>=
<div><br></div><div>Perhaps a granularity (ie, step-size) instead of a full=
 list of values?</div></div>

--0016363b90ecc4f0b80486cc5151--


--===============4026650323522204578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4026650323522204578==--
