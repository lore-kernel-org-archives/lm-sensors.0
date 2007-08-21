From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Tue, 21 Aug 2007 14:38:48 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <20070821143848.GE6770@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7476320489887797624=="
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
To: lm-sensors@vger.kernel.org


--===============7476320489887797624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2007 at 02:53:31PM +0200, Hans de Goede wrote:
> Let me check if I understand you correctly, you want to have a registrati=
on=20
> module, for users to register themselves as trac user, which has some spa=
m bot=20
> prevention methods, like sending a confirmation mail and maybe also such =
a=20
> picture with bad readable text? (which has a name I know, but not right n=
ow :)
>=20
> But wouldn't it be better to write such a thing in python and submit it f=
or=20
> upstream trac inclusion? Has anyone already searched the web to see if su=
ch a=20
> thing exists?

Yes, there are some attempts at a trac specific solution, but I was
thinking of a generic one, e.g. one that feeds an LDAP server and then
trac/mediawiki/moin/apache/you_name_it can simply query the login
credentials. That way this solution will be usable by far more than a
trac instance.

The LDAP part is dealt with at CLI level. What is missing is the Web
interface. I envision it as such:

 o User gives in data required, this would be Name (but split in
   first/last), email & password. This is protected by a
   (re)captcha. There is already a lib for PHP for recaptcha.
 o The system stores a cookie and sends the authentication code to the
   email specified (just like mailman)
 o The user clicks on the web authentication URL and the web app calls
   a cli app that creates the account

In our case the cli app will be pushing the credential data to an LDAP
server, another implementation could use htdiegst files, /etc/passwd,
(l)useradd etc.

It is not much different from what mailman does other than adding a
captcha.
--=20
Axel.Thimm at ATrpms.net

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGyvj3QBVS1GOamfERAqqTAJ0T2HpXtPymAU798GUOt0vyh4RmLgCfQCHd
2Ylqu2w3yg79goJ9Xlrjd3I=
=3bzY
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--


--===============7476320489887797624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7476320489887797624==--
