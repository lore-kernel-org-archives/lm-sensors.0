From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Date: Sun, 20 May 2012 20:30:27 +0000
Subject: Re: [lm-sensors] Fan control for Asus P8Z77
Message-Id: <CAD=fgeLStRZ8BRLBofcQM3FEw+cbooHgCuGMJGzVD3ODhzi0CA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3363722539428289399=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAD=fgeLGr1H4-+mXO3W3+Gzr55qM8Wsy=bSgdeavQX0QzKSK+A@mail.gmail.com>
In-Reply-To: <CAD=fgeLGr1H4-+mXO3W3+Gzr55qM8Wsy=bSgdeavQX0QzKSK+A@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3363722539428289399==
Content-Type: multipart/alternative; boundary=bcaec554098cea861a04c07da7d6

--bcaec554098cea861a04c07da7d6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Indeed, after an hour of searching around I actually found that
experimental driver.
I can confirm that it works very well!

On 20 May 2012 21:21, Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> On Sun, May 20, 2012 at 01:19:46PM -0400, Andr=E9e 'Glaucous' wrote:
> > Hi,
> >
> > The (somewhat) new Asus P8Z77 boards have arrived, I'm wondering how th=
e
> status
> > for fan control is for them?
> > I have a Asus P8Z77-V Pro, tried both it87 and asus_atk0110, both resul=
t
> in
> > that pwmconfig cannot find any controllable fans.
> >
> > Currently running libsensors version 3.3.2+SVN. I'm up for testing any
> patches
> > related to this chipset.
>
> Are you sure the board uses an IT87xx ? As far as I know, it uses NCT6779=
D.
>
> For NCT6779D, you can find an experimental driver at
> https://github.com/groeck/nct6775.
>
> Thanks,
> Guenter
>

--bcaec554098cea861a04c07da7d6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Indeed, after an hour of searching around I actually found that experimenta=
l driver.<div>I can confirm that it works very well!<br><div><br><div class=
=3D"gmail_quote">On 20 May 2012 21:21, Guenter Roeck <span dir=3D"ltr">&lt;=
<a href=3D"mailto:guenter.roeck@ericsson.com" target=3D"_blank">guenter.roe=
ck@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On S=
un, May 20, 2012 at 01:19:46PM -0400, Andr=E9e &#39;Glaucous&#39; wrote:<br=
>
&gt; Hi,<br>
&gt;<br>
&gt; The (somewhat) new Asus P8Z77 boards have arrived, I&#39;m wondering h=
ow the status<br>
&gt; for fan control is for them?<br>
&gt; I have a Asus P8Z77-V Pro, tried both it87 and asus_atk0110, both resu=
lt in<br>
&gt; that pwmconfig cannot find any controllable fans.<br>
&gt;<br>
&gt; Currently running libsensors version 3.3.2+SVN. I&#39;m up for testing=
 any patches<br>
&gt; related to this chipset.<br>
<br>
</div></div>Are you sure the board uses an IT87xx ? As far as I know, it us=
es NCT6779D.<br>
<br>
For NCT6779D, you can find an experimental driver at <a href=3D"https://git=
hub.com/groeck/nct6775" target=3D"_blank">https://github.com/groeck/nct6775=
</a>.<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br></div></div>

--bcaec554098cea861a04c07da7d6--


--===============3363722539428289399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3363722539428289399==--
