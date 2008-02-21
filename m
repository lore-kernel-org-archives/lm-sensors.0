From: Christian Krafft <krafft@de.ibm.com>
Date: Thu, 21 Feb 2008 10:02:55 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <20080221110255.365f0a46@de.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4708755697598006814=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============4708755697598006814==
Content-Type: multipart/signed; boundary="Sig_/eVSBe/N3UPgv0k8r7Vv6KTs";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/eVSBe/N3UPgv0k8r7Vv6KTs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jean,

I will try to test your patch today, but only have a little time for this.
If I'm not getting it today, I'll continue next monday.

I'm not very convinced, that this is the right solution, but as a
circumvention, it will take the pressure away.

Cheers,
Christian

On Wed, 20 Feb 2008 20:07:42 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> On Mon, 18 Feb 2008 22:33:17 +0100, Jean Delvare wrote:
> > Hi all,
> >=20
> > As a follow-up of this discussion on LKML:
> >   http://lkml.org/lkml/2008/2/13/390
> > I would like to propose the following patch to sensors-detect:
> > (...)
> > The idea is to skip "random" I/O port probing on PPC, as it won't find
> > anything anyway and can cause the kernel to oops.
> >=20
> > Christian, can you please test this patch and confirm that it solves
> > your problem?
>=20
> My patch wasn't correct, I forgot to chomp the trailing new line
> returned by uname -m. I've just committed a working fix to SVN, please
> try this instead.
>=20


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294

--Sig_/eVSBe/N3UPgv0k8r7Vv6KTs
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHvUyJ6rqK4qDx+dcRAnC5AKDZIZeL4AN5e4HTUwWc6MmaCWxpcwCfURlL
D9kTih34fpABNKU0rR9W4S0=
=yR3W
-----END PGP SIGNATURE-----

--Sig_/eVSBe/N3UPgv0k8r7Vv6KTs--


--===============4708755697598006814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4708755697598006814==--
