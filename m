From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: New HP system
Message-Id: <3DCEC71D.5AE317AD@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021106223455.69c7e794.khali@linux-fr.org>
In-Reply-To: <20021106223455.69c7e794.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I was using the old dmidecode.
I just tried the new 1.8 on all my machines.
It works fine, except on the ia64, for which it still exits silently
(after version output).

For dd I was using the args you gave me (bsdk, skip=14, count=3D2).
Using the new args below, it still crashes hard.
(don't worry, I've been crashing the heck out of it w/ IPMI modules
anyway)

I looked at the message link below, and yes, it identifies the problem
but
not the solution.

All the sensors on this machine are behind IPMI. I'm writing a dummy I2C
bus driver
which passes IPMI messages to the kernel IPMI driver developed by Corey
Minyard.
And a chip driver which dynamically queries the baseboard management
controller (BMC),
builds a table of sensors, and puts them in /proc/sys/dev/sensors as
usual.
It's a mess and a huge amount of work. I just got it working enough to
check something in.
I can see fan speeds and temperatures!
It's a long way from elegant at the moment.
I rigged Module.mk so it won't try to compile unless Corey's kernel
patch is installed and enabled.
Next is to add an i2c driver to expose the IPMB busses behind the BMC
for raw access.

Obviously, if there's anybody that has access to an IPMI machine for
testing let me know.

As for IA64, our stuff seems to compile and work fine. There's a fair
number of
compiler warnings about casts, alignments, etc.
I haven't gone through them yet to see exactly what the issue is or what
kind of casts to put into the code to fix/shutup the warnings.
But like I said, no ia64-specific issues yet.


Jean Delvare wrote:
>=20
> > I have it. It's an Itanium-2 (IA-64)!
> Interesting :)
>=20
> > dmidecode runs and generates NO output.
> Bad. Which version of dmidecode are you using?
>=20
> > I tried dd if=3D/dev/mem ... and it crashed the machine.
> Even worst. What dd command did you try exactly? Which kernel are you
> running? It may be an issue with the block size (else dmidecode should
> crash the machine too). Maybe you could try the following one:
> dd if=3D/dev/mem of=3Dwhatyouwant bs=3D1k skip=960 countd
> I hope it will let us get the F000 segment.
>=20
> It looks like the problem is known. See:
> http://www.redhat.com/mailing-lists/ia64-list/msg00974.html
> No solution though. Maybe you could take your chance on LKML.
>=20
> See also:
> http://people.debian.org/~branden/sid/xfree86_4.2.0-0pre1v3_ia64.changes
> Could mean that you can't access low memory on Itanium (which should in
> no way result in a crash, of course, but may explain what happened)
>=20
> > I could try strace dmidecode, for example.
> Let's try the other things first (latest version of dmidecode if
> possible, biosdecode, dd and lkml). Then, if all of these failed, we'll
> try strace.
>=20
> Btw, does i2c/lm_sensors works on the machine?
>=20
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
