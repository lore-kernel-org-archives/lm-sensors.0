From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sat, 28 Apr 2012 10:08:23 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iJxZKVnEzLF=ojjjjuHW9ZmiqXWSRxYxSo1qFTtNeyKhw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6924619402119127205=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6924619402119127205==
Content-Type: multipart/alternative; boundary=90e6ba6e8642b73cf704beba66d1

--90e6ba6e8642b73cf704beba66d1
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek wrote:
> > Hi,
> >
> > Add info:
> > I have found software called open hardware monitor. I have been testing
> it
> > in windows for couple of days and it works properly with Nuvoton NST6776F
> > chip. I have been comparing results with AI Suite software coming from
> ASUS
> > and results are corresponding and measuring is with big precise. So , you
> > can have a look to source code and compare with your driver. This
> software
> > should work on linux as well but I did not try it yet but I will.
> >
> I finally had time to look into the open hardware monitor code.
>
> The answer is quite simple - the board get the CPU temperature using PECI,
> which the w83627ehf/nct67765 driver reports is as "PECI Agent 0".
> Open Hardware Monitor maps that temperature into the CPU temperature
> display
> and ignores CPUTIN. Which makes sense, since the purpose of PECI is to
> report
> the CPU temperature.
>
> So all you need to do is to ignore the value of CPUTIN and use the "PECI
> Agent 0"
> temperature instead.
>
>
I am now confused ?
I do not know technical details but according to ASUS technical support
CPUTIN is temperature of motherboard (not cpu socket , not cpu yourself )
what exactly this temperature means ?

Martin

--90e6ba6e8642b73cf704beba66d1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Apr 28, 2012 at 5:30 AM, Guenter=
 Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com" =
target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<div class=3D"im">On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek=
 wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Add info:<br>
&gt; I have found software called open hardware monitor. I have been testin=
g it<br>
&gt; in windows for couple of days and it works properly with Nuvoton NST67=
76F<br>
&gt; chip. I have been comparing results with AI Suite software coming from=
 ASUS<br>
&gt; and results are corresponding and measuring is with big precise. So , =
you<br>
&gt; can have a look to source code and compare with your driver. This soft=
ware<br>
&gt; should work on linux as well but I did not try it yet but I will.<br>
&gt;<br>
</div>I finally had time to look into the open hardware monitor code.<br>
<br>
The answer is quite simple - the board get the CPU temperature using PECI,<=
br>
which the w83627ehf/nct67765 driver reports is as &quot;PECI Agent 0&quot;.=
<br>
Open Hardware Monitor maps that temperature into the CPU temperature displa=
y<br>
and ignores CPUTIN. Which makes sense, since the purpose of PECI is to repo=
rt<br>
the CPU temperature.<br>
<br>
So all you need to do is to ignore the value of CPUTIN and use the &quot;PE=
CI Agent 0&quot;<br>
temperature instead.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br>I am now confused ? <br>I do not know technical details but acc=
ording to ASUS technical support <br>CPUTIN is temperature of motherboard (=
not cpu socket , not cpu yourself )<br>
what exactly this temperature means ?<br><font color=3D"#888888"><br>Martin=
<br></font><span class=3D"HOEnZb"><font color=3D"#888888">
</font></span></div></div><br>

--90e6ba6e8642b73cf704beba66d1--


--===============6924619402119127205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6924619402119127205==--
