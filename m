From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Apr 2012 23:41:19 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120428234119.GA25782@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Apr 28, 2012 at 07:18:46PM -0400, Martin Suchanek wrote:
>=20
>=20
> On Sat, Apr 28, 2012 at 8:30 PM, Guenter Roeck <guenter.roeck@ericsson.co=
m>
> wrote:
>=20
>     On Sat, Apr 28, 2012 at 03:04:51PM -0400, Martin Suchanek wrote:
>     >
>     >
>     > On Sat, Apr 28, 2012 at 4:36 PM, Guenter Roeck <
>     guenter.roeck@ericsson.com>
>     > wrote:
>     >
>     > =A0 =A0 On Sat, Apr 28, 2012 at 06:08:23AM -0400, Martin Suchanek w=
rote:
>     > =A0 =A0 >
>     > =A0 =A0 >
>     > =A0 =A0 > On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck <
>     > =A0 =A0 guenter.roeck@ericsson.com>
>     > =A0 =A0 > wrote:
>     > =A0 =A0 >
>     > =A0 =A0 > =A0 =A0 On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin =
Suchanek
>     wrote:
>     > =A0 =A0 > =A0 =A0 > Hi,
>     > =A0 =A0 > =A0 =A0 >
>     > =A0 =A0 > =A0 =A0 > Add info:
>     > =A0 =A0 > =A0 =A0 > I have found software called open hardware moni=
tor. I have
>     been
>     > =A0 =A0 testing
>     > =A0 =A0 > =A0 =A0 it
>     > =A0 =A0 > =A0 =A0 > in windows for couple of days and it works prop=
erly with
>     Nuvoton
>     > =A0 =A0 NST6776F
>     > =A0 =A0 > =A0 =A0 > chip. I have been comparing results with AI Sui=
te software
>     coming
>     > =A0 =A0 from
>     > =A0 =A0 > =A0 =A0 ASUS
>     > =A0 =A0 > =A0 =A0 > and results are corresponding and measuring is =
with big
>     precise. So
>     > =A0 =A0 , you
>     > =A0 =A0 > =A0 =A0 > can have a look to source code and compare with=
 your driver.
>     This
>     > =A0 =A0 > =A0 =A0 software
>     > =A0 =A0 > =A0 =A0 > should work on linux as well but I did not try =
it yet but I
>     will.
>     > =A0 =A0 > =A0 =A0 >
>     > =A0 =A0 > =A0 =A0 I finally had time to look into the open hardware=
 monitor code.
>     > =A0 =A0 >
>     > =A0 =A0 > =A0 =A0 The answer is quite simple - the board get the CP=
U temperature
>     using
>     > =A0 =A0 PECI,
>     > =A0 =A0 > =A0 =A0 which the w83627ehf/nct67765 driver reports is as=
 "PECI Agent
>     0".
>     > =A0 =A0 > =A0 =A0 Open Hardware Monitor maps that temperature into =
the CPU
>     temperature
>     > =A0 =A0 > =A0 =A0 display
>     > =A0 =A0 > =A0 =A0 and ignores CPUTIN. Which makes sense, since the =
purpose of
>     PECI is
>     > =A0 =A0 to
>     > =A0 =A0 > =A0 =A0 report
>     > =A0 =A0 > =A0 =A0 the CPU temperature.
>     > =A0 =A0 >
>     > =A0 =A0 > =A0 =A0 So all you need to do is to ignore the value of C=
PUTIN and use
>     the
>     > =A0 =A0 "PECI
>     > =A0 =A0 > =A0 =A0 Agent 0"
>     > =A0 =A0 > =A0 =A0 temperature instead.
>     > =A0 =A0 >
>     > =A0 =A0 >
>     > =A0 =A0 >
>     > =A0 =A0 > I am now confused ?
>     > =A0 =A0 > I do not know technical details but according to ASUS tec=
hnical
>     support
>     > =A0 =A0 > CPUTIN is temperature of motherboard (not cpu socket , no=
t cpu
>     yourself )
>     > =A0 =A0 > what exactly this temperature means ?
>     > =A0 =A0 >
>     > =A0 =A0 From looking into the OHM source, motherboard temperature i=
s SYSTIN,
>     not
>     > =A0 =A0 CPUTIN.
>     > =A0 =A0 Some but not all boards have AUXTIN connected as well. CPUT=
IN does
>     not seem
>     > =A0 =A0 to be used at all on ASUS boards as far as I can see.
>     >
>     >
>     >
>     > I am sorry but when I compare my AI Suite monitor (I attached pictu=
re) (-
>     60
>     > Celsius)=A0 with psensor ( - 60 Celsius) =3D> CPUTIN correspond with
>     motherboard
>     > temperature and technical support saying the same thing (even if I =
have
>     to
>     > admit that according to name convention it should be as you said). =
And
>     AUXTIN
>     > has asus motherboard maximus iv extreme - psensor is showing 33.5 C=
elsius
>     - no
>     > problem with that.
>=20
>     Judging from the OHM source, it looks like some Asus boards have AUXT=
IN
>     connected,
>     others don't. -60 degrees C suggests that there is nothing connected =
to the
>     sensor pin.
>=20
>     > where did you get exactly those information about what is what ? Co=
uld
>     you put
>     > some URL or documentation ?
>=20
>     Open Hardware Monitor source code, http://
>     open-hardware-monitor.googlecode.com/svn.
>=20
>     I don't see CPUTIN on your screen shot. I only see "CPU" and "CPU soc=
ket",
>     but I don't see
>     anything suggesting that those report the temperature as measured on =
the
>     CPUTIN pin
>     of the NCT6776F. To know how the values reported by the AI suite map =
to
>     board sensors,
>     it would be necessary to see its source code and/or configuration fil=
es.
>   =20
>     Guenter
>=20
>=20
>=20
> =A0Oh, sorry , I did not explain it in all context. Minus 60 Celsius has
> motherboard in red colour.
> =A0On the screenshot there is - 60 celsius temperature which correspondin=
g with
> value as in windows 7 as in linux psensor/lm-sensor as in my bios in under
> certain complicated circumstances :-) That's the one for the reasons why =
I am
> arguing due to meaning of CPUTIN.
> =A0I try to explain - it is more complex:
> Minus 60 Celsius does not mean that sensor is not connected. It is connec=
ted
> because - In 90 percent of my computer working time it is properly measur=
ing
> value by BIOS and AI Suite ... EXCEPT lm-sensor/psensor in Linux - it is =
ALWAYS
> minus 60 Celsius - this is wrong.=A0=A0
> =A0What I am trying to say is that the problem is definitely at first with
> hardware (this part I am still working on it with asus technical support)=
 and
> at second lm-sensor software in Linux. "Normally" , it is working perfect=
ly
> fine BUT in some very rarely occasions - when computer is running much mu=
ch
> longer temperature appears as minus 60 Celsius in Windows/BIOS". BUT In L=
inux -
> it is ALWAYS minus 60 Celsius - it never was different value.
> =A0Only CPUTIN temperature has such problem in Linux. The other temperatu=
res -
> SYSTIN , AUXTIN , PECI Agent 0 have been always correct as in Windows as =
in
> BIOS as in Linux. I have been comparing/inspecting those values more than=
 half
> a year so I am sure about those temperature values :-)
>=20
> =A0 What I am totally confused is the meaning of CPUTIN/SYSTIN - from my =
point of
> experience you are first person who is saying that CPUTIN is CPU temperat=
ure
> and not motherboard temperature which is opposite what ASUS technical sup=
port
> saying and further reason which I have mentioned before.
> =A0 ( :-) So if ASUS technical support is wrong it would be fun to talk w=
ith ASUS
> technical support but I have to be absolutely sure about the meaning of C=
PUTIN
> and SYSTIN :-) )
> =A0 On many forums - owners of this motherboard are confused like me and =
I did
> not find any reliable source of information to be sure how is it in real ?
>=20
> If I run open hardware monitor in linux - there is no values for temperat=
ures -
> except GPU - but only one instead of two and etc. ... too many discrepanc=
ies
> within this software on Linux so I do not trust that it is correct measur=
ing
> (need to contact author later)
>=20
> AI Suite is commercial ASUS software for measuring many usefull "bios"
> parameters like temperatures/fans/voltages etc. ... but only for windows)=
 - so
> no source code at all - I will try to find some config files.
> By the way - ASUS is not supporting linux at all and will not be - they
> confirmed that.
>=20
> Please accept my apology If I explained something bad/wrong way - (I am n=
ot
> good in explaination) - let me know for further information.
>=20
Well, for my part I don't think I can help you any further. The driver repo=
rts
what it gets from the chip. The driver source is public. If you say that th=
e driver
has a bug, feel free to dig through the driver and try to find it. I'll be =
more
than happy to accept patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
