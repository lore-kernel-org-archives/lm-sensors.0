From: Micah Gersten <micahg@ubuntu.com>
Date: Tue, 14 Jun 2011 05:29:49 +0000
Subject: [lm-sensors] sensors-detect won't recognize 3.0 kernel
Message-Id: <4DF6F1CD.9030001@ubuntu.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I filed this bug [1] in Launchpad for Ubuntu and attached the
following patch:


+--- lm-sensors-3-3.2.0.orig/prog/detect/sensors-detect
++++ lm-sensors-3-3.2.0/prog/detect/sensors-detect
+@@ -2258,7 +2258,8 @@ use vars qw(@kernel_version $kernel_arch
+
+ sub initialize_kernel_version
+ {
+-      `uname -r` =3D~ /(\d+)\.(\d+)\.(\d+)(.*)/;
++      #Third decimal only for point releases starting with 3.0
++      `uname -r` =3D~ /(\d+)\.(\d+)(\.(\d+))?(.*)/;
+       @kernel_version =3D ($1, $2, $3, $4);
+       chomp($kernel_arch =3D `uname -m`);
+

Thanks,
Micah

[1] https://bugs.launchpad.net/bugs/797001
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk328b0ACgkQTniv4aqX/VnAnACfXxwI1xGCCprG6BLkcV1gEimL
ncEAnjSJ1pPDfE33tLwe9P4SI9ls9xin
=8AqL
-----END PGP SIGNATURE-----


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
