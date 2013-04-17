From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 17 Apr 2013 10:08:31 +0000
Subject: Re: [lm-sensors] [PATCH v8 5/5] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <CAJLyvQwhrX7uJ7mmNAWfQiDubsZV2tJnfj6h40WZUKCQztOmwQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1513852790310837380=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1364991492-2421-6-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364991492-2421-6-git-send-email-hongbo.zhang@linaro.org>
To: lm-sensors@vger.kernel.org

--===============1513852790310837380==
Content-Type: multipart/alternative; boundary=001a11c26222033ebd04da8bab8f

--001a11c26222033ebd04da8bab8f
Content-Type: text/plain; charset=ISO-8859-1

Anton and Guenter, thanks a lot.


On 17 April 2013 09:32, Anton Vorontsov <anton@enomsg.org> wrote:

> On Wed, Apr 03, 2013 at 09:31:55AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 03, 2013 at 08:18:12PM +0800, Hongbo Zhang wrote:
> > > Each of ST-Ericsson X500 chip set series consists of both ABX500 and
> DBX500
> > > chips. This is ABX500 hwmon driver, where the abx500.c is a common
> layer for
> > > all ABX500s, and the ab8500.c is specific for AB8500 chip. Under this
> designed
> > > structure, other chip specific files can be added simply using the
> same common
> > > layer abx500.c.
> > >
> > > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> Patches 1-5 applied, thanks a lot!
>
> Anton
>

--001a11c26222033ebd04da8bab8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Anton and Guenter, thanks a lot.</span><br><div class=3D"gmail_extra"><br=
><br><div class=3D"gmail_quote">On 17 April 2013 09:32, Anton Vorontsov <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:anton@enomsg.org" target=3D"_blank">an=
ton@enomsg.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, Apr 03, 2013 at 09:31:55AM -0700, Guenter Roeck wrote:<br>
&gt; On Wed, Apr 03, 2013 at 08:18:12PM +0800, Hongbo Zhang wrote:<br>
&gt; &gt; Each of ST-Ericsson X500 chip set series consists of both ABX500 =
and DBX500<br>
&gt; &gt; chips. This is ABX500 hwmon driver, where the abx500.c is a commo=
n layer for<br>
&gt; &gt; all ABX500s, and the ab8500.c is specific for AB8500 chip. Under =
this designed<br>
&gt; &gt; structure, other chip specific files can be added simply using th=
e same common<br>
&gt; &gt; layer abx500.c.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Hongbo Zhang &lt;<a href=3D"mailto:hongbo.zhang@li=
naro.org">hongbo.zhang@linaro.org</a>&gt;<br>
&gt;<br>
&gt; Acked-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">linu=
x@roeck-us.net</a>&gt;<br>
<br>
</div></div>Patches 1-5 applied, thanks a lot!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Anton<br>
</font></span></blockquote></div><br></div></div>

--001a11c26222033ebd04da8bab8f--


--===============1513852790310837380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1513852790310837380==--
