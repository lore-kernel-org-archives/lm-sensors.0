From: Sasikanth babu <sasikanth.v19@gmail.com>
Date: Wed, 13 Jun 2012 16:34:02 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <CAOJFanVcE==i8eCETzOumQmLpHJ0XsWJWv+7yLUcSRZFLXeHxQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5601045881094041380=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5601045881094041380==
Content-Type: multipart/alternative; boundary=047d7b10cc9bc1033b04c25cfbcc

--047d7b10cc9bc1033b04c25cfbcc
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 13, 2012 at 9:35 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 13 Jun 2012 06:51:32 -0700, Guenter Roeck wrote:
> > I suspect it requires additional patches to work. Jean might know.
> > fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 seems relevant, and there may
> be others,
> > even infrastructure changes.
>
> fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 is certainly relevant too,
> yes. I can't think of anything else, but that was long ago, so I could
> miss something else.
>
> > Can you switch to a more recent kernel ?
>
> This would seem reasonable, yes, 2.6.34 is getting very old and
> unsupported, and it did not even support I2C multiplexing so I take it
> that you already did a fair amount of backport to get to the kernel
> you're currently running. No real surprise you get into trouble...
>
> --
> Jean Delvare
>


Yes, as you had mentioned we just backported I2c mux support.
I planning to use
linux-2.6.39.4.tar.bz2<http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.4.tar.bz2>kernel
(Since I cant go to 3.x kernels for now).
Is that version is fine with I2c mux devices or do I have to go with 3.x
kernels.?

Thanks
Sasi

--047d7b10cc9bc1033b04c25cfbcc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote">On Wed, Jun 13, 2012 at 9:35 PM=
, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" =
target=3D"_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<div class=3D"im">On Wed, 13 Jun 2012 06:51:32 -0700, Guenter Roeck wrote:<=
br>
&gt; I suspect it requires additional patches to work. Jean might know.<br>
&gt; fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 seems relevant, and there may=
 be others,<br>
&gt; even infrastructure changes.<br>
<br>
</div>fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 is certainly relevant too,<b=
r>
yes. I can&#39;t think of anything else, but that was long ago, so I could<=
br>
miss something else.<br>
<div class=3D"im"><br>
&gt; Can you switch to a more recent kernel ?<br>
<br>
</div>This would seem reasonable, yes, 2.6.34 is getting very old and<br>
unsupported, and it did not even support I2C multiplexing so I take it<br>
that you already did a fair amount of backport to get to the kernel<br>
you&#39;re currently running. No real surprise you get into trouble...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br><br>Yes, as you had mentioned we just =
backported I2c mux support. <br>I planning to use=A0 <a href=3D"http://www.=
kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.4.tar.bz2">linux-2.6.39.4.tar=
.bz2</a> kernel (Since I cant go to 3.x kernels for now). <br>
Is that version is fine with I2c mux devices or do I have to go with 3.x ke=
rnels.?<br><br>Thanks<br>Sasi<br></div>

--047d7b10cc9bc1033b04c25cfbcc--


--===============5601045881094041380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5601045881094041380==--
