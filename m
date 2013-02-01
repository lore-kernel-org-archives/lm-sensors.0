From: Vincent Palatin <vpalatin@chromium.org>
Date: Fri, 01 Feb 2013 22:03:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add device tree support
Message-Id: <CAP_ceTzVge0P_cUq5AFYRgrV78u1iQTzB7G5w=s=_a8548HtnA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1303636477929166451=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1359753502-13240-1-git-send-email-vpalatin@chromium.org>
In-Reply-To: <1359753502-13240-1-git-send-email-vpalatin@chromium.org>
To: lm-sensors@vger.kernel.org

--===============1303636477929166451==
Content-Type: multipart/alternative; boundary=14dae9340c0f3627eb04d4b0ecd9

--14dae9340c0f3627eb04d4b0ecd9
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 1, 2013 at 1:57 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Fri, 1 Feb 2013 13:36:40 -0800, Guenter Roeck wrote:
> > On Fri, Feb 01, 2013 at 01:18:22PM -0800, Vincent Palatin wrote:
> > > When the kernel has device tree support, we avoid doing the
> auto-detection
> > > as probing the busses might mess-up sensitive I2C devices or trigger
> long
> > > timeouts on non-functional busses.
> > (...)
> > As for the detect function, I am not entirely sure if we want or should
> get
> > rid of it just because OF is configured. That may have unintended side
> effects.
> > Either case, I would argue that if we do want to do that, it should be
> done
> > for _all_ I2C devices and not just for the lm90 driver. In other words,
> it
> > should be done in the I2C subsystem, maybe with a separate configuration
> option.
>
> I can't think of any reason for doing that. Detection only happens on
> I2C buses which request it (by setting i2c_adapter.class.) I2C system
> bus drivers for OF-based platforms would simply not set any class flag,
> so detection won't be triggered on them.
>
>
Thanks for the advice.

I will try update the i2c adapter driver ( i2c-s3c2410.c in my case) to
avoid hardcoding the class flags and maybe add some configuration depending
on a device tree node property.

-- 
Vincent

--14dae9340c0f3627eb04d4b0ecd9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Feb 1, 2013 at 1:57 PM, Jean Delvare <span dir=3D"ltr">&lt;=
<a href=3D"mailto:khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org<=
/a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Fri, 1 Feb 2013 13:36:40 -0800, Guent=
er Roeck wrote:<br>


&gt; On Fri, Feb 01, 2013 at 01:18:22PM -0800, Vincent Palatin wrote:<br>
</div><div class=3D"im">&gt; &gt; When the kernel has device tree support, =
we avoid doing the auto-detection<br>
&gt; &gt; as probing the busses might mess-up sensitive I2C devices or trig=
ger long<br>
&gt; &gt; timeouts on non-functional busses.<br>
</div>&gt; (...)<br>
<div class=3D"im">&gt; As for the detect function, I am not entirely sure i=
f we want or should get<br>
&gt; rid of it just because OF is configured. That may have unintended side=
 effects.<br>
&gt; Either case, I would argue that if we do want to do that, it should be=
 done<br>
&gt; for _all_ I2C devices and not just for the lm90 driver. In other words=
, it<br>
&gt; should be done in the I2C subsystem, maybe with a separate configurati=
on option.<br>
<br>
</div>I can&#39;t think of any reason for doing that. Detection only happen=
s on<br>
I2C buses which request it (by setting i2c_adapter.class.) I2C system<br>
bus drivers for OF-based platforms would simply not set any class flag,<br>
so detection won&#39;t be triggered on them.<br>
<span class=3D""><font color=3D"#888888"><br></font></span></blockquote><di=
v><br></div><div style>Thanks for the advice.</div><div style><br></div><di=
v style>I will try update the i2c adapter driver ( i2c-s3c2410.c in my case=
) to avoid hardcoding the class flags and maybe add some configuration depe=
nding on a device tree node property.</div>

<div style><br></div><div style>--=A0</div><div style>Vincent</div></div></=
div></div>

--14dae9340c0f3627eb04d4b0ecd9--


--===============1303636477929166451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1303636477929166451==--
