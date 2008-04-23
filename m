From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 23 Apr 2008 20:50:27 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <480FA113.8010509@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I checked the DSDT as soon you would not use that driver you are safe to use the
 driver you are using right now.

        OperationRegion (HWRE, SystemIO, IOHW, 0x0A)

The operation region is 0x290-0x29A dont know how the reported line got to 299

[   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI
region HWRE [0x290-0x299]

The ATK driver has no extra funcs then the classic driver so I think you can use
 what you have right now.

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFID6ES3J9wPJqZRNURAj5jAKC4aIahXy33hUE43/DXE9v2lkgVqACg3ENH
M7UTHWnkLiiUtExM9ghPi3I=gBbK
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
