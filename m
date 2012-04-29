From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sun, 29 Apr 2012 09:42:30 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iKv7tguKwDv4JRS6ZdLFYUrgYnjaFLYEdD12n-=KUKcSQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6825167634610900564=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6825167634610900564==
Content-Type: multipart/alternative; boundary=14dae934041904cad804bece2831

--14dae934041904cad804bece2831
Content-Type: text/plain; charset=UTF-8

On Sun, Apr 29, 2012 at 12:41 AM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Sat, Apr 28, 2012 at 07:18:46PM -0400, Martin Suchanek wrote:
> >
> >
> > On Sat, Apr 28, 2012 at 8:30 PM, Guenter Roeck <
> guenter.roeck@ericsson.com>
> > wrote:
> >
> >     On Sat, Apr 28, 2012 at 03:04:51PM -0400, Martin Suchanek wrote:
> >     >
> >     >
> >     > On Sat, Apr 28, 2012 at 4:36 PM, Guenter Roeck <
> >     guenter.roeck@ericsson.com>
> >     > wrote:
> >     >
> >     >     On Sat, Apr 28, 2012 at 06:08:23AM -0400, Martin Suchanek
> wrote:
> >     >     >
> >     >     >
> >     >     > On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck <
> >     >     guenter.roeck@ericsson.com>
> >     >     > wrote:
> >     >     >
> >     >     >     On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek
> >     wrote:
> >     >     >     > Hi,
> >     >     >     >
> >     >     >     > Add info:
> >     >     >     > I have found software called open hardware monitor. I
> have
> >     been
> >     >     testing
> >     >     >     it
> >     >     >     > in windows for couple of days and it works properly
> with
> >     Nuvoton
> >     >     NST6776F
> >     >     >     > chip. I have been comparing results with AI Suite
> software
> >     coming
> >     >     from
> >     >     >     ASUS
> >     >     >     > and results are corresponding and measuring is with big
> >     precise. So
> >     >     , you
> >     >     >     > can have a look to source code and compare with your
> driver.
> >     This
> >     >     >     software
> >     >     >     > should work on linux as well but I did not try it yet
> but I
> >     will.
> >     >     >     >
> >     >     >     I finally had time to look into the open hardware
> monitor code.
> >     >     >
> >     >     >     The answer is quite simple - the board get the CPU
> temperature
> >     using
> >     >     PECI,
> >     >     >     which the w83627ehf/nct67765 driver reports is as "PECI
> Agent
> >     0".
> >     >     >     Open Hardware Monitor maps that temperature into the CPU
> >     temperature
> >     >     >     display
> >     >     >     and ignores CPUTIN. Which makes sense, since the purpose
> of
> >     PECI is
> >     >     to
> >     >     >     report
> >     >     >     the CPU temperature.
> >     >     >
> >     >     >     So all you need to do is to ignore the value of CPUTIN
> and use
> >     the
> >     >     "PECI
> >     >     >     Agent 0"
> >     >     >     temperature instead.
> >     >     >
> >     >     >
> >     >     >
> >     >     > I am now confused ?
> >     >     > I do not know technical details but according to ASUS
> technical
> >     support
> >     >     > CPUTIN is temperature of motherboard (not cpu socket , not
> cpu
> >     yourself )
> >     >     > what exactly this temperature means ?
> >     >     >
> >     >     From looking into the OHM source, motherboard temperature is
> SYSTIN,
> >     not
> >     >     CPUTIN.
> >     >     Some but not all boards have AUXTIN connected as well. CPUTIN
> does
> >     not seem
> >     >     to be used at all on ASUS boards as far as I can see.
> >     >
> >     >
> >     >
> >     > I am sorry but when I compare my AI Suite monitor (I attached
> picture) (-
> >     60
> >     > Celsius)  with psensor ( - 60 Celsius) => CPUTIN correspond with
> >     motherboard
> >     > temperature and technical support saying the same thing (even if I
> have
> >     to
> >     > admit that according to name convention it should be as you said).
> And
> >     AUXTIN
> >     > has asus motherboard maximus iv extreme - psensor is showing 33.5
> Celsius
> >     - no
> >     > problem with that.
> >
> >     Judging from the OHM source, it looks like some Asus boards have
> AUXTIN
> >     connected,
> >     others don't. -60 degrees C suggests that there is nothing connected
> to the
> >     sensor pin.
> >
> >     > where did you get exactly those information about what is what ?
> Could
> >     you put
> >     > some URL or documentation ?
> >
> >     Open Hardware Monitor source code, http://
> >     open-hardware-monitor.googlecode.com/svn.
> >
> >     I don't see CPUTIN on your screen shot. I only see "CPU" and "CPU
> socket",
> >     but I don't see
> >     anything suggesting that those report the temperature as measured on
> the
> >     CPUTIN pin
> >     of the NCT6776F. To know how the values reported by the AI suite map
> to
> >     board sensors,
> >     it would be necessary to see its source code and/or configuration
> files.
> >
> >     Guenter
> >
> >
> >
> >  Oh, sorry , I did not explain it in all context. Minus 60 Celsius has
> > motherboard in red colour.
> >  On the screenshot there is - 60 celsius temperature which corresponding
> with
> > value as in windows 7 as in linux psensor/lm-sensor as in my bios in
> under
> > certain complicated circumstances :-) That's the one for the reasons why
> I am
> > arguing due to meaning of CPUTIN.
> >  I try to explain - it is more complex:
> > Minus 60 Celsius does not mean that sensor is not connected. It is
> connected
> > because - In 90 percent of my computer working time it is properly
> measuring
> > value by BIOS and AI Suite ... EXCEPT lm-sensor/psensor in Linux - it is
> ALWAYS
> > minus 60 Celsius - this is wrong.
> >  What I am trying to say is that the problem is definitely at first with
> > hardware (this part I am still working on it with asus technical
> support) and
> > at second lm-sensor software in Linux. "Normally" , it is working
> perfectly
> > fine BUT in some very rarely occasions - when computer is running much
> much
> > longer temperature appears as minus 60 Celsius in Windows/BIOS". BUT In
> Linux -
> > it is ALWAYS minus 60 Celsius - it never was different value.
> >  Only CPUTIN temperature has such problem in Linux. The other
> temperatures -
> > SYSTIN , AUXTIN , PECI Agent 0 have been always correct as in Windows as
> in
> > BIOS as in Linux. I have been comparing/inspecting those values more
> than half
> > a year so I am sure about those temperature values :-)
> >
> >   What I am totally confused is the meaning of CPUTIN/SYSTIN - from my
> point of
> > experience you are first person who is saying that CPUTIN is CPU
> temperature
> > and not motherboard temperature which is opposite what ASUS technical
> support
> > saying and further reason which I have mentioned before.
> >   ( :-) So if ASUS technical support is wrong it would be fun to talk
> with ASUS
> > technical support but I have to be absolutely sure about the meaning of
> CPUTIN
> > and SYSTIN :-) )
> >   On many forums - owners of this motherboard are confused like me and I
> did
> > not find any reliable source of information to be sure how is it in real
> ?
> >
> > If I run open hardware monitor in linux - there is no values for
> temperatures -
> > except GPU - but only one instead of two and etc. ... too many
> discrepancies
> > within this software on Linux so I do not trust that it is correct
> measuring
> > (need to contact author later)
> >
> > AI Suite is commercial ASUS software for measuring many usefull "bios"
> > parameters like temperatures/fans/voltages etc. ... but only for
> windows) - so
> > no source code at all - I will try to find some config files.
> > By the way - ASUS is not supporting linux at all and will not be - they
> > confirmed that.
> >
> > Please accept my apology If I explained something bad/wrong way - (I am
> not
> > good in explaination) - let me know for further information.
> >
> Well, for my part I don't think I can help you any further. The driver
> reports
> what it gets from the chip. The driver source is public. If you say that
> the driver
> has a bug, feel free to dig through the driver and try to find it. I'll be
> more
> than happy to accept patches.
>
> Thanks,
> Guenter
>

:-) ok , that will be too many things for me to learn but I will (I made
for the last time software in assembler and C 20 years ago) :-)
Martin

--14dae934041904cad804bece2831
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sun, Apr 29, 2012 at 12:41 AM, Guente=
r Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com"=
 target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Sat, Apr 28, 2012 at 07:18:46PM =
-0400, Martin Suchanek wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Sat, Apr 28, 2012 at 8:30 PM, Guenter Roeck &lt;<a href=3D"mailto:g=
uenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 On Sat, Apr 28, 2012 at 03:04:51PM -0400, Martin Suchane=
k wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; On Sat, Apr 28, 2012 at 4:36 PM, Guenter Roeck &lt;=
<br>
&gt; =C2=A0 =C2=A0 <a href=3D"mailto:guenter.roeck@ericsson.com">guenter.ro=
eck@ericsson.com</a>&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 On Sat, Apr 28, 2012 at 06:08:23AM -0=
400, Martin Suchanek wrote:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; On Sat, Apr 28, 2012 at 5:30 AM,=
 Guenter Roeck &lt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 <a href=3D"mailto:guenter.roeck@erics=
son.com">guenter.roeck@ericsson.com</a>&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; wrote:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 On Fri, Apr 20, 20=
12 at 11:47:47AM +0100, Martin Suchanek<br>
&gt; =C2=A0 =C2=A0 wrote:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; Hi,<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; Add info:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; I have found =
software called open hardware monitor. I have<br>
&gt; =C2=A0 =C2=A0 been<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 testing<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 it<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; in windows fo=
r couple of days and it works properly with<br>
&gt; =C2=A0 =C2=A0 Nuvoton<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 NST6776F<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; chip. I have =
been comparing results with AI Suite software<br>
&gt; =C2=A0 =C2=A0 coming<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 from<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 ASUS<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; and results a=
re corresponding and measuring is with big<br>
&gt; =C2=A0 =C2=A0 precise. So<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 , you<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; can have a lo=
ok to source code and compare with your driver.<br>
&gt; =C2=A0 =C2=A0 This<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 software<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; should work o=
n linux as well but I did not try it yet but I<br>
&gt; =C2=A0 =C2=A0 will.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 I finally had time=
 to look into the open hardware monitor code.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 The answer is quit=
e simple - the board get the CPU temperature<br>
&gt; =C2=A0 =C2=A0 using<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 PECI,<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 which the w83627eh=
f/nct67765 driver reports is as &quot;PECI Agent<br>
&gt; =C2=A0 =C2=A0 0&quot;.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 Open Hardware Moni=
tor maps that temperature into the CPU<br>
&gt; =C2=A0 =C2=A0 temperature<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 display<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 and ignores CPUTIN=
. Which makes sense, since the purpose of<br>
&gt; =C2=A0 =C2=A0 PECI is<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 to<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 report<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 the CPU temperatur=
e.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 So all you need to=
 do is to ignore the value of CPUTIN and use<br>
&gt; =C2=A0 =C2=A0 the<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &quot;PECI<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 Agent 0&quot;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 temperature instea=
d.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; I am now confused ?<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; I do not know technical details =
but according to ASUS technical<br>
&gt; =C2=A0 =C2=A0 support<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; CPUTIN is temperature of motherb=
oard (not cpu socket , not cpu<br>
&gt; =C2=A0 =C2=A0 yourself )<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; what exactly this temperature me=
ans ?<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 From looking into the OHM source, mot=
herboard temperature is SYSTIN,<br>
&gt; =C2=A0 =C2=A0 not<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 CPUTIN.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 Some but not all boards have AUXTIN c=
onnected as well. CPUTIN does<br>
&gt; =C2=A0 =C2=A0 not seem<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 to be used at all on ASUS boards as f=
ar as I can see.<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; I am sorry but when I compare my AI Suite monitor (=
I attached picture) (-<br>
&gt; =C2=A0 =C2=A0 60<br>
&gt; =C2=A0 =C2=A0 &gt; Celsius)=C2=A0 with psensor ( - 60 Celsius) =3D&gt;=
 CPUTIN correspond with<br>
&gt; =C2=A0 =C2=A0 motherboard<br>
&gt; =C2=A0 =C2=A0 &gt; temperature and technical support saying the same t=
hing (even if I have<br>
&gt; =C2=A0 =C2=A0 to<br>
&gt; =C2=A0 =C2=A0 &gt; admit that according to name convention it should b=
e as you said). And<br>
&gt; =C2=A0 =C2=A0 AUXTIN<br>
&gt; =C2=A0 =C2=A0 &gt; has asus motherboard maximus iv extreme - psensor i=
s showing 33.5 Celsius<br>
&gt; =C2=A0 =C2=A0 - no<br>
&gt; =C2=A0 =C2=A0 &gt; problem with that.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Judging from the OHM source, it looks like some Asus boa=
rds have AUXTIN<br>
&gt; =C2=A0 =C2=A0 connected,<br>
&gt; =C2=A0 =C2=A0 others don&#39;t. -60 degrees C suggests that there is n=
othing connected to the<br>
&gt; =C2=A0 =C2=A0 sensor pin.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; where did you get exactly those information about w=
hat is what ? Could<br>
&gt; =C2=A0 =C2=A0 you put<br>
&gt; =C2=A0 =C2=A0 &gt; some URL or documentation ?<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Open Hardware Monitor source code, http://<br>
&gt; =C2=A0 =C2=A0 <a href=3D"http://open-hardware-monitor.googlecode.com/s=
vn" target=3D"_blank">open-hardware-monitor.googlecode.com/svn</a>.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 I don&#39;t see CPUTIN on your screen shot. I only see &=
quot;CPU&quot; and &quot;CPU socket&quot;,<br>
&gt; =C2=A0 =C2=A0 but I don&#39;t see<br>
&gt; =C2=A0 =C2=A0 anything suggesting that those report the temperature as=
 measured on the<br>
&gt; =C2=A0 =C2=A0 CPUTIN pin<br>
&gt; =C2=A0 =C2=A0 of the NCT6776F. To know how the values reported by the =
AI suite map to<br>
&gt; =C2=A0 =C2=A0 board sensors,<br>
&gt; =C2=A0 =C2=A0 it would be necessary to see its source code and/or conf=
iguration files.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Guenter<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0Oh, sorry , I did not explain it in all context. Minus 60 Celsiu=
s has<br>
&gt; motherboard in red colour.<br>
&gt; =C2=A0On the screenshot there is - 60 celsius temperature which corres=
ponding with<br>
&gt; value as in windows 7 as in linux psensor/lm-sensor as in my bios in u=
nder<br>
&gt; certain complicated circumstances :-) That&#39;s the one for the reaso=
ns why I am<br>
&gt; arguing due to meaning of CPUTIN.<br>
&gt; =C2=A0I try to explain - it is more complex:<br>
&gt; Minus 60 Celsius does not mean that sensor is not connected. It is con=
nected<br>
&gt; because - In 90 percent of my computer working time it is properly mea=
suring<br>
&gt; value by BIOS and AI Suite ... EXCEPT lm-sensor/psensor in Linux - it =
is ALWAYS<br>
&gt; minus 60 Celsius - this is wrong.=C2=A0=C2=A0<br>
&gt; =C2=A0What I am trying to say is that the problem is definitely at fir=
st with<br>
&gt; hardware (this part I am still working on it with asus technical suppo=
rt) and<br>
&gt; at second lm-sensor software in Linux. &quot;Normally&quot; , it is wo=
rking perfectly<br>
&gt; fine BUT in some very rarely occasions - when computer is running much=
 much<br>
&gt; longer temperature appears as minus 60 Celsius in Windows/BIOS&quot;. =
BUT In Linux -<br>
&gt; it is ALWAYS minus 60 Celsius - it never was different value.<br>
&gt; =C2=A0Only CPUTIN temperature has such problem in Linux. The other tem=
peratures -<br>
&gt; SYSTIN , AUXTIN , PECI Agent 0 have been always correct as in Windows =
as in<br>
&gt; BIOS as in Linux. I have been comparing/inspecting those values more t=
han half<br>
&gt; a year so I am sure about those temperature values :-)<br>
&gt;<br>
&gt; =C2=A0 What I am totally confused is the meaning of CPUTIN/SYSTIN - fr=
om my point of<br>
&gt; experience you are first person who is saying that CPUTIN is CPU tempe=
rature<br>
&gt; and not motherboard temperature which is opposite what ASUS technical =
support<br>
&gt; saying and further reason which I have mentioned before.<br>
&gt; =C2=A0 ( :-) So if ASUS technical support is wrong it would be fun to =
talk with ASUS<br>
&gt; technical support but I have to be absolutely sure about the meaning o=
f CPUTIN<br>
&gt; and SYSTIN :-) )<br>
&gt; =C2=A0 On many forums - owners of this motherboard are confused like m=
e and I did<br>
&gt; not find any reliable source of information to be sure how is it in re=
al ?<br>
&gt;<br>
&gt; If I run open hardware monitor in linux - there is no values for tempe=
ratures -<br>
&gt; except GPU - but only one instead of two and etc. ... too many discrep=
ancies<br>
&gt; within this software on Linux so I do not trust that it is correct mea=
suring<br>
&gt; (need to contact author later)<br>
&gt;<br>
&gt; AI Suite is commercial ASUS software for measuring many usefull &quot;=
bios&quot;<br>
&gt; parameters like temperatures/fans/voltages etc. ... but only for windo=
ws) - so<br>
&gt; no source code at all - I will try to find some config files.<br>
&gt; By the way - ASUS is not supporting linux at all and will not be - the=
y<br>
&gt; confirmed that.<br>
&gt;<br>
&gt; Please accept my apology If I explained something bad/wrong way - (I a=
m not<br>
&gt; good in explaination) - let me know for further information.<br>
&gt;<br>
</div></div>Well, for my part I don&#39;t think I can help you any further.=
 The driver reports<br>
what it gets from the chip. The driver source is public. If you say that th=
e driver<br>
has a bug, feel free to dig through the driver and try to find it. I&#39;ll=
 be more<br>
than happy to accept patches.<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br>:-) ok , that will be too many things for me to lear=
n but I will (I made for the last time software in assembler and C 20 years=
 ago) :-)<br>Martin<br>

--14dae934041904cad804bece2831--


--===============6825167634610900564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6825167634610900564==--
