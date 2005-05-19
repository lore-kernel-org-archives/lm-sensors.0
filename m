From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: New HP system
Message-Id: <20021107155802.6373b674.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021106223455.69c7e794.khali@linux-fr.org>
In-Reply-To: <20021106223455.69c7e794.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> I have it. It's an Itanium-2 (IA-64)!
Interesting :)

> dmidecode runs and generates NO output.
Bad. Which version of dmidecode are you using?

> I tried dd if=3D/dev/mem ... and it crashed the machine.
Even worst. What dd command did you try exactly? Which kernel are you
running? It may be an issue with the block size (else dmidecode should
crash the machine too). Maybe you could try the following one:
dd if=3D/dev/mem of=3Dwhatyouwant bs=3D1k skip=960 countd
I hope it will let us get the F000 segment.

It looks like the problem is known. See:
http://www.redhat.com/mailing-lists/ia64-list/msg00974.html
No solution though. Maybe you could take your chance on LKML.

See also:
http://people.debian.org/~branden/sid/xfree86_4.2.0-0pre1v3_ia64.changes
Could mean that you can't access low memory on Itanium (which should in
no way result in a crash, of course, but may explain what happened)

> I could try strace dmidecode, for example.
Let's try the other things first (latest version of dmidecode if
possible, biosdecode, dd and lkml). Then, if all of these failed, we'll
try strace.

Btw, does i2c/lm_sensors works on the machine?

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
