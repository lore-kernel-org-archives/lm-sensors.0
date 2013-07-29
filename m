From: =?ISO-8859-1?Q?Hakan_T=DCR=DCT?= <hakanturut@gmail.com>
Date: Mon, 29 Jul 2013 11:07:37 +0000
Subject: Re: [lm-sensors] HM65 chipset fan control
Message-Id: <CABeCqAHbMst61vKDhEzMg=LmhR6Q0H5Ehm22J=ZbLAfm7pzMQQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7720206918302729423=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABeCqAFg+BMZrB=eJFMwSFJEkeLOhmUMFgTi2r0cBYOjaNhoiA@mail.gmail.com>
In-Reply-To: <CABeCqAFg+BMZrB=eJFMwSFJEkeLOhmUMFgTi2r0cBYOjaNhoiA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7720206918302729423==
Content-Type: multipart/alternative; boundary=001a11c1efa60fcc9504e2a48028

--001a11c1efa60fcc9504e2a48028
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Guenter , i hope someone starts working on that soon.


2013/7/29 Guenter Roeck <linux@roeck-us.net>

> On 07/29/2013 02:16 AM, Hakan T=DCR=DCT wrote:
>
>> Hello,
>> I have a laptop with i5 cpu and hm65 chipset.There is a problem with fan
>> control.I asked to manufacture  of my laptop what chipset is used in
>> this pc for control the fan ? They said "Your southbridge controlling
>> it(HM65 chipset)."lm-sensors auto detect does not detect any fan or
>> voltage.Is there any path or something ?
>>
>>  Most likely it is through the Intel Management Engine (MEI).
> Unfortunately there is no Linux driver available yet to support MEI fan
> control.
>
> Guenter
>
>
>

--001a11c1efa60fcc9504e2a48028
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:large">Thanks Guenter , i hope someone starts working =
on that soon.<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gma=
il_quote">
2013/7/29 Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck=
-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span><br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 07/29/2013 02:16 AM, Hakan T=DCR=
=DCT wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
I have a laptop with i5 cpu and hm65 chipset.There is a problem with fan<br=
>
control.I asked to manufacture =A0of my laptop what chipset is used in<br>
this pc for control the fan ? They said &quot;Your southbridge controlling<=
br>
it(HM65 chipset).&quot;lm-sensors auto detect does not detect any fan or<br=
>
voltage.Is there any path or something ?<br>
<br>
</blockquote></div></div>
Most likely it is through the Intel Management Engine (MEI).<br>
Unfortunately there is no Linux driver available yet to support MEI fan<br>
control.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Guenter<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a11c1efa60fcc9504e2a48028--


--===============7720206918302729423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7720206918302729423==--
