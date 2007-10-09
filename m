From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Tue, 09 Oct 2007 14:59:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm78 and w83781d: Probe fewer
Message-Id: <20071009145910.GF13822@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8919439144809825245=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007122546.3f8b4d18@hyperion.delvare>
In-Reply-To: <20071007122546.3f8b4d18@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============8919439144809825245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2007 at 12:25:46PM +0200, Jean Delvare wrote:
> We've never seen any device supported by the lm78 or w83781d driver
> at addresses 0x20-0x27, so let's stop probing these addresses. Extra
> probes cost time, and have potential for confusing or misdetecting
> other I2C devices.

If the addresses are _theoretically_ possible (as per datasheet)
wouldn't it be good to have an option to override this?
Something like scanall=3D1 or similar? Or maybe that option already exists?

=20
Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHC5c+XdVoV3jWIbQRAmcIAJ4lpy2tzi1CjExdZm005LEL4xP4MgCeOKSV
4+Rhma3GbxekWbZT9abkzPA=
=66tq
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--


--===============8919439144809825245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8919439144809825245==--
