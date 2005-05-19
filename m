From: robs@multiplayer.it (Roberto Sebastiano)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: today CVS compilation bug
Message-Id: <1070192499.553.4.camel@newdeal>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Today CVS doesn't compile when running make user
It loops forever

The problem is that some files have timestamp in the future

A touch of all the tree corrected the problem

Cheers,
--=20
Roberto Sebastiano <robs@multiplayer.it>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Questa parte del messaggio =3D?ISO-8859-1?Q?=E8?=3D firmata
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031130=
/5c79735b/attachment.bin
