From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 20:07:38 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <20070716200738.GA2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4490268310067424324=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============4490268310067424324==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2007 at 07:22:41PM +0200, Hans de Goede wrote:
> Hmm,
>=20
> I see it refresh the readings every 2 seconds, since reading things takes=
 1=20
> sec minimum, I think it would be a good idea to make this somewhat bigger=
=2E=20
> Darrick, can you post a new version and or an incremental patch with a=20
> slower read frequency, say once every 5 or 10 seconds?

Will do.  The data sheet says you have to wait 200ms *
number_of_temperature_sensor_chips.  Unfortunately, there's no way to find
out how many sensor chips there are before you read them, but 1s seemed to
work ok for all my systems.  I suppose I could modify the init function
to do the read once with the long delay, then lower it to 200ms *
however many temperature sensors read a "sane" value.

> Also I notice that you are still doing a full read of the chip to=20
> data->raw, this might very well explain some if the slowness. Please remo=
ve=20
> raw[] from data and the full read code from the update() function.

That was pulled from v3.

--D

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm9AKa6vRYYgWQuURApG/AJ4l5cr+73JC1DJ0dqmqxzX5YXuvdgCgp1Sr
LbSnkeP5PpZHHiRzG+G+jec=
=YV2l
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


--===============4490268310067424324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4490268310067424324==--
