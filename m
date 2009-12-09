From: Javier Zugasti <javier.zugasti@googlemail.com>
Date: Wed, 09 Dec 2009 15:29:34 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <2655c0a70912090729x52207547rd0379af83ec7f1ad@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8222275713461610508=="
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8222275713461610508==
Content-Type: multipart/alternative; boundary=0016e6db2dbb9ea5fd047a4d5b4d

--0016e6db2dbb9ea5fd047a4d5b4d
Content-Type: text/plain; charset=ISO-8859-1

Hi people,

Thank you very much for your reply Jean.
I patched the kernel tree with the patch you linked me to and then selected
the hwmon and lm73 option in the menuconfig options (together with the i2c
of course).

After that I used a cross-compiler to compile the kernel for my board and
transferred the images to my board and started my linux there.

I assume the system supports i2c now.
No i2c devices appear in the /dev directory or in /sys/bus/i2c/devices, but
the lm73 appears in /sys/bus/i2c/drivers and i2c appears in the file
/proc/devices:

cat /proc/devices
Character devices:
...
*89 i2c*
...

So now, how can I write an application in the user space that reads the
temperature from the lm73? Do I have to use IOCTL calls or how do I do it?

Thanks again for your help and excuse my ignorance.
Regards,
Javier

2009/12/9 Jean Delvare <khali@linux-fr.org>

> Hi Javier,
>
> On Tue, 8 Dec 2009 12:28:07 +0100, Javier Zugasti wrote:
> > I wanted to ask if someone has used the i2c-imx driver functionalities to
> > communicate with a LM sensor. I haven't found a single example in the web
> > and I am very inexperienced with Linux.
>
> You don't really have to care. Almost all I2C-based hwmon drivers
> should work on top of any I2C bus driver. Exceptions are very rare (and
> would suggest broken hardware design.)
>
> > If so, could you please let me have a look to the application code so
> that I
> > can understand how to communicate with my LM73 using the functions from
> the
> > mentioned driver?
>
> You don't have to do anything, drivers for this already exist. The lm73
> driver isn't upstream yet, but it will be in a few days. For now you
> can pick the patch from there:
>
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-lm73-new-driver.patch
>
> After patching your kernel tree, simply load the i2c-imx and lm73
> drivers. Then either declare the lm73 device as part of your platform
> data, or instantiate it from user-space using
> the /sys/bus/i2c/devices/i2c-<n>/new_device file, where <n> is to be
> replaced with the relevant i2c-imx's bus number (probably 0, if you
> have a single I2C bus on your system.) And you should be done.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--0016e6db2dbb9ea5fd047a4d5b4d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi people,<br><br>Thank you very much for your reply Jean.<br>I patched the
kernel tree with the patch you linked me to and then selected the hwmon
and lm73 option in the menuconfig options (together with the i2c of
course). <br>
<br>After that I used a cross-compiler to compile the kernel for my
board and transferred the images to my board and started my linux there.<br=
><br>I assume the system supports i2c now.<br>No
i2c devices appear in the /dev directory or in /sys/bus/i2c/devices,
but the lm73 appears in /sys/bus/i2c/drivers and i2c appears in the
file /proc/devices:<br>
<br>cat /proc/devices <br>Character devices:<br>...=A0 <br><b>89 i2c</b><br=
>...<br><br>So
now, how can I write an application in the user space that reads the
temperature from the lm73? Do I have to use IOCTL calls or how do I do
it?<br>
<br>Thanks again for your help and excuse my ignorance.<br>Regards,<br>Javi=
er <br><br><div class=3D"gmail_quote">2009/12/9 Jean Delvare <span dir=3D"l=
tr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</s=
pan><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Javier,<br>
<div class=3D"im"><br>
On Tue, 8 Dec 2009 12:28:07 +0100, Javier Zugasti wrote:<br>
&gt; I wanted to ask if someone has used the i2c-imx driver functionalities=
 to<br>
&gt; communicate with a LM sensor. I haven&#39;t found a single example in =
the web<br>
&gt; and I am very inexperienced with Linux.<br>
<br>
</div>You don&#39;t really have to care. Almost all I2C-based hwmon drivers=
<br>
should work on top of any I2C bus driver. Exceptions are very rare (and<br>
would suggest broken hardware design.)<br>
<div class=3D"im"><br>
&gt; If so, could you please let me have a look to the application code so =
that I<br>
&gt; can understand how to communicate with my LM73 using the functions fro=
m the<br>
&gt; mentioned driver?<br>
<br>
</div>You don&#39;t have to do anything, drivers for this already exist. Th=
e lm73<br>
driver isn&#39;t upstream yet, but it will be in a few days. For now you<br=
>
can pick the patch from there:<br>
<br>
<a href=3D"ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/=
jdelvare-hwmon/hwmon-lm73-new-driver.patch" target=3D"_blank">ftp://ftp.ker=
nel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-lm7=
3-new-driver.patch</a><br>

<br>
After patching your kernel tree, simply load the i2c-imx and lm73<br>
drivers. Then either declare the lm73 device as part of your platform<br>
data, or instantiate it from user-space using<br>
the /sys/bus/i2c/devices/i2c-&lt;n&gt;/new_device file, where &lt;n&gt; is =
to be<br>
replaced with the relevant i2c-imx&#39;s bus number (probably 0, if you<br>
have a single I2C bus on your system.) And you should be done.<br>
<font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
<a href=3D"http://khali.linux-fr.org/wishlist.html" target=3D"_blank">http:=
//khali.linux-fr.org/wishlist.html</a><br>
</font></blockquote></div><br>

--0016e6db2dbb9ea5fd047a4d5b4d--


--===============8222275713461610508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8222275713461610508==--
