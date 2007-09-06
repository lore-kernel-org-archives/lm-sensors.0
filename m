From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 06 Sep 2007 07:21:35 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <46DFAA7F.2060803@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> I just installed the patch on my BE-2350 system and the results seem reasonable.
> Does this mean that the hardware sensor itself is broken and that the results
> are reasonable by chance?

No it seems that only certain CPUs have problems. If it is reasonable than it
probably works. What is your CPUID? (cat /proc/cpuinfo or run cpuid util)

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG36p/3J9wPJqZRNURAvveAJ93MDSGly9HBs4LQyO6PI56Hqc4hACeMs/h
C5dEUHaCnW5Mlf44yezRq88=Vm+M
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
