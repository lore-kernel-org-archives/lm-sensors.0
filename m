From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 16 Feb 2008 18:40:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83793) VID and VRM handling
Message-Id: <47B72E13.30808@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080212112507.5c67cd0f@hyperion.delvare>
In-Reply-To: <20080212112507.5c67cd0f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean,

I tested on the W83793 system (remote booting with PXE and console on serial
port, busybox in initramfs)

It has no VIDA or VIDB, but the VRM file has gone. I checked the code and I
think there is no regression. Thank you!

Acked-by: Rudolf Marek <r.marek@assembler.cz>

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHty4T3J9wPJqZRNURAiMtAKDg9tK1a0AemXjADX83AJX03Ct/gwCeIc45
qcJgWlHXjfZsXAfDyMn+Jak=6sJ7
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
