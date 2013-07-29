From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Mon, 29 Jul 2013 13:24:33 +0000
Subject: Re: [lm-sensors] Design decisions implementing an I2C LDD
Message-Id: <CA+TH9VmYtVEFHv9wByo-NzQAJ6-=6QbYe3JJZgaURLf92ahd2Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5092813498570513111=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+TH9VktNEiLHmU1WJAUG0QWPsCCXrG5O=KjynBasR5h8LhpPw@mail.gmail.com>
In-Reply-To: <CA+TH9VktNEiLHmU1WJAUG0QWPsCCXrG5O=KjynBasR5h8LhpPw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5092813498570513111==
Content-Type: multipart/alternative; boundary=047d7bb7099820451904e2a66cb2

--047d7bb7099820451904e2a66cb2
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,

Thank you for the quick reply. Wow, yes I think that IIO is definitively
what I'm looking for but I was unaware of it!

Thank you again for your support!



>>  Yes, but ...
>
> Have you considered writing an iio driver instead ? That might be more
> appropriate given the more likely use of this chip for generic ADC, not for
> hardware monitoring. If it is used for hardware monitoring, the iio/hwmon
> bridge driver could be used.
>
> Thanks,
> Guenter
>
>


-- 
Profile: http://it.linkedin.com/in/compagnucciangelo

--047d7bb7099820451904e2a66cb2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Guenter,</div><div><br></div><div>Thank you for th=
e quick reply. Wow, yes I think that IIO is definitively what I&#39;m looki=
ng for but I was unaware of it!</div><div><br></div><div>Thank you again fo=
r your support!</div>

<div><br></div><br><div class=3D"gmail_extra"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div class=3D"im"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">


<br>
</blockquote></div>
Yes, but ...<br>
<br>
Have you considered writing an iio driver instead ? That might be more appr=
opriate given the more likely use of this chip for generic ADC, not for har=
dware monitoring. If it is used for hardware monitoring, the iio/hwmon brid=
ge driver could be used.<br>


<br>
Thanks,<br>
Guenter<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Profile: <a =
href=3D"http://it.linkedin.com/in/compagnucciangelo" target=3D"_blank">http=
://it.linkedin.com/in/compagnucciangelo</a>
</div></div>

--047d7bb7099820451904e2a66cb2--


--===============5092813498570513111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5092813498570513111==--
