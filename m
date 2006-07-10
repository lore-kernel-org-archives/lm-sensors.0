From: anders@anduras.de (Sven Anders)
Date: Mon, 10 Jul 2006 20:31:31 +0000
Subject: [lm-sensors] Patch to fully support W81791D
Message-Id: <44B2B923.3080200@anduras.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
In-Reply-To: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Sven --
>=20
> I'm a little confused. There is a patch already going into the 2.6
> tree to include 83791d support (see
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016638.html).
>=20
> Looking at this patch you are touching the w83781d driver and you
> mention the 2.1.18 kernel. Is this meant for an older kernel? Was this
> meant for the 2.6 kernel? And if it is meant for the 2.6 kernel, does
> it do something more or better than the one listed in the url above?

Hello,
this must be a misunderstanding. This patch is for the lm_sensors Package,
not for the kernel. It adds the output for the additional sensors, that
were missing in the "sensors" program.

I know that the kernel driver will be included in the next stable kernel.
I only sent the sensors-patch to keep you informed.
(A patch for the kernel-driver will follow... ;-))

Regards
 Sven Anders

- --
 Sven Anders <anders at anduras.de>                 () Ascii Ribbon Campaign
                                                 /\ Support plain text e-ma=
il
 ANDURAS service solutions AG
 Innstra?e 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-=
55
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsrkh5lKZ7Feg4EcRAikPAKCW6lDNbRF+utIIgwOPscNNnYhdLQCdHv0q
eC6dbekAhtlWw4TB7fuHyD8=F7nC
-----END PGP SIGNATURE-----
-------------- next part --------------
A non-text attachment was scrubbed...
Name: anders.vcf
Type: text/x-vcard
Size: 339 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060710=
/278c172e/attachment.vcf=20
