From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Sep 2012 18:21:48 +0000
Subject: Re: [lm-sensors] Core2Quad and very hight temperature
Message-Id: <20120927182148.GA26620@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <92013948.11222.1348656112623.JavaMail.open-xchange@atlas>
In-Reply-To: <92013948.11222.1348656112623.JavaMail.open-xchange@atlas>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Sep 27, 2012 at 07:33:38PM +0200, Markus Rupprecht wrote:
> Hi,
>=20
Hi Markus,

please don't drop the mailing list in your replies.

> now I can say: you are right.
>=20
> When I buy a new server, I always buy a second one for the case of
> a failure. Now our server had a failure and I used the backup
> system. Today our first server was back repaired and I  backuped
> back after the school was closed and now I use the original server,
> again. There is no Problem when using sensors anymore. No error
> warning.
>=20
> Am 27.09.2012 15:54, schrieb Guenter Roeck:
> >
> >Looking on the web, thermal problems with the Q6700 are commonly blamed =
on the
> >heatsink (the Intel one seems to be considered marginal) and/or the ther=
mal
> >compound. Someone noted that running the CPU above 70C for a long period=
 of time
> >would reduce its lifespan.
> Ohh. I guess I saw about 70=B0C today. But no more 100=B0C or negative nu=
mbers.
>=20
Ok for high load, but idle temp should be 40-50.

> >
> >I think you should definitely take the system apart, apply a new layer
> >of thermal paste, and make sure that the heatsink is properly seated whe=
n you
> >put it back together.
>=20
> After using the original server I was able to take a closer look to
> the backup system and you were right: two of four screws holding the
> cooler were loose fitting  and furthermore the company who build the
> server did something wrong with the mounting. The replaced one
> plastic spacer with paper. Never saw something like this from
> "Alternate.de" Arghhhh.
>=20
> Now I will buy a new cooler and will check, if the cpu is damaged.
> The server was running, but I will look, if I get good sensor
> values. If it is still -0,17 or something: Do I have to replace the
> cpu, or is it possible, that the mainboard is broken?
>=20

CPU, unless someone managed to mechanically break something on the board
(paper spacer and loose fitting cooler screws doesn't sound good).
You should notice if the CPU is broken with erratic crashes, though.

I would suggest to inspect the mainboard to see if something is broken off.

> My headmistress will like it ;-(
>=20
Good luck!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
