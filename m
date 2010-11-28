From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 28 Nov 2010 23:06:41 +0000
Subject: Re: [lm-sensors] Intel Atom N550 coretemp
Message-Id: <20101128230641.GA14343@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF2D0A5.4000502@umail.ru>
In-Reply-To: <4CF2D0A5.4000502@umail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Nov 28, 2010 at 04:59:01PM -0500, Owl wrote:
> Hi. My Atom N550 still show me wrong temperatures:
>=20
> gentoo ~ # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +15.0=B0C  (crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +20.0=B0C  (crit =3D +100.0=B0C)
>=20
> Real temperature according to BIOS - about 40-45.
>=20
All you need to do is to adjust the reported vales with an entry in sensors=
.conf.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
