From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 14 Sep 2012 16:08:00 +0000
Subject: Re: [lm-sensors] pmbus-questions
Message-Id: <20120914160800.GA13185@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF6A0069A8.54748E02-ONC1257A79.002B4CFE-C1257A79.0033BD0D@transmode.se>
In-Reply-To: <OF6A0069A8.54748E02-ONC1257A79.002B4CFE-C1257A79.0033BD0D@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Sep 14, 2012 at 11:25:07AM +0200, =C5sa Uhrenius wrote:
> Hi,
>=20
> I have some questions concerning pmbus. If you are not the persons I=20
> should contact concerning this please let me know and advise me to whom I=
=20
> should send this.
>=20
> Questions:
> Is it correct that pmbus is used for monitoring only and can't be used fo=
r=20
> writing data to a pmbus compatible devices?=20
> If so, are there any plans to include writing capability and when if=20

Yes and no. You can write data, but writes are limited to setting limits.

> that's the case?
>=20
> The reason to my questions is that I would like to write a powerlevel to =
a=20
I assume you refer to setting power levels.

There are a number of answers to that.

First, so far there has to be demand. My need and the need of others using =
the
pmbus driver is for monitoring purposes, so there was no need to add suppor=
t for
actually regulating power levels.

Adding support for setting power levels can be done. It would, however, req=
uire
the driver to be reworked as multi-function driver, with hardware monitorin=
g and
(probably) regulator sub-drivers. That is a substantial effort, for which I=
 don't
have time for right now. That doesn't mean it won't happen, but unless my e=
mployer
decides to assign such a task to me (which is highly unlikely), someone els=
e would
have to pick it up and submit patches.

That leads to the next, and more substantial, set of problems: The ability =
to
modify power levels is nice, but if misused can lead to physical damage to =
the
board. After all, PMBus chis are typically not used to set, say, battery po=
wer
levels, but to provide power to on-board components. Adding support for man=
ipulating
such power levels would have to be done very carefully. In addition to that,
power level manipulation is an area which is not too well defined in the PM=
Bus
standard. For some chips, it is just a matter of changing the expected power
level registers. Other chips need to follow an elaborate sequence of comman=
ds,
and it is effectively only possible to change the power level on those chip=
s with
the tools provided by the chip manufacturer. Everything else tends to cause=
 such
chips to shut down, or in bad cases to literally blow up. So this is someth=
ing I
would only want to get into on a per-chip basis, and only permit it if I am
really sure that this specific chip does support "simple" means to set the =
power
level.

Another question is _why_ you want to be able to set the power level. If it=
 is
for diagnostics purposes, you might be better off by writing the required I=
2C
commands directly into the chip, eg with the i2cset command from i2c-tools.

Hope this helps,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
