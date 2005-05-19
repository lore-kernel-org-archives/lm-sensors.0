From: magnus.f@telia.com (=?iso-8859-1?Q?Magnus=20Forsstr=F6m?=)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <200308131040.h7DAe4529673@d1o403.telia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> > > Could you try setting some limits (through the config file or
> > > manually,
> > Tried setting both critical and high. When temp was over high I got:
> > temp1:       +38=B0C  (limit =3D  +47=B0C, critical =3D  +60=B0C)   ALA=
RM
>=20
> I don't understand. In this example, 38 < 47 and 38 < 60 so no alarm
> should trigger at all - yet the high alarm seems to be set. Looks like a
> bug in my driver :(
No the temperature has been over the high limit since the last reading.
I temporarily changed the limit to 40 and then back to 47. Since the
temperature is not constant an alarm has been generated.
>=20
> > I had a look at the wiring diagram and all D+ ports are wired
> > together. But as said before the temperatures differ with as much as 7
> > degrees within a single reading I find that hard to believe.
>=20
> Sure, I just can't believe it. BTW, where did you got that diagram?=20
It comes from the manufacturer. I assume that we have made a special
request that they should supply us with a wiring diagram.

/Magnus
