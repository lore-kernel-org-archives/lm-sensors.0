From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Mon, 01 Apr 2013 11:18:39 +0000
Subject: Re: [lm-sensors] [PATCH v7 5/5] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <CAJLyvQzV5=16savZE5-jm2-JDqxopekVRBcaKOT7Vwa-010L2w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8164622333819347034=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1364368412-12810-6-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364368412-12810-6-git-send-email-hongbo.zhang@linaro.org>
To: lm-sensors@vger.kernel.org

--===============8164622333819347034==
Content-Type: multipart/alternative; boundary=14dae93d8c0668050504d94ac856

--14dae93d8c0668050504d94ac856
Content-Type: text/plain; charset=ISO-8859-1

On 1 April 2013 03:59, Anton Vorontsov <anton@enomsg.org> wrote:

> On Sat, Mar 30, 2013 at 04:27:26PM -0700, Guenter Roeck wrote:
> > > > > Each of ST-Ericsson X500 chip set series consists of both ABX500
> and DBX500
> > > > > chips. This is ABX500 hwmon driver, where the abx500.c is a common
> layer for
> > > > > all ABX500s, and the ab8500.c is specific for AB8500 chip. Under
> this designed
> > > > > structure, other chip specific files can be added simply using the
> same common
> > > > > layer abx500.c.
> > > > >
> > > > > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> > > >
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > Thanks a lot for your reviews, Guenter!
> > >
> > > Guenter, Jean,
> > >
> > > As the driver depends on the battery driver changes, do you mind if I
> take
> > > it via battery-2.6.git tree?
> >
> > Ok with me. I actually assumed it would be merged through another tree
> because
> > of its dependencies.
>
> Great, thanks a lot!
>
> Hongbo, so can you please rebase the patches onto battery-2.6.git[1] tree
> so
> that I could apply them?
>
> Anton,
I will rebase it, and send it out at Wednesday (due to my time slot
limitation).
Thanks.


> Thanks,
>
> Anton
>
> [1] http://git.infradead.org/battery-2.6.git
>

--14dae93d8c0668050504d94ac856
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 1 April 2013 03:59, Anton Vorontsov <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:anton@enomsg.org" target=3D"_blank">anton@enomsg.org</a>&gt;</s=
pan> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Sat, Mar 30, 2013 at 04=
:27:26PM -0700, Guenter Roeck wrote:<br>
&gt; &gt; &gt; &gt; Each of ST-Ericsson X500 chip set series consists of bo=
th ABX500 and DBX500<br>
&gt; &gt; &gt; &gt; chips. This is ABX500 hwmon driver, where the abx500.c =
is a common layer for<br>
&gt; &gt; &gt; &gt; all ABX500s, and the ab8500.c is specific for AB8500 ch=
ip. Under this designed<br>
&gt; &gt; &gt; &gt; structure, other chip specific files can be added simpl=
y using the same common<br>
&gt; &gt; &gt; &gt; layer abx500.c.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Hongbo Zhang &lt;<a href=3D"mailto:hongb=
o.zhang@linaro.org">hongbo.zhang@linaro.org</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Reviewed-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck=
-us.net">linux@roeck-us.net</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks a lot for your reviews, Guenter!<br>
&gt; &gt;<br>
&gt; &gt; Guenter, Jean,<br>
&gt; &gt;<br>
&gt; &gt; As the driver depends on the battery driver changes, do you mind =
if I take<br>
&gt; &gt; it via battery-2.6.git tree?<br>
&gt;<br>
&gt; Ok with me. I actually assumed it would be merged through another tree=
 because<br>
&gt; of its dependencies.<br>
<br>
</div>Great, thanks a lot!<br>
<br>
Hongbo, so can you please rebase the patches onto battery-2.6.git[1] tree s=
o<br>
that I could apply them?<br>
<br></blockquote><div>Anton,</div><div style>I will rebase it, and send it =
out at=A0Wednesday (due to my time slot limitation).</div><div style>Thanks=
.</div><div style>=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Thanks,<br>
<br>
Anton<br>
<br>
[1] <a href=3D"http://git.infradead.org/battery-2.6.git" target=3D"_blank">=
http://git.infradead.org/battery-2.6.git</a><br>
</blockquote></div><br></div></div>

--14dae93d8c0668050504d94ac856--


--===============8164622333819347034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8164622333819347034==--
