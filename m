From: Javier Zugasti <javier.zugasti@googlemail.com>
Date: Wed, 09 Dec 2009 16:39:33 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <2655c0a70912090839o3037c6bl71ee1e8a59f43913@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5792045370902807583=="
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5792045370902807583==
Content-Type: multipart/alternative; boundary=0016e6d9746edf36ff047a4e55e5

--0016e6d9746edf36ff047a4e55e5
Content-Type: text/plain; charset=ISO-8859-1

Hi

2009/12/9 Jean Delvare <khali@linux-fr.org>

> Hi Javier,
>
> On Wed, 9 Dec 2009 17:12:12 +0100, Javier Zugasti wrote:
> > 2009/12/9 Jean Delvare <khali@linux-fr.org>
> > > With the lm73 driver you're using, access to the LM73 chip is done
> > > through sysfs, very easily. You would have to go through ioctls
> > > on /dev/i2c* nodes only if you did _not_ have a kernel driver for the
> > > LM73.
> > >
> > > OK. I'm going to go through the usage of sysfs and see how it goes. But
> I
> > guess it won't until the i2c-adapter appears, right?
>
> Correct. You have to figure out why your I2C adapter isn't
> instantiated. This isn't exactly on-topic on this mailing list...
>
> You claim you'd use i2c-imx, how do you know? Did you actually build
> that driver? If it is modular, did you load the module?  Which machine
> model are you using? i2c-imx is a platform driver, so the i2c-imx
> device must be instantiated explicitly by the machine init code.
>
> Well, in the I2C support from menuconfig I selected the following options:

<*> I2C support --->
      <*> I2C device interface
              I2C Hardware Bus Support --->
                   <*> IMX I2C interface

Should I just select I2C support and then use sysfs as you suggested before?
Could this be the reason why my I2C adapter isn't
instantiated?


> If you can't figure it out, it might be better to ask on list dedicated
> to arm or even imx if there's one.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Thanks,
Javier

--0016e6d9746edf36ff047a4e55e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br><div class=3D"gmail_quote">2009/12/9 Jean Delvare <span dir=3D"lt=
r">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</sp=
an><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Javier,<br>
<div class=3D"im"><br>
On Wed, 9 Dec 2009 17:12:12 +0100, Javier Zugasti wrote:<br>
&gt; 2009/12/9 Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali=
@linux-fr.org</a>&gt;<br>
</div><div class=3D"im">&gt; &gt; With the lm73 driver you&#39;re using, ac=
cess to the LM73 chip is done<br>
&gt; &gt; through sysfs, very easily. You would have to go through ioctls<b=
r>
&gt; &gt; on /dev/i2c* nodes only if you did _not_ have a kernel driver for=
 the<br>
&gt; &gt; LM73.<br>
&gt; &gt;<br>
&gt; &gt; OK. I&#39;m going to go through the usage of sysfs and see how it=
 goes. But I<br>
&gt; guess it won&#39;t until the i2c-adapter appears, right?<br>
<br>
</div>Correct. You have to figure out why your I2C adapter isn&#39;t<br>
instantiated. This isn&#39;t exactly on-topic on this mailing list...<br>
<br>
You claim you&#39;d use i2c-imx, how do you know? Did you actually build<br=
>
that driver? If it is modular, did you load the module? =A0Which machine<br=
>
model are you using? i2c-imx is a platform driver, so the i2c-imx<br>
device must be instantiated explicitly by the machine init code.<br>
<br></blockquote><div>Well, in the I2C support from menuconfig I selected t=
he following options:<br><br>&lt;*&gt; I2C support ---&gt;<br>=A0=A0=A0=A0=
=A0 &lt;*&gt; I2C device interface<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 I2C Hardware Bus Support ---&gt;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &lt;*&gt; IMX I2C in=
terface<br><br>Should I just select I2C support and then use sysfs as you s=
uggested before?<br>Could this be the reason why my I2C adapter isn&#39;t<b=
r>
instantiated?<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
If you can&#39;t figure it out, it might be better to ask on list dedicated=
<br>
to arm or even imx if there&#39;s one.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</div></div></blockquote></div><br>Thanks,<br>Javier<br>

--0016e6d9746edf36ff047a4e55e5--


--===============5792045370902807583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5792045370902807583==--
