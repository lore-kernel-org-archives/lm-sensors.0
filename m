From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 02 Apr 2007 12:01:41 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070402120141.GA4847@neu.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1171424574910424834=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
To: lm-sensors@vger.kernel.org


--===============1171424574910424834==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 02, 2007 at 01:36:49PM +0200, Jean Delvare wrote:
> On Mon, 02 Apr 2007 10:17:41 +0200, Hans de Goede wrote:
> > I've been really busy lately with Fedora related "work", but I hope to =
find the=20
> > time soon to start working on the dyn chip support. Most of the code is=
 already=20
> > tehre for the 2.x branch (written by my students). ANd my initial testi=
ng was good.
> >=20
> > This leads me to the following questions:
> > 1) What cmdline magic must I pass to svn to get the 3.x branch when che=
cking
> >     out?
>=20
> svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0=
=2E0

Hans, you should checkout the svnbook that you've been pointed
at. There is a section that explains svn for CVS people.

Branches and tags in svn are really nothing more than a folder. You
can argue that there are no branches and tags at all, if you
like. Which makes it quite easy to place your own organization of
things on top of it. You could rename "trunk" to "head" or remove it
altogether, if it doesn't fit your developing model.

svn is quite flexible. The basic operations concerning branches and
tags are simple copy operations.

> > 2) Do I need any cmdline magic to make sure a commit goes to the 3.x br=
anch?
> >     (I've bad experiences with this with CVS, where a commit would go t=
o the
> >      default branch even though I checkout another)
>=20
> I've never done that, so I can't say for sure, but I think svn will
> remember what branch you checked out from and you don't need to add any
> parameter. Mark, can you please confirm this?

See above. It is just a folder. And svn will remember what folder you
checked out like CVS does.

> > 3) Is it ok for me to just start committing this, or should I post it f=
or
> >     review here first?
>=20
> I am usually committing directly, except when I am not sure myself that
> this is the right thing to do, in which case I post on the list first,
> and then sometimes commit the change, sometimes not. So it's up to you,
> for changes you are sure of or that have already been discussed, just
> commit them, and use the list if you think something needs to be
> discussed first. Remember, the whole idea of a separate 3.0.0 branch is
> that you can put all your changes there quickly.
>=20
> Before you start really working on the 3.0.0 branch, we should sync it
> with the current trunk. Mark created the 3.0.0 branch quite some time
> ago, many fixes have gone into trunk since then, and I would hate to
> lose them. I don't know how this is done though. Mark, can you please
> take care of it? Maybe just kill the branch and recreate it?

Why not define that "trunk :=3D 3.x.x"? And only branch near a release?
Or do we need two different development areas?

Hans, whioch svn you can also create your very personal branch and
start playing in there. E.g.

http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0-hans

Once you're comfortable you can then either nuke it or merge back any
production commits back to the main branch or trunk.

> I also don't know how we are going to handle the later trunk changes,
> once 3.0.0 development is in progress. Some changes won't apply to the
> 3.0.0 branch (e.g. adding support for a new chip in libsensors) but
> many will.
>=20
> Once real work starts on this branch, it should be documented on our
> Download page how to get the code, if we want testers. It would also be
> convenient to have nightly snapshots as we do for the trunk version.
> Axel, can this be done?

Of course. Just say so, once you consider snapshoting to make sense.
--=20
Axel.Thimm at ATrpms.net

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGEPCgQBVS1GOamfERAmPyAJ42+c6u+lZEJYsWpTPNGVzspmOPvQCcDgUm
e/FoIBCcIehsVy5JYkVfgm4=
=6fDF
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--


--===============1171424574910424834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1171424574910424834==--
