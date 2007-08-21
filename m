From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Tue, 21 Aug 2007 10:35:48 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <20070821103548.GA6770@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4307379048532694819=="
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
To: lm-sensors@vger.kernel.org


--===============4307379048532694819==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2007 at 10:45:10AM +0200, Jean Delvare wrote:
> > I do have a friend who is a php guru who is willing to write a php driv=
en site=20
> > for us if we can provide him with proper specs.
> >=20
> > I can start writing a spec for the website as time permits, then discus=
s it=20
> > here, and once approved ask him to write it (under an OSS license of co=
urse).
>=20
> Writing it is one thing, hosting it is another. Axel, maybe I already
> asked, can't remember: can we host a PHP app on lm-sensors.org?

Sure, as long as someone manages the app and any involved security
issues. PHP is rather tricky and needs good care security-wise.

> > Another option would be to stay with the wiki, add some special
> > markup comments for the dmi strings and write a script to generate
> > a tarbal / "database" for the dmi based detect code. For me
> > putting the info in the wiki works well, its not like we are
> > getting multiple motherboard configs per day, and the wiki keeps
> > history which can be benifitial (a sufficiently advanced website
> > could do this too).
>=20
> I'd prefer a dedicated interface where anyone can contribute its
> configuration. The target configuration count is in hundreds if not
> thousands, that's not something we want to handle manually.
>=20
> That being said, if someone _else_ is going to take care, it doesn't
> matter that much to me ;) The usual open development rule applies:
> whoever does the job decides how it should be done. I simply haven't
> looked enough into it all yet, for now I'm focusing on getting
> libsensors4 ready so that we can release it before the end of the
> year.

I would also tend to recommend a wiki. The stumbing block is the spam
issue, and I think if we write a simple mailman like registration
module (for example in PHP :) we could have people register once and
then use wiki/trac/tickets/svn etc. as you like (not as flat as it
sounds, but with some lm-sensors heads elevating permissions as
needed, e.g. self-registration allows wiki/ticket editing, and svn
write access needs a bit flip by an lm-sensors leader etc)

Hans, maybe your PHP friend expert (is that Romain copied in the Cc?)
would be interested in this general purpose registration module
stealing some methods from mailman?
--=20
Axel.Thimm at ATrpms.net

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGysAEQBVS1GOamfERAnOyAJ0QgZpQgSkoTT/VPqWFD0FOwiY72QCggwsQ
vA35vL43OtlvOKo7Yophwy8=
=jotS
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


--===============4307379048532694819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4307379048532694819==--
