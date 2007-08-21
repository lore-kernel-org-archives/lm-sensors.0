From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Tue, 21 Aug 2007 17:38:08 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <20070821173808.GA32751@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5237450168841968902=="
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
To: lm-sensors@vger.kernel.org


--===============5237450168841968902==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 21, 2007 at 07:17:34PM +0200, Jean Delvare wrote:
> On Tue, 21 Aug 2007 16:38:48 +0200, Axel Thimm wrote:
> > Yes, there are some attempts at a trac specific solution, but I was
> > thinking of a generic one, e.g. one that feeds an LDAP server and then
> > trac/mediawiki/moin/apache/you_name_it can simply query the login
> > credentials. That way this solution will be usable by far more than a
> > trac instance.
> >=20
> > The LDAP part is dealt with at CLI level. What is missing is the Web
> > interface. I envision it as such:
> >=20
> >  o User gives in data required, this would be Name (but split in
> >    first/last), email & password. This is protected by a
> >    (re)captcha. There is already a lib for PHP for recaptcha.
> >  o The system stores a cookie and sends the authentication code to the
> >    email specified (just like mailman)
> >  o The user clicks on the web authentication URL and the web app calls
> >    a cli app that creates the account
> >=20
> > In our case the cli app will be pushing the credential data to an LDAP
> > server, another implementation could use htdiegst files, /etc/passwd,
> > (l)useradd etc.
>=20
> This sounds more complex than a trac-driven project should need.

I don't belive so. This is just a bullet-proof way of setting this up
and forgetting about it for the next couple of years. In the last
decade I've seen a lot of arms races between attackers and
defenders. Any obstructions gets bend sooner or later. I wonder why it
takes so long that bots start automatically subscribing themselves to
mailing lists.

> > It is not much different from what mailman does other than adding a
> > captcha.
>=20
> Do we really need a mail validation mechanism (as bugzilla and mailman
> do) AND a captcha? I thought that we only needed one method. I've
> always seen the captcha as a replacement for email validation when
> email validation is considered too much. In the case of trac we want an
> email address anyway (for ticket change notifications).

See above. You are correct for trac's needs today. But two years ago
people would had been laughing at you if you would talk about upcoming
wiki spam. I just want a solution I can really use and not need to
upgrade to a better one every couple months or so. That's also the
reason why the mailing list filtering is rather more sophisticated
than the usual protection methods. You invest once a little more and
then you relax for a longer while (until "they" catch up ...)

But I wouldn't be disappointed if someone writes a trac-only captcha
plugin either. trac-hacks has some starting implementations, also for
registration modules. The problem is that Darwinism prevails and what
is picked today may not be what will end up in trac proper.

Aynway my favourite is to have LDAP accounts created via a web form as
it also enables later adding existing people to the project in ssh
accounts and similar, e.g. people grow from wiki maintainers to
developers and have a single sign-on for all services.
--=20
Axel.Thimm at ATrpms.net

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGyyMAQBVS1GOamfERAnq2AJ4sEx7ulZ72cKmSBdo2VWPFBV09pACeJe6I
dP3h//UbG5VbiD74z1skmhQ=
=yjkK
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


--===============5237450168841968902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5237450168841968902==--
