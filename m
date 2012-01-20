From: Phillip Susi <psusi@ubuntu.com>
Date: Fri, 20 Jan 2012 19:11:48 +0000
Subject: [lm-sensors] Per motherboard config
Message-Id: <4F19BC74.7010506@ubuntu.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The default sensors3.conf does a good job configuring the sensors on a
per-chip basis, but there is a good deal of variation on a
per-motherboard basis as well.  Is it possible to key the config on
the motherboard model, and would there be any interest in gathering
known motherboard configs into the default sensors3.conf to do things
like hide sensors that are known to not be connected and thus have
invalid readings?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPGbxzAAoJEJrBOlT6nu75pGQIAI+rcJ2/8AGYJsr4Y01lUJmO
3tOINRMgGsuNvkZlE/JV8+cQmWced1gndNJk5VilioYmg1zco1oqi7D8gyRpCdXr
UeG2CE6S2buH4Jk6h6B6hHMOwV3TnVhvZV+v1xDeOHe4rkTR8WBqbJylzV98t6cy
NmBMlVXuAMLQB3hsyhNumFltyaX34smqx4HnB6pOpH/6WoCIuNHl7h88UUVF2iNK
Qlve9Ru3NfKI45zOV4L5R6ZZsPe3SqBkzZhK7LjWUjbx/gpEG/fb22DKsA0P0mVn
re1NKUKUPztVSpdpVBgw0jgEZmHp+5BjnqQ6Npwp/Dnf3BrCzZtIz7Vgap9CHow=Etu5
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
