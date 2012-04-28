From: Martin Suchanek <martin.suc@googlemail.com>
Date: Sat, 28 Apr 2012 23:18:46 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <CAGqf2iLyAam+dzKV8izbC1X-zk+6uU2NrzJ5vVgSyz3ea3ADoA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6135460039018502832=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6135460039018502832==
Content-Type: multipart/alternative; boundary=f46d043d671f56cf0b04bec57129

--f46d043d671f56cf0b04bec57129
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 28, 2012 at 8:30 PM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Sat, Apr 28, 2012 at 03:04:51PM -0400, Martin Suchanek wrote:
> >
> >
> > On Sat, Apr 28, 2012 at 4:36 PM, Guenter Roeck <
> guenter.roeck@ericsson.com>
> > wrote:
> >
> >     On Sat, Apr 28, 2012 at 06:08:23AM -0400, Martin Suchanek wrote:
> >     >
> >     >
> >     > On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck <
> >     guenter.roeck@ericsson.com>
> >     > wrote:
> >     >
> >     >     On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek
> wrote:
> >     >     > Hi,
> >     >     >
> >     >     > Add info:
> >     >     > I have found software called open hardware monitor. I have
> been
> >     testing
> >     >     it
> >     >     > in windows for couple of days and it works properly with
> Nuvoton
> >     NST6776F
> >     >     > chip. I have been comparing results with AI Suite software
> coming
> >     from
> >     >     ASUS
> >     >     > and results are corresponding and measuring is with big
> precise. So
> >     , you
> >     >     > can have a look to source code and compare with your driver.
> This
> >     >     software
> >     >     > should work on linux as well but I did not try it yet but I
> will.
> >     >     >
> >     >     I finally had time to look into the open hardware monitor code.
> >     >
> >     >     The answer is quite simple - the board get the CPU temperature
> using
> >     PECI,
> >     >     which the w83627ehf/nct67765 driver reports is as "PECI Agent
> 0".
> >     >     Open Hardware Monitor maps that temperature into the CPU
> temperature
> >     >     display
> >     >     and ignores CPUTIN. Which makes sense, since the purpose of
> PECI is
> >     to
> >     >     report
> >     >     the CPU temperature.
> >     >
> >     >     So all you need to do is to ignore the value of CPUTIN and use
> the
> >     "PECI
> >     >     Agent 0"
> >     >     temperature instead.
> >     >
> >     >
> >     >
> >     > I am now confused ?
> >     > I do not know technical details but according to ASUS technical
> support
> >     > CPUTIN is temperature of motherboard (not cpu socket , not cpu
> yourself )
> >     > what exactly this temperature means ?
> >     >
> >     From looking into the OHM source, motherboard temperature is SYSTIN,
> not
> >     CPUTIN.
> >     Some but not all boards have AUXTIN connected as well. CPUTIN does
> not seem
> >     to be used at all on ASUS boards as far as I can see.
> >
> >
> >
> > I am sorry but when I compare my AI Suite monitor (I attached picture)
> (- 60
> > Celsius)  with psensor ( - 60 Celsius) => CPUTIN correspond with
> motherboard
> > temperature and technical support saying the same thing (even if I have
> to
> > admit that according to name convention it should be as you said). And
> AUXTIN
> > has asus motherboard maximus iv extreme - psensor is showing 33.5
> Celsius - no
> > problem with that.
>
> Judging from the OHM source, it looks like some Asus boards have AUXTIN
> connected,
> others don't. -60 degrees C suggests that there is nothing connected to
> the sensor pin.
>
> > where did you get exactly those information about what is what ? Could
> you put
> > some URL or documentation ?
>
> Open Hardware Monitor source code,
> http://open-hardware-monitor.googlecode.com/svn.
>
> I don't see CPUTIN on your screen shot. I only see "CPU" and "CPU socket",
> but I don't see
> anything suggesting that those report the temperature as measured on the
> CPUTIN pin
> of the NCT6776F. To know how the values reported by the AI suite map to
> board sensors,
> it would be necessary to see its source code and/or configuration files.
>
> Guenter
>


 Oh, sorry , I did not explain it in all context. Minus 60 Celsius has
motherboard in red colour.
 On the screenshot there is - 60 celsius temperature which corresponding
with value as in windows 7 as in linux psensor/lm-sensor as in my bios in
under certain complicated circumstances :-) That's the one for the reasons
why I am arguing due to meaning of CPUTIN.
 I try to explain - it is more complex:
Minus 60 Celsius does not mean that sensor is not connected. It is
connected because - In 90 percent of my computer working time it is
properly measuring value by BIOS and AI Suite ... EXCEPT lm-sensor/psensor
in Linux - it is ALWAYS minus 60 Celsius - this is wrong.
 What I am trying to say is that the problem is definitely at first with
hardware (this part I am still working on it with asus technical support)
and at second lm-sensor software in Linux. "Normally" , it is working
perfectly fine BUT in some very rarely occasions - when computer is running
much much longer temperature appears as minus 60 Celsius in Windows/BIOS".
BUT In Linux - it is ALWAYS minus 60 Celsius - it never was different value.
 Only CPUTIN temperature has such problem in Linux. The other temperatures
- SYSTIN , AUXTIN , PECI Agent 0 have been always correct as in Windows as
in BIOS as in Linux. I have been comparing/inspecting those values more
than half a year so I am sure about those temperature values :-)

  What I am totally confused is the meaning of CPUTIN/SYSTIN - from my
point of experience you are first person who is saying that CPUTIN is CPU
temperature and not motherboard temperature which is opposite what ASUS
technical support saying and further reason which I have mentioned before.
  ( :-) So if ASUS technical support is wrong it would be fun to talk with
ASUS technical support but I have to be absolutely sure about the meaning
of CPUTIN and SYSTIN :-) )
  On many forums - owners of this motherboard are confused like me and I
did not find any reliable source of information to be sure how is it in
real ?

If I run open hardware monitor in linux - there is no values for
temperatures - except GPU - but only one instead of two and etc. ... too
many discrepancies within this software on Linux so I do not trust that it
is correct measuring (need to contact author later)

AI Suite is commercial ASUS software for measuring many usefull "bios"
parameters like temperatures/fans/voltages etc. ... but only for windows) -
so no source code at all - I will try to find some config files.
By the way - ASUS is not supporting linux at all and will not be - they
confirmed that.

Please accept my apology If I explained something bad/wrong way - (I am not
good in explaination) - let me know for further information.

Regards,
Martin

--f46d043d671f56cf0b04bec57129
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Apr 28, 2012 at 8:30 PM, Guenter=
 Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com" =
target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Sat, Apr 28, 2012 at 03:04:51PM =
-0400, Martin Suchanek wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Sat, Apr 28, 2012 at 4:36 PM, Guenter Roeck &lt;<a href=3D"mailto:g=
uenter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 On Sat, Apr 28, 2012 at 06:08:23AM -0400, Martin Suchane=
k wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck &lt;=
<br>
&gt; =C2=A0 =C2=A0 <a href=3D"mailto:guenter.roeck@ericsson.com">guenter.ro=
eck@ericsson.com</a>&gt;<br>
&gt; =C2=A0 =C2=A0 &gt; wrote:<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 On Fri, Apr 20, 2012 at 11:47:47AM +0=
100, Martin Suchanek wrote:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; Hi,<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; Add info:<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; I have found software called ope=
n hardware monitor. I have been<br>
&gt; =C2=A0 =C2=A0 testing<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 it<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; in windows for couple of days an=
d it works properly with Nuvoton<br>
&gt; =C2=A0 =C2=A0 NST6776F<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; chip. I have been comparing resu=
lts with AI Suite software coming<br>
&gt; =C2=A0 =C2=A0 from<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 ASUS<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; and results are corresponding an=
d measuring is with big precise. So<br>
&gt; =C2=A0 =C2=A0 , you<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; can have a look to source code a=
nd compare with your driver. This<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 software<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt; should work on linux as well but=
 I did not try it yet but I will.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 I finally had time to look into the o=
pen hardware monitor code.<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 The answer is quite simple - the boar=
d get the CPU temperature using<br>
&gt; =C2=A0 =C2=A0 PECI,<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 which the w83627ehf/nct67765 driver r=
eports is as &quot;PECI Agent 0&quot;.<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 Open Hardware Monitor maps that tempe=
rature into the CPU temperature<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 display<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 and ignores CPUTIN. Which makes sense=
, since the purpose of PECI is<br>
&gt; =C2=A0 =C2=A0 to<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 report<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 the CPU temperature.<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 So all you need to do is to ignore th=
e value of CPUTIN and use the<br>
&gt; =C2=A0 =C2=A0 &quot;PECI<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 Agent 0&quot;<br>
&gt; =C2=A0 =C2=A0 &gt; =C2=A0 =C2=A0 temperature instead.<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 &gt; I am now confused ?<br>
&gt; =C2=A0 =C2=A0 &gt; I do not know technical details but according to AS=
US technical support<br>
&gt; =C2=A0 =C2=A0 &gt; CPUTIN is temperature of motherboard (not cpu socke=
t , not cpu yourself )<br>
&gt; =C2=A0 =C2=A0 &gt; what exactly this temperature means ?<br>
&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 From looking into the OHM source, motherboard temperatur=
e is SYSTIN, not<br>
&gt; =C2=A0 =C2=A0 CPUTIN.<br>
&gt; =C2=A0 =C2=A0 Some but not all boards have AUXTIN connected as well. C=
PUTIN does not seem<br>
&gt; =C2=A0 =C2=A0 to be used at all on ASUS boards as far as I can see.<br=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I am sorry but when I compare my AI Suite monitor (I attached picture)=
 (- 60<br>
&gt; Celsius)=C2=A0 with psensor ( - 60 Celsius) =3D&gt; CPUTIN correspond =
with motherboard<br>
&gt; temperature and technical support saying the same thing (even if I hav=
e to<br>
&gt; admit that according to name convention it should be as you said). And=
 AUXTIN<br>
&gt; has asus motherboard maximus iv extreme - psensor is showing 33.5 Cels=
ius - no<br>
&gt; problem with that.<br>
<br>
</div></div>Judging from the OHM source, it looks like some Asus boards hav=
e AUXTIN connected,<br>
others don&#39;t. -60 degrees C suggests that there is nothing connected to=
 the sensor pin.<br>
<div class=3D"im"><br>
&gt; where did you get exactly those information about what is what ? Could=
 you put<br>
&gt; some URL or documentation ?<br>
<br>
</div>Open Hardware Monitor source code, <a href=3D"http://open-hardware-mo=
nitor.googlecode.com/svn" target=3D"_blank">http://open-hardware-monitor.go=
oglecode.com/svn</a>.<br>
<br>
I don&#39;t see CPUTIN on your screen shot. I only see &quot;CPU&quot; and =
&quot;CPU socket&quot;, but I don&#39;t see<br>
anything suggesting that those report the temperature as measured on the CP=
UTIN pin<br>
of the NCT6776F. To know how the values reported by the AI suite map to boa=
rd sensors,<br>
it would be necessary to see its source code and/or configuration files.<br=
>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br></font></span></blockquote><div><br><br>=C2=A0Oh, sorry , I did =
not explain it in all context. Minus 60 Celsius has motherboard in red colo=
ur.<br>=C2=A0On the screenshot there is - 60 celsius temperature which corr=
esponding with value as in windows 7 as in linux psensor/lm-sensor as in my=
 bios in under certain complicated circumstances :-) That&#39;s the one for=
 the reasons why I am arguing due to meaning of CPUTIN.<br>
=C2=A0I try to explain - it is more complex:<br>Minus 60 Celsius does not m=
ean that sensor is not connected. It is connected because - In 90 percent o=
f my computer working time it is properly measuring value by BIOS and AI Su=
ite ... EXCEPT lm-sensor/psensor in Linux - it is ALWAYS minus 60 Celsius -=
 this is wrong.=C2=A0=C2=A0 <br>
=C2=A0What I am trying to say is that the problem is definitely at first wi=
th hardware (this part I am still working on it with asus technical support=
) and at second lm-sensor software in Linux. &quot;Normally&quot; , it is w=
orking perfectly fine BUT in some very rarely occasions - when computer is =
running much much longer temperature appears as minus 60 Celsius in Windows=
/BIOS&quot;. BUT In Linux - it is ALWAYS minus 60 Celsius - it never was di=
fferent value.<br>
=C2=A0Only CPUTIN temperature has such problem in Linux. The other temperat=
ures - SYSTIN , AUXTIN , PECI Agent 0 have been always correct as in Window=
s as in BIOS as in Linux. I have been comparing/inspecting those values mor=
e than half a year so I am sure about those temperature values :-)<br>
<br>=C2=A0 What I am totally confused is the meaning of CPUTIN/SYSTIN - fro=
m my point of experience you are first person who is saying that CPUTIN is =
CPU temperature and not motherboard temperature which is opposite what ASUS=
 technical support saying and further reason which I have mentioned before.=
 <br>
=C2=A0 ( :-) So if ASUS technical support is wrong it would be fun to talk =
with ASUS technical support but I have to be absolutely sure about the mean=
ing of CPUTIN and SYSTIN :-) )<br>=C2=A0 On many forums - owners of this mo=
therboard are confused like me and I did not find any reliable source of in=
formation to be sure how is it in real ?<br>
<br>If I run open hardware monitor in linux - there is no values for temper=
atures - except GPU - but only one instead of two and etc. ... too many dis=
crepancies within this software on Linux so I do not trust that it is corre=
ct measuring (need to contact author later)<br>
<br>AI Suite is commercial ASUS software for measuring many usefull &quot;b=
ios&quot; parameters like temperatures/fans/voltages etc. ... but only for =
windows) - so no source code at all - I will try to find some config files.=
 <br>
By the way - ASUS is not supporting linux at all and will not be - they con=
firmed that.<br></div></div><br>Please accept my apology If I explained som=
ething bad/wrong way - (I am not good in explaination) - let me know for fu=
rther information.<br>
<br>Regards,<br>Martin<br>

--f46d043d671f56cf0b04bec57129--


--===============6135460039018502832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6135460039018502832==--
