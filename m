From: Felipe Balbi <balbi@ti.com>
Date: Thu, 11 Aug 2011 18:55:59 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <20110811185558.GC15970@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3253312304800793054=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-7-git-send-email-j-keerthy@ti.com>
 <20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
 <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
 <20110811103658.GG27742@legolas.emea.dhcp.ti.com>
 <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
 <20110811141248.GK28500@legolas.emea.dhcp.ti.com>
 <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
 <20110811185408.GB15970@legolas.emea.dhcp.ti.com>
In-Reply-To: <20110811185408.GB15970@legolas.emea.dhcp.ti.com>
To: Felipe Balbi <balbi@ti.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com


--===============3253312304800793054==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 11, 2011 at 09:54:09PM +0300, Felipe Balbi wrote:
> > > you need some other way to handle this. Why do you need to manually s=
et
> > > the rate rather than having hwmod handle this for you ?
> > >
> > > your argument that "it's a one time setting" is not enough to have th=
is
> > > in the driver. Drivers should not care about clocks anymore, this sho=
uld
> > > have been done on another layer.
> >=20
> > Hwmod will have no idea on the rate required.
>=20
> does the rate need to change ? Also, I have not mentioned hwmod anytime

i did mention hwmod, nevermind that part. Still I'm not sure where is
the right place to handle this.

--=20
balbi

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJORCW+AAoJEAv8Txj19kN1CwcH+gK05kR/ep9E20LVkrDb5T/M
dmj6mh0LTSPD2Ms7F2FxXB56x6uEN+DAGFsriQjU/q72L5hWmU2NtCYuCnTtlJna
iHBl3boIpYcRfxpQ6El+qBQS/ssHrUcRMSzdg1uhblJrfZ60fSAVawieOnjkog9z
41X2G2L+vBfJ0mUVfq9Yspk5oqWFa/X8ARtOQVzrdK46TbLxj9NAXTGXdDzf311Q
sX6Djtiv2/pyeSpN88etx5M8WzM3rhzQwu2Zw/4WFMeKOlRY6HFodlarXkSbRZiW
CHcGaMT67CuA+SA09aXH/exL9rGpB+5sog6NhGFAAF6JQRGkobyw8aINnYi3LfU=
=N8QL
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--


--===============3253312304800793054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3253312304800793054==--
