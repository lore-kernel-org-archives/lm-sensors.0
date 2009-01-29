From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Thu, 29 Jan 2009 07:05:42 +0000
Subject: Re: [lm-sensors] spam
Message-Id: <20090129070542.GC32094@victor.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2423241013440742321=="
List-Id: <lm-sensors.vger.kernel.org>
References: <537C6C0940C6C143AA46A88946B8541710A4164D@ORNLEXCHANGE.ornl.gov>
In-Reply-To: <537C6C0940C6C143AA46A88946B8541710A4164D@ORNLEXCHANGE.ornl.gov>
To: lm-sensors@vger.kernel.org


--===============2423241013440742321==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2009 at 09:10:14AM +0100, Jean Delvare wrote:
> On Tue, 27 Jan 2009 00:04:16 +0200, Axel Thimm wrote:
> > On Mon, Jan 26, 2009 at 03:41:10PM -0500, Jean-Marc Spaggiari wrote:
> > > What appends to the blocked emails? Is there a place to check them and
> > > flag them as "non-spam" to have them sent to the list if needed?
> >=20
> > Posts with a spam score of higher than 5.0 get stuck in the moderator
> > queue.
>=20
> Really? I can't remember any message being moderated for this reason.
> The two reasons I see on a regular basis for messages that await
> moderation are: message has implicit destination and message too big.

Maybe most spam messages already fails these two before the spam
scoring filter sets in.

> > But even if it were rejected at least the valid sender with a
> > false positive would notice and rephrase the posting.
>=20
> What I would do is: messages with a high spam score get discarded, and
> messages with a moderate spam score are blocked until moderated. But
> apparently this is already what we have, so it's all OK?

No messages are being discarded automatically. A lot a rejected at
SMTP time, e.g. the sender gets "a message not sent" or similar from
his MUA/MTA (actually since there are 99.99% spam and the spambots
don't care about SMTP failures the error is not displayed to a human,
I wish it were. The rest of the 0.01% are people that reply to spam).
--=20
Axel.Thimm at ATrpms.net

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkmBVUYACgkQQBVS1GOamfEX+wCYo7GaYBcZNT6x1CY4MNjYRfFP
IACgl8dGWevldFbXSOkSmD6UovyLPOg=
=XCh6
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--


--===============2423241013440742321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2423241013440742321==--
