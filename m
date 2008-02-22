From: Christian Krafft <krafft@de.ibm.com>
Date: Fri, 22 Feb 2008 10:18:48 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <20080222111848.4d898999@de.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6502661840163309183=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============6502661840163309183==
Content-Type: multipart/signed; boundary="Sig_/WvN_UZR6TrS3kuVGtls+UpB";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/WvN_UZR6TrS3kuVGtls+UpB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ben,

regarding your problem with poking into PCI ranges:
As arnd mentioned, we could check, wether there is a mapping for that addre=
ss
and if so, allow the access. That could be done in check_legacy_ioport,
although the name looks a bit misleading.
What do you think ?

On Fri, 22 Feb 2008 18:21:23 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>=20
> Christian, can you re-send me that patch ?
>=20
> Ben.

Sure, patch was as trivial as this:


sensors_detect crashes kernel on PowerPC, as it pokes directly to memory.
This patch adds a check_legacy_ioports to read_port and write_port.
It will now return ENXIO, instead of oopsing.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux.git/drivers/char/mem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.git.orig/drivers/char/mem.c
+++ linux.git/drivers/char/mem.c
@@ -566,8 +566,13 @@ static ssize_t read_port(struct file * f
 	char __user *tmp =3D buf;
=20
 	if (!access_ok(VERIFY_WRITE, buf, count))
-		return -EFAULT;=20
+		return -EFAULT;
+
 	while (count-- > 0 && i < 65536) {
+#ifdef CONFIG_PPC_MERGE
+		if (check_legacy_ioport(i))
+			return -ENXIO;
+#endif
 		if (__put_user(inb(i),tmp) < 0)=20
 			return -EFAULT; =20
 		i++;
@@ -585,6 +590,7 @@ static ssize_t write_port(struct file *=20
=20
 	if (!access_ok(VERIFY_READ,buf,count))
 		return -EFAULT;
+
 	while (count-- > 0 && i < 65536) {
 		char c;
 		if (__get_user(c, tmp)) {
@@ -592,6 +598,10 @@ static ssize_t write_port(struct file *=20
 				break;
 			return -EFAULT;=20
 		}
+#ifdef CONFIG_PPC_MERGE
+		if (check_legacy_ioport(i))
+			return -ENXIO;
+#endif
 		outb(c,i);
 		i++;
 		tmp++;


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

--Sig_/WvN_UZR6TrS3kuVGtls+UpB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHvqGJ6rqK4qDx+dcRAiMKAJoDpX89E0gcCmn12acSvL1RmHD0qwCgq7mv
pjFPp8XXQGxYs+u02gd6N+Q=
=pPvH
-----END PGP SIGNATURE-----

--Sig_/WvN_UZR6TrS3kuVGtls+UpB--


--===============6502661840163309183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6502661840163309183==--
