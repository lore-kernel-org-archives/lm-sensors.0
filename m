From: magnus.f@telia.com (=?iso-8859-1?Q?Magnus=20Forsstr=F6m?=)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <200308130657.h7D6vhi18030@d1o403.telia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>=20
> (Message received 12 times, what happened?)
Nothing happened when I pressed the send button. But it seems like
something did happen...
>=20
> Could you try setting some limits (through the config file or manually,
Tried setting both critical and high. When temp was over high I got:
temp1:       +38=B0C  (limit =3D  +47=B0C, critical =3D  +60=B0C)   ALARM

I had a look at the wiring diagram and all D+ ports are wired together.
But as said before the temperatures differ with as much as 7 degrees
within a single reading I find that hard to believe.

Magnus
