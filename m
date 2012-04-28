From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sat, 28 Apr 2012 10:48:37 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iJjfzYN2UbRnicf=_8Nf22x0Y6YSAUeHr4hCm4bUVjSNg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5837770864100548464=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5837770864100548464==
Content-Type: multipart/alternative; boundary=14dae93404199cf69504bebaf6cc

--14dae93404199cf69504bebaf6cc
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 28, 2012 at 11:22 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Sat, 28 Apr 2012 11:08:23 +0100, Martin Suchanek wrote:
> > On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck
> > <guenter.roeck@ericsson.com>wrote:
> > > The answer is quite simple - the board get the CPU temperature using
> PECI,
> > > which the w83627ehf/nct67765 driver reports is as "PECI Agent 0".
> > > Open Hardware Monitor maps that temperature into the CPU temperature
> > > display
> > > and ignores CPUTIN. Which makes sense, since the purpose of PECI is to
> > > report
> > > the CPU temperature.
> > >
> > > So all you need to do is to ignore the value of CPUTIN and use the
> "PECI
> > > Agent 0"
> > > temperature instead.
> >
> > I am now confused ?
> > I do not know technical details but according to ASUS technical support
> > CPUTIN is temperature of motherboard (not cpu socket , not cpu yourself )
> > what exactly this temperature means ?
>
> Labels are suggestions from the chip maker, unfortunately board vendors
> are free to not follow these suggestions and wire the inputs
> differently. Confusion ensues...
>
> :-)  ok ,so now I am definitely confused. From now I do not know how is it
on my motherboard in real ?  :-)

> --
> Jean Delvare
>

--14dae93404199cf69504bebaf6cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Apr 28, 2012 at 11:22 AM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org" target=
=3D"_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"im">On Sat, 28 Apr 2012 11:08:23 +0100, Martin Suchanek wrote=
:<br>
&gt; On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck<br>
&gt; &lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericss=
on.com</a>&gt;wrote:<br>
</div><div class=3D"im">&gt; &gt; The answer is quite simple - the board ge=
t the CPU temperature using PECI,<br>
&gt; &gt; which the w83627ehf/nct67765 driver reports is as &quot;PECI Agen=
t 0&quot;.<br>
&gt; &gt; Open Hardware Monitor maps that temperature into the CPU temperat=
ure<br>
&gt; &gt; display<br>
&gt; &gt; and ignores CPUTIN. Which makes sense, since the purpose of PECI =
is to<br>
&gt; &gt; report<br>
&gt; &gt; the CPU temperature.<br>
&gt; &gt;<br>
&gt; &gt; So all you need to do is to ignore the value of CPUTIN and use th=
e &quot;PECI<br>
&gt; &gt; Agent 0&quot;<br>
&gt; &gt; temperature instead.<br>
&gt;<br>
&gt; I am now confused ?<br>
&gt; I do not know technical details but according to ASUS technical suppor=
t<br>
&gt; CPUTIN is temperature of motherboard (not cpu socket , not cpu yoursel=
f )<br>
&gt; what exactly this temperature means ?<br>
<br>
</div>Labels are suggestions from the chip maker, unfortunately board vendo=
rs<br>
are free to not follow these suggestions and wire the inputs<br>
differently. Confusion ensues...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>:-)=C2=A0 ok ,so now I am definitely confused. From now I do not kn=
ow how is it on my motherboard in real ?=C2=A0 :-)<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888">
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br>

--14dae93404199cf69504bebaf6cc--


--===============5837770864100548464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5837770864100548464==--
