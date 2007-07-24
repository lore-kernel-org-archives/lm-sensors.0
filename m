From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 24 Jul 2007 18:19:58 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <20070724181958.GG19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4910500029664018488=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============4910500029664018488==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2007 at 07:13:52AM +0200, Hans de Goede wrote:
> I think this will be rather tricky, its esp tricky to define what is a sa=
ne=20
> value.
<snip>
> -Notice that the msleep, now will only be triggered if update_device gets
>  called within TEMP_COLLECTION_TIME of driver loading, assuming that
>  REFRESH_INTERVAL > TEMP_COLLECTION_TIME. I did it this way hoping that t=
he
>  startup scripts of the PC will have enough time between insmod and the=
=20
>  first
>  read, thus not delaying PC startup.

As I understand your pseudocode, you want to start the temperature
reading at the end of a call to update_device and init, and pick up
the temp values the next time update_device gets called, sleeping as
necessary.  I've a few questions about this approach:

(1) Each sysfs attribute calls update_device before calling sprintf
to write the sysfs attribute.  If a user decides to read all sysfs
attributes at once (for example, via that grep trick), won't this
cause a new round of temperature sensor reading every time a sysfs
attribute is read, as well as a sleep for the next sysfs attribute read?

(2) Let's say a user reads a sensor and causes the temperature sensors
to start reading.  Then, the user goes to sleep for an hour, and reads
the temperature sensor via sysfs.  Since the last temperature sensor
refresh was an hour previously, won't this cause the user to see
temperature readings that are an hour old?

(3) If the startup scripts load the driver and immediately begin
querying the sensor readings, the scripts will take the msleep hit
anyway.

> In a releated note, depending on where the 0ther 0.7 seconds are, you cou=
ld=20
> try todo less reading, for example each time you start / stop the temp=20
> reading you first read the cfg register, why not just use a cached value,=
=20
> is there a reason to assumee it will change? Esp when stopping I would be=
=20
> using the value already read when starting (in the current code).

I suspect that would work fine.  It looks like the bits in the config
register only get changed by the driver, so I'd only need to read it
once.

> Also you read the limits and other non sensor reading registers each=20
> update, why not just read these once at driver initialisation, is there a=
=20
> reason to assume they will change?

Nope.  I can make these two changes.

> I saw your longer read intervals and make temps signed patches, since the=
=20
> driver hasn't been merged yet, maybe its a good idea todo a v4 ?

Not hard, though I'll have to collapse the two subsequent incremental
patches.  It'd be less work to just make one more incremental patch and
send the entire patchset to lm-sensors.

--D

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGpkLOa6vRYYgWQuURApV0AJ4p9sscC84352pFjRfE3I56pjnB2ACfeYps
lRh6fEQCGpRWHfAcfEMjNlI=
=O234
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--


--===============4910500029664018488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4910500029664018488==--
