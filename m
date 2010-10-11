From: Simon Guinot <simon@sequanux.org>
Date: Mon, 11 Oct 2010 14:25:58 +0000
Subject: [lm-sensors] hwmon and GPIO fan
Message-Id: <20101011142558.GD13596@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3494989347740684991=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============3494989347740684991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am currently looking to add hwmon support for the fan device found on
Network Space Max v2 boards (ARM Kirkwood SoC).

The fan speed can be configured trough GPIOs. The GPIO settings allow to
change the fan input voltage (via some resistors).
After a quick look at the hwmon sysfs interface, I have failed to find
the appropriate way to expose a non-pwm fan. If any, what is the
dedicated sysfs entry to set speed for a non-pwm fan ?
Maybe that a fake pwm interface is needed ?

Thanks in advance.

Simon

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyzHnYACgkQgtp0PDeOcDr5MgCeKD/XwIH9ywF+ejytdA5nU+h8
6/4An2DKr/SwuenwAHSxSyZUTi1ywpYC
=t9W+
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--


--===============3494989347740684991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3494989347740684991==--
