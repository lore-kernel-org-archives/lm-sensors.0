From: Arun Raghavan <arraghav@gmail.com>
Date: Thu, 28 Jun 2012 16:21:40 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <CAP3RjSfE+nNdWgwJCGQ1mZGrPmVH53hNt9qxL06aHOZr=Lpm9A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7716757252082954374=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7716757252082954374==
Content-Type: multipart/alternative; boundary=e89a8fb1fbfafd4c9604c38ab93e

--e89a8fb1fbfafd4c9604c38ab93e
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jun 28, 2012 at 2:31 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 27 Jun 2012 18:18:09 -0400, Arun Raghavan wrote:
> > Writing 0 to pwm2 also keeps it at 1054 RPM. I'm setting pwm2_enable to
> 1,
> > isn't that supposed to make it manual? Also, I do see a variation between
> > 1054 RPM and 2109 RPM (and some steps in between), when I change pwm2. I
> > can't get it to spin lower than 1054 RPM though.
>
> 4-wire fans (which are the most popular on CPU cooling blocks these
> days) have an indirect interpretation of the PWM value, which means
> that the fan maker is free to set the minimum speed (PWM = 0) to any
> arbitrary limit they want. In best cases the value is clearly
> documented in the product description sheet or accompanying technical
> documentation.
>
> 1000 RPM is a relatively common value for the minimum speed of CPU
> fans, so I'm not surprised by your observations. If this is too much
> for you, you have to either lower the input voltage to the fan, or use
> a different model altogether.
>
>
Thanks, that makes sense. Can I control the input voltage through
software/some sysfs attribute or do I have to do it from the supply?

thanks,
-arun

--
> Jean Delvare
>

--e89a8fb1fbfafd4c9604c38ab93e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jun 28, 2012 at 2:31 AM, Jean De=
lvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=3D=
"_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<div class=3D"im">On Wed, 27 Jun 2012 18:18:09 -0400, Arun Raghavan wrote:<=
br>
&gt; Writing 0 to pwm2 also keeps it at 1054 RPM. I&#39;m setting pwm2_enab=
le to 1,<br>
&gt; isn&#39;t that supposed to make it manual? Also, I do see a variation =
between<br>
</div>&gt; 1054 RPM and 2109 RPM (and some steps in between), when I change=
 pwm2. I<br>
<div class=3D"im">&gt; can&#39;t get it to spin lower than 1054 RPM though.=
<br>
<br>
</div>4-wire fans (which are the most popular on CPU cooling blocks these<b=
r>
days) have an indirect interpretation of the PWM value, which means<br>
that the fan maker is free to set the minimum speed (PWM =3D 0) to any<br>
arbitrary limit they want. In best cases the value is clearly<br>
documented in the product description sheet or accompanying technical<br>
documentation.<br>
<br>
1000 RPM is a relatively common value for the minimum speed of CPU<br>
fans, so I&#39;m not surprised by your observations. If this is too much<br=
>
for you, you have to either lower the input voltage to the fan, or use<br>
a different model altogether.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br>Thanks, that makes sense. Can I control the input voltage throu=
gh software/some sysfs attribute or do I have to do it from the supply? <br=
>
<br>thanks,<br>-arun<br><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br>

--e89a8fb1fbfafd4c9604c38ab93e--


--===============7716757252082954374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7716757252082954374==--
