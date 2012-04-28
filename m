From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Apr 2012 19:30:23 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120428193023.GB24926@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Apr 28, 2012 at 03:04:51PM -0400, Martin Suchanek wrote:
>=20
>=20
> On Sat, Apr 28, 2012 at 4:36 PM, Guenter Roeck <guenter.roeck@ericsson.co=
m>
> wrote:
>=20
>     On Sat, Apr 28, 2012 at 06:08:23AM -0400, Martin Suchanek wrote:
>     >
>     >
>     > On Sat, Apr 28, 2012 at 5:30 AM, Guenter Roeck <
>     guenter.roeck@ericsson.com>
>     > wrote:
>     >
>     > =A0 =A0 On Fri, Apr 20, 2012 at 11:47:47AM +0100, Martin Suchanek w=
rote:
>     > =A0 =A0 > Hi,
>     > =A0 =A0 >
>     > =A0 =A0 > Add info:
>     > =A0 =A0 > I have found software called open hardware monitor. I hav=
e been
>     testing
>     > =A0 =A0 it
>     > =A0 =A0 > in windows for couple of days and it works properly with =
Nuvoton
>     NST6776F
>     > =A0 =A0 > chip. I have been comparing results with AI Suite softwar=
e coming
>     from
>     > =A0 =A0 ASUS
>     > =A0 =A0 > and results are corresponding and measuring is with big p=
recise. So
>     , you
>     > =A0 =A0 > can have a look to source code and compare with your driv=
er. This
>     > =A0 =A0 software
>     > =A0 =A0 > should work on linux as well but I did not try it yet but=
 I will.
>     > =A0 =A0 >
>     > =A0 =A0 I finally had time to look into the open hardware monitor c=
ode.
>     >
>     > =A0 =A0 The answer is quite simple - the board get the CPU temperat=
ure using
>     PECI,
>     > =A0 =A0 which the w83627ehf/nct67765 driver reports is as "PECI Age=
nt 0".
>     > =A0 =A0 Open Hardware Monitor maps that temperature into the CPU te=
mperature
>     > =A0 =A0 display
>     > =A0 =A0 and ignores CPUTIN. Which makes sense, since the purpose of=
 PECI is
>     to
>     > =A0 =A0 report
>     > =A0 =A0 the CPU temperature.
>     >
>     > =A0 =A0 So all you need to do is to ignore the value of CPUTIN and =
use the
>     "PECI
>     > =A0 =A0 Agent 0"
>     > =A0 =A0 temperature instead.
>     >
>     >
>     >
>     > I am now confused ?
>     > I do not know technical details but according to ASUS technical sup=
port
>     > CPUTIN is temperature of motherboard (not cpu socket , not cpu your=
self )
>     > what exactly this temperature means ?
>     >
>     From looking into the OHM source, motherboard temperature is SYSTIN, =
not
>     CPUTIN.
>     Some but not all boards have AUXTIN connected as well. CPUTIN does no=
t seem
>     to be used at all on ASUS boards as far as I can see.
>=20
>=20
>=20
> I am sorry but when I compare my AI Suite monitor (I attached picture) (-=
 60
> Celsius)=A0 with psensor ( - 60 Celsius) =3D> CPUTIN correspond with moth=
erboard
> temperature and technical support saying the same thing (even if I have to
> admit that according to name convention it should be as you said). And AU=
XTIN
> has asus motherboard maximus iv extreme - psensor is showing 33.5 Celsius=
 - no
> problem with that.

Judging from the OHM source, it looks like some Asus boards have AUXTIN con=
nected,
others don't. -60 degrees C suggests that there is nothing connected to the=
 sensor pin.

> where did you get exactly those information about what is what ? Could yo=
u put
> some URL or documentation ?

Open Hardware Monitor source code, http://open-hardware-monitor.googlecode.=
com/svn.

I don't see CPUTIN on your screen shot. I only see "CPU" and "CPU socket", =
but I don't see
anything suggesting that those report the temperature as measured on the CP=
UTIN pin
of the NCT6776F. To know how the values reported by the AI suite map to boa=
rd sensors,
it would be necessary to see its source code and/or configuration files.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
