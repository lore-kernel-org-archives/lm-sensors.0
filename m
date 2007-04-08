From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sun, 08 Apr 2007 08:33:48 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070408083348.GB12859@neu.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3659668472638064139=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
To: lm-sensors@vger.kernel.org


--===============3659668472638064139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2007 at 10:14:30AM +0200, Jean Delvare wrote:
> > 3. A merge is: find the differences between an old revision and a newer=
 one,
> > apply those differences to the target branch.  (I specify the target br=
anch
> > implicity in the following command, it's the branch of the CWD.)
> >=20
> > 	$ cd <working copy of 3.0.0 branch>
> > 	$ svn merge -r 4303:4355 http://lm-sensors.org/svn/lm-sensors/trunk
>=20
> What would have happened if some of the changes from trunk had been
> conflicting with changes in branch 3.0.0?
>=20
> It seems that we lose the history of changes when merging a branch, the
> logs only show the merge and not the individual log messages. Is this
> expected? I guess so :(

The problem is if you have two branches A and B and merge/copy over
parts of B onto A, then a file in A has semantically two histories,
one for the per-merge copy in A and one for the pre-merge copy in
B. Since the history of the B copy remains in B and also since the
true history of A !=3D B, there isn't much choice. It is also a conflict
of interests: The developer of branch A would like to see what changed
=66rom his POV, the one in B from his own.

But you do get a marker for copies or merges that you can follow to
fork off A's history into B's.
--=20
Axel.Thimm at ATrpms.net

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGGKjsQBVS1GOamfERAg2fAKCDLIB1yXLo6OYC9O2t5B/XeMDiIgCfSOoQ
3IdvqfRWWuH5UFwbDgOMw/8=
=v8kd
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--


--===============3659668472638064139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3659668472638064139==--
