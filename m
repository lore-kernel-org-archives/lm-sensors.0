From: Alun Evans <alun@badgerous.net>
Date: Thu, 30 Jan 2014 18:52:50 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <232EEFA6-90E9-4B94-82B6-2C3E81299D23@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8361320966330943103=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============8361320966330943103==
Content-Type: multipart/signed; boundary="Apple-Mail=_4503ADE9-71F2-4008-86C8-01CD76319CD3"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_4503ADE9-71F2-4008-86C8-01CD76319CD3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On 30 Jan 2014, at 09:01, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 29 Jan 2014 19:23:23 -0800, Alun Evans wrote:
>> Seemingly though IPMI is going via the BMC chip over an I2C bus to =
pull the temperatures from the DIMMs.
>>=20
>> I wonder if I=92m meant to be going that way as well to get the =
access to that I2C bus.
>=20
> Well, as a side note, mixing IPMI and native access is not a good idea
> anyway. So if you intend to use IPMI I suppose you should stick to =
that.

Yeah, I even tried:

> BMC Enable/Disable (JPB1)
>=20
> JPB1 is used to enable or disable the BMC (Baseboard Management =
Control) chip and the onboard IPMI port. This jumper is used together =
with the IPMI settings in the BIOS. See the table on the right for =
jumper settings.

But that didn=92t seem to help.

I=92m going to shelve this project for now until I get a better contact =
in supermicro.

Thanks for all the help, I=92ll followup when (if?) I eventually make =
some progress on this.


A.

--=20
Alun Evans

--Apple-Mail=_4503ADE9-71F2-4008-86C8-01CD76319CD3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLqn4IACgkQDX2x+/Q7Ga0YmgCfXEbffD4opzvWVFRH808aAVho
CtIAoJwxTeUC6/WsCxsAsnqlOX1Lev6b
=yJHG
-----END PGP SIGNATURE-----

--Apple-Mail=_4503ADE9-71F2-4008-86C8-01CD76319CD3--


--===============8361320966330943103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8361320966330943103==--
