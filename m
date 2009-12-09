From: Javier Zugasti <javier.zugasti@googlemail.com>
Date: Wed, 09 Dec 2009 16:12:12 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <2655c0a70912090812t6d3d606bod7dfe371b6f60a36@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2538448181843623520=="
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2538448181843623520==
Content-Type: multipart/alternative; boundary=0016e6db2dbb0af878047a4df44c

--0016e6db2dbb0af878047a4df44c
Content-Type: text/plain; charset=ISO-8859-1

Hi Jean,

2009/12/9 Jean Delvare <khali@linux-fr.org>

> Hi Javier,
>
> What about NOT TOP-POSTING, as I requested once already?
>
> On Wed, 9 Dec 2009 16:29:34 +0100, Javier Zugasti wrote:
> > Thank you very much for your reply Jean.
> > I patched the kernel tree with the patch you linked me to and then
> selected
> > the hwmon and lm73 option in the menuconfig options (together with the
> i2c
> > of course).
> >
> > After that I used a cross-compiler to compile the kernel for my board and
> > transferred the images to my board and started my linux there.
> >
> > I assume the system supports i2c now.
> > No i2c devices appear in the /dev directory or in /sys/bus/i2c/devices
>
> Which kernel are you running? I2C adapters only show
> in /sys/bus/i2c/devices since kernel 2.6.32. For older kernels you
> would look for them in /sys/class/i2c-adapter.
>
> Assuming you run an older kernel, please list the entries
> under /sys/class/i2c-adapter.
>
> I am using kernel 2.6.31, and there are no entries under
/sys/class/i2c-adapter:

*# ls /sys/class/i2c-*
/sys/class/i2c-adapter:

/sys/class/i2c-dev:

*

> , but
> > the lm73 appears in /sys/bus/i2c/drivers and i2c appears in the file
> > /proc/devices:
> >
> > cat /proc/devices
> > Character devices:
> > ...
> > *89 i2c*
> > ...
>
> This means i2c-dev is loaded, but you shouldn't need it, see below.
>
> > So now, how can I write an application in the user space that reads the
> > temperature from the lm73? Do I have to use IOCTL calls or how do I do
> it?
>
> With the lm73 driver you're using, access to the LM73 chip is done
> through sysfs, very easily. You would have to go through ioctls
> on /dev/i2c* nodes only if you did _not_ have a kernel driver for the
> LM73.
>
> OK. I'm going to go through the usage of sysfs and see how it goes. But I
guess it won't until the i2c-adapter appears, right?

> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Thank you,
Javier

--0016e6db2dbb0af878047a4df44c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Hi Jean,<br><br><div class=3D"gmail_quote">2009/12/9 Jean Delvare <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</=
a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1p=
x solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Javier,<br>
<br>
What about NOT TOP-POSTING, as I requested once already?<br>
<div class=3D"im"><br>
On Wed, 9 Dec 2009 16:29:34 +0100, Javier Zugasti wrote:<br>
&gt; Thank you very much for your reply Jean.<br>
&gt; I patched the kernel tree with the patch you linked me to and then sel=
ected<br>
&gt; the hwmon and lm73 option in the menuconfig options (together with the=
 i2c<br>
&gt; of course).<br>
&gt;<br>
&gt; After that I used a cross-compiler to compile the kernel for my board =
and<br>
&gt; transferred the images to my board and started my linux there.<br>
&gt;<br>
&gt; I assume the system supports i2c now.<br>
&gt; No i2c devices appear in the /dev directory or in /sys/bus/i2c/devices=
<br>
<br>
</div>Which kernel are you running? I2C adapters only show<br>
in /sys/bus/i2c/devices since kernel 2.6.32. For older kernels you<br>
would look for them in /sys/class/i2c-adapter.<br>
<br>
Assuming you run an older kernel, please list the entries<br>
under /sys/class/i2c-adapter.<br>
<div class=3D"im"><br></div></blockquote><div>I am using kernel 2.6.31, and=
 there are no entries under /sys/class/i2c-adapter:<br><br><i># ls /sys/cla=
ss/i2c-*=A0=A0=A0=A0=A0=A0 <br>/sys/class/i2c-adapter:<br><br>/sys/class/i2=
c-dev:<br>
<br></i> <br></div><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
"><div class=3D"im">
, but<br>
&gt; the lm73 appears in /sys/bus/i2c/drivers and i2c appears in the file<b=
r>
&gt; /proc/devices:<br>
&gt;<br>
&gt; cat /proc/devices<br>
&gt; Character devices:<br>
&gt; ...<br>
</div>&gt; *89 i2c*<br>
&gt; ...<br>
<br>
This means i2c-dev is loaded, but you shouldn&#39;t need it, see below.<br>
<div class=3D"im"><br>
&gt; So now, how can I write an application in the user space that reads th=
e<br>
&gt; temperature from the lm73? Do I have to use IOCTL calls or how do I do=
 it?<br>
<br>
</div>With the lm73 driver you&#39;re using, access to the LM73 chip is don=
e<br>
through sysfs, very easily. You would have to go through ioctls<br>
on /dev/i2c* nodes only if you did _not_ have a kernel driver for the<br>
LM73.<br>
<font color=3D"#888888"><br></font></blockquote><div>OK. I&#39;m going to g=
o through the usage of sysfs and see how it goes. But I guess it won&#39;t =
until the i2c-adapter appears, right?=A0 <br></div><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
<font color=3D"#888888">
--<br>
</font><div><div></div><div class=3D"h5">Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</div></div></blockquote></div><br>Thank you,<br>Javier<br>

--0016e6db2dbb0af878047a4df44c--


--===============2538448181843623520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2538448181843623520==--
