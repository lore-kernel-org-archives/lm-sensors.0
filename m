From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 10 Jul 2007 18:59:39 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070710185939.GL3435@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7903301450251827326=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============7903301450251827326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="citGix+cyBYE+lqp"
Content-Disposition: inline


--citGix+cyBYE+lqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2007 at 10:21:57AM +0200, Hans de Goede wrote:

> Hi,
>=20
> Below is a review of your driver.

Thanks for taking the time to review it.  In general I've found the
points you make are pretty good and have implemented them.  That said,
there were a few that I have some questions about, so I'll skip down to
those.  I intend to post a revised patch shortly, and review your driver
after that.

> Why all the base defines? Why not put the base address directly in the ()=
=20
> macros? You do not seem to use them anywhere else.

I prefer to put all the register and bit-field definitions in one place
so that later I can construct a map of all known registers after I've
forgotten which ones the driver talks to and which ones it doesn't.  The
accessor macros that come after that are merely sugar, which is why I
don't like encoding the base register address directly into the macro.

> Are you sure you only want to support revision 2? What are the difference=
s?=20
> Shouldn't the driver be able to support other revisions too? Maybe only=
=20
> print a warning when its used with an untested revision?

I don't have a data sheet for other revisions, so the safest thing to do is
to reject that which we don't know about; an interested user can always
bypass those safety checks with force_adt7470=3D at a later point in time
and post a patch if the driver still works ok.

> Why use read_byte twice in read16, but write_word in write16?

A "16 bit" register is really two 8 bit register reads/writes, and the
register with the lower address has to be read/written first.  Hence the
weird helper functions.

> >+		/* delay is 200ms * number of tmp05 sensors */
> >+		udelay(TEMP_COLLECTION_TIME);
>=20
> ugh, sleep here please.

Would msleep_interruptible() work here?  Some informal testing shows
that it seems to work ok, though I've not subjected it to a rigorous ^C
test to see if I can hit weird crash conditions.

> This may be a stupid question (I haven't fully read the datasheet) but wh=
y=20
> no store functions for fan_min and fan_max?

Silly thinko on my part; the v2 patch will have those store functions.

> Maybe just but all the sensor_attr directly into an array and use a for=
=20
> loop on that array to register / unregister instead of sysfs attribute=20
> groups?

I implemented that, using your f71882fg driver as an example.

--D

--citGix+cyBYE+lqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGk9cba6vRYYgWQuURAhbSAJsH1uVejzExDsdVywnhV9VEa971rgCfSZyj
Alh6RcqQa2Pf6yT1GPNkH0M=
=nHBu
-----END PGP SIGNATURE-----

--citGix+cyBYE+lqp--


--===============7903301450251827326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7903301450251827326==--
